package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class GenerateMenuFiles extends GenerateBase {

//     TODO: Move table definitions into a separate class, as a step
//     towards being able to customize for a given chapter.

    // Define ordering of each field type

    private Comparator<String> intuitiveStringComparator = new IntuitiveStringComparator<String>();
    private Comparator<String> titleComparator      = Comparator.naturalOrder();
    private Comparator<String> publisherComparator  = Comparator.naturalOrder();
    private Comparator<String> genreComparator      = Comparator.naturalOrder();
    private Comparator<String> compatibleComparator = Comparator.nullsLast(intuitiveStringComparator);
    private Comparator<String> versionComparator    = intuitiveStringComparator.reversed();
    private Comparator<String> joystickComparator    = Comparator.naturalOrder();
    private Comparator<String> collectionComparator = Comparator.nullsLast(intuitiveStringComparator);

    // Define secondary tables

    private SecondaryTable shortPublishers = new SecondaryTableSingleValue(
            "ShortPublisher",
            new BitField(-1, 0, 6), // This is only used for size logging
            AtomTitle::getShortPublisher,
            new LinkedHashMap<String, Integer>()).excludeCounts();

    private SecondaryTable publishers = new SecondaryTableSingleValue(
            "Publisher",
            new BitField(2, 0, 6),
            AtomTitle::getPublisher,
            publisherComparator);

    private SecondaryTable genres = new SecondaryTableSingleValue(
            "Genre",
            new BitField(0, 3, 4),
            AtomTitle::getGenre,
            genreComparator);

    private SecondaryTable compatibles = new SecondaryTableSingleValue(
            "Compatible",
            new BitField(3, 5, 3),
            AtomTitle::getCompatible,
            compatibleComparator);

    private SecondaryTable versions = new SecondaryTableSingleValue(
            "Version",
            new BitField(3 ,0, 5),
            AtomTitle::getVersion,
            versionComparator);

    private SecondaryTable joysticks = new SecondaryTableSingleValue(
            "Joystick",
            new BitField(2 ,6, 2),
            AtomTitle::getJoystick,
            joystickComparator);

    private SecondaryTable collections = new SecondaryTableMultiValue (
            "Collection",
            new BitField(4, 0, 7),
            AtomTitle::getCollections,     // for indexing
            collectionComparator);

    private SecondaryTable[] secondaryTables = new SecondaryTable[] {
            shortPublishers,
            publishers,
            genres,
            compatibles,
            versions,
            joysticks,
            collections
    };

    // Define the title table

    private int titleHeaderSize = 4;

    // The ordering of this table doesn't actually make any difference, as it's always accessed via a sort table
    private TitleTable titleTable = new TitleTable(
            "Title",
            titleHeaderSize,
            secondaryTables,
            Comparator.comparing(AtomTitle::getTitle, titleComparator));

    // Define sort tables

    private SortTable[] sortTables = new SortTable[] {

            new SortTable("Title",
                    Comparator.comparing(AtomTitle::getTitle, titleComparator)),

            new SortTable("Publisher",
                    Comparator.comparing(AtomTitle::getPublisher, publisherComparator).
                    thenComparing(AtomTitle::getTitle, titleComparator)),

            new SortTable("Genre",
                    Comparator.comparing(AtomTitle::getGenre, genreComparator).
                    thenComparing(AtomTitle::getTitle, titleComparator)),

            new SortTable("Compatible",
                    Comparator.comparing(AtomTitle::getCompatible, compatibleComparator).
                    thenComparing(AtomTitle::getTitle, titleComparator)),

            new SortTable("Version",
                    Comparator.comparing(AtomTitle::getVersion, versionComparator).
                    thenComparing(AtomTitle::getTitle, titleComparator)),

            new SortTable("Joystick",
                    Comparator.comparing(AtomTitle::getJoystick, joystickComparator).
                    thenComparing(AtomTitle::getTitle, titleComparator)),


            new SortTable("Collection",
                    Comparator.comparing(AtomTitle::getCollectionFirst, collectionComparator).
                    thenComparing(AtomTitle::getTitle, titleComparator)),
    };

    private File archiveDir;
    private File menuDir;
    boolean agdChunk;
    private boolean allChunk;
    private Target target;
    private String chunk;

    public GenerateMenuFiles(File archiveDir, File menuDir, String chunk, Target target) {
        this.archiveDir = archiveDir;
        this.menuDir = menuDir;
        this.agdChunk = chunk.equals(IFileGenerator.AGD_CHUNK);
        this.allChunk = chunk.equals(IFileGenerator.ALL_CHUNK);
        this.target = target;
        this.chunk = chunk;
    }

    @Override
    public void setDebug(boolean debug) {
        super.setDebug(debug);
        titleTable.setDebug(debug);
        for (int i = 0; i < secondaryTables.length; i++) { // All tables
            secondaryTables[i].setDebug(debug);
        }
        for (int i = 0; i < sortTables.length; i++) { // All tables
            sortTables[i].setDebug(debug);
        }
    }

    private void buildIndexes(List<AtomTitle> atomTitles) {

        // ------------------------------------------------------------------------------------
        // Reset the secondary tables
        // ------------------------------------------------------------------------------------

        Map<String, String> longPubShortPub = new HashMap<String, String>();
        for (int i = 0; i < secondaryTables.length; i++) { // All tables
            secondaryTables[i].clear();
        }

        // ------------------------------------------------------------------------------------
        // Add the item metadata into the secondary tables
        // ------------------------------------------------------------------------------------

        for (AtomTitle title : atomTitles) {
            for (int i = 1; i < secondaryTables.length; i++) { // Skip first table (short pub)
                secondaryTables[i].addToIndex(title);
            }
            longPubShortPub.put(title.getPublisher(), title.getShortPublisher());
        }

        // ------------------------------------------------------------------------------------
        // Add sequential IDs to each of the secondary table entries
        // ------------------------------------------------------------------------------------

        for (int i = 1; i < secondaryTables.length; i++) { // Skip first table (short pub)
            secondaryTables[i].assignIndexes();
        }

        // ------------------------------------------------------------------------------------
        // Build the short publisher table so the key order is the same as the publisher table
        // ------------------------------------------------------------------------------------

        shortPublishers.clear();
        for (String key : publishers.keySet()) {
            if (longPubShortPub.containsKey(key)) {
                shortPublishers.put(longPubShortPub.get(key), publishers.get(key));
            }
        }

        // ------------------------------------------------------------------------------------
        // Log table contents for debug purposes
        // ------------------------------------------------------------------------------------

        if (debug) {
            for (int i = 0; i < secondaryTables.length; i++) { // All tables
                secondaryTables[i].dumpIndexes();
            }
        }
    }

    @Override
    public void generateFiles(List<AtomTitle> atomTitles) throws IOException {

        // Sort the master list in title order
        Collections.sort(atomTitles, Comparator.comparing(AtomTitle::getTitle, titleComparator));

        // Build the secondary tables (indexes)
        buildIndexes(atomTitles);

        // ------------------------------------------------------------------------------------
        // Decide where to place the various menu data segments
        // ------------------------------------------------------------------------------------

        int titleTableAddr;
        int titleTableSpace;
        int titleTableLen = titleTable.calculateSize(atomTitles);

        int sortTableAddr;
        int sortTableLen = sortTables[0].calculateSize(atomTitles);

        int menuTableAddr;
        int menuTableSpace;
        int menuTableHeader = 2 * (1 + secondaryTables.length); // pointers to title table and all secondary indexes
        int menuTableLen = menuTableHeader;
        for (int i = 0; i < secondaryTables.length; i++) { // All tables
            menuTableLen += secondaryTables[i].calculateSize(atomTitles); // Note, items is not used here, tables need to be pre-filled
        }

        if (allChunk) {
            // Avoid 0A00-0AFF (Disk Controller Window)
            // Avoid 1000-19FF (CHAPTER MENU)
            // Avoid 2000-2FFF (SDDOS Catalog Buffer)
            sortTableAddr   = 0x8000 - sortTableLen;
            titleTableAddr  = 0x2200;
            titleTableSpace = sortTableAddr - titleTableAddr;
            menuTableAddr   = 0x8200;
            menuTableSpace  = 0x9800 - menuTableAddr;
        } else if (agdChunk) {
            // Avoid 2800-31FF (CHAPTER MENU)
            // Avoid 2000-2FFF (SDDOS Catalog Buffer)
            sortTableAddr   = 0x9800 - sortTableLen;
            titleTableAddr  = 0x3200;
            titleTableSpace = 0x7000 - 0x3200;
            menuTableAddr   = 0x8200;
            menuTableSpace  = sortTableAddr - menuTableAddr;
        } else {
            // Avoid 2800-31FF (CHAPTER MENU)
            sortTableAddr   = 0x3C00 - sortTableLen;
            titleTableAddr  = 0x8200;
            titleTableSpace = 0x9800 - titleTableAddr;
            menuTableAddr   = 0x3200;
            menuTableSpace  = sortTableAddr - menuTableAddr;
        }

        if (menuTableLen > menuTableSpace) {
            throw new RuntimeException("Menu Table too large: length = " + menuTableLen + "; space = " + menuTableSpace);
        }

        // ------------------------------------------------------------------------------------
        // Generate the Title Table (MENU2)
        // ------------------------------------------------------------------------------------

        if (debug) {
            dumpTitles("Chunk " + chunk + " in title sort order", atomTitles);
        }

        byte[] titleTableBytes = titleTable.createTable(titleTableAddr, atomTitles);

        if (titleTableBytes.length != titleTableLen) {
            throw new RuntimeException(
                    "Title Table size mismatch: expected = " + titleTableLen + "; actual = " + titleTableBytes.length);
        }

        if (titleTableLen > titleTableSpace) {
            throw new RuntimeException(
                    "Title Table too large: space = " + titleTableSpace + "; actual = " + titleTableBytes.length );
        }

        writeTable(menuDir, "MENU2", titleTableAddr, titleTableBytes);

        // ------------------------------------------------------------------------------------
        // Generate the Secondary Tables (Shot Publisher, Publisher, ...
        // ------------------------------------------------------------------------------------

        // The first entry points to the title table (now a separate file)
        int tmpAddr = menuTableAddr + menuTableHeader;
        byte[][] tableDatas = new byte[1 + secondaryTables.length][];
        int[] tableLoads = new int[1 + secondaryTables.length];
        tableDatas[0] = null;
        tableLoads[0] = titleTableAddr;
        for (int i = 0; i < secondaryTables.length; i++) {
            SecondaryTable table = secondaryTables[i];
            byte[] bytes = table.createTable(tmpAddr, i > 0 ? atomTitles : null);
            tableDatas[i + 1] = bytes;
            tableLoads[i + 1] = 0;
            tmpAddr += bytes.length;
            if (bytes.length != table.calculateSize(atomTitles)) {
                throw new RuntimeException(
                        "Secondary table "  + table.getName() + " size mismatch: expected = " + table.calculateSize(atomTitles) + "; actual = " + bytes.length);
            }
        }
        writeTables(menuDir, "MENU1", menuTableAddr, tableLoads, tableDatas);

        // ------------------------------------------------------------------------------------
        // Generate the Sort Tables
        // ------------------------------------------------------------------------------------

        for (int i = 0; i < sortTables.length; i++) {
            SortTable table = sortTables[i];
            byte[] bytes = table.createTable(sortTableAddr, atomTitles);
            if (bytes.length != table.calculateSize(atomTitles)) {
                throw new RuntimeException(
                        "Sort table "  + table.getName() + " size mismatch: expected = " + table.calculateSize(atomTitles) + "; actual = " + bytes.length);
            }
            writeTable(menuDir, "SORT" + i, sortTableAddr, bytes);
        }

        // ------------------------------------------------------------------------------------
        // Report the Free Space
        // ------------------------------------------------------------------------------------

        System.out.println("----------------------------------------");
        System.out.println("Chunk " + chunk + ": Title Table Free Space: " + (titleTableSpace - titleTableLen) + " bytes");
        System.out.println("Chunk " + chunk + ": Menu  Table Free Space: " + (menuTableSpace - menuTableLen) + " bytes");
        System.out.println("----------------------------------------");

        // ------------------------------------------------------------------------------------
        // Cope the CHAP menu program and HELP screen
        // ------------------------------------------------------------------------------------

        ATMFile.copy(new File(archiveDir, "HELP"), new File(menuDir, "HELP"));
        if (allChunk) {
            ATMFile.copy(new File(archiveDir, "ALL"), new File(menuDir, "CHAP"));
        } else {
            ATMFile.copy(new File(archiveDir, "CHAP"), new File(menuDir, "CHAP"));
        }
    }

    private String md5sum(byte[] bytes) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(bytes, 0, bytes.length);
            BigInteger i = new BigInteger(1, md.digest());
            return String.format("%1$032X", i);
        } catch (NoSuchAlgorithmException e) {
            return "No MD5 Digest Available";
        }
    }

    private void writeTables(File menuDir, String name, int loadAddr, int[] addrs, byte[][] tables) throws IOException {
        System.out.println("----------------------------------------");
        System.out.println("Chunk " + chunk + ": Atom file: " + name);
        System.out.println("----------------------------------------");
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        int addr = loadAddr + 2 * tables.length;
        for (int i = 0; i < tables.length; i++) {
            byte[] table = tables[i];
            if (table == null) {
                writeShort(bos, addrs[i]);
            } else {
                writeShort(bos, addr);
                addr += table.length;
            }
        }
        for (byte[] table : tables) {
            if (table != null) {
                bos.write(table);
            }
        }
        FileOutputStream fosSort = new FileOutputStream(new File(menuDir, name));
        writeATMFile(fosSort, name, loadAddr, loadAddr, bos.toByteArray());
        fosSort.close();
        System.out.println("start address " + Integer.toHexString(loadAddr));
        System.out.println("  end address " + Integer.toHexString(loadAddr + bos.size()));
        System.out.println("       length " + bos.size() + " bytes");
        System.out.println("       md5sum " + md5sum(bos.toByteArray()));
    }

    private void writeTable(File menuDir, String name, int loadAddr, byte[] table) throws IOException {
        System.out.println("----------------------------------------");
        System.out.println("Chunk " + chunk + ": Atom file: " + name);
        System.out.println("----------------------------------------");
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        bos.write(table);
        FileOutputStream fosSort = new FileOutputStream(new File(menuDir, name));
        writeATMFile(fosSort, name, loadAddr, loadAddr, bos.toByteArray());
        fosSort.close();
        System.out.println("start address " + Integer.toHexString(loadAddr));
        System.out.println("  end address " + Integer.toHexString(loadAddr + bos.size()));
        System.out.println("       length " + bos.size() + " bytes");
        System.out.println("       md5sum " + md5sum(bos.toByteArray()));
    }

    private String pad(String s, int width) {
        if (s == null) {
            s = "*NULL*";
        }
        if (s.length() > width) {
            return s.substring(0, width);
        } else {
            StringBuffer sb = new StringBuffer(width);
            sb.append(s);
            for (int i = s.length(); i < width; i++) {
                sb.append(" ");
            }
            return sb.toString();
        }
    }

    public void dumpTitles(String type, List<AtomTitle> items) {
        int maxTitleLen = 0;
        for (AtomTitle item : items) {
            if (item.getTitle().length() > maxTitleLen) {
                maxTitleLen = item.getTitle().length();
            }
        }
        System.out.println("==========================================================");
        System.out.println(type);
        System.out.println("==========================================================");
        for (AtomTitle item : items) {
            StringBuffer sb = new StringBuffer();
            sb.append(pad(item.getTitle(), maxTitleLen + 4) + " ");
            for (int i = 0; i < secondaryTables.length; i++) {
                SecondaryTable table = secondaryTables[i];
                if (table.isMultiValue()) {
                    sb.append(table.testIndex(item)); // max len is the max size of an element, not the list
                } else {
                    sb.append(pad(table.testIndex(item), table.getMaxLen() + 4) + " ");
                }
            }
            System.out.println(sb);
        }
    }

    @Override
    public Target getTarget() {
        return target;
    }
}
