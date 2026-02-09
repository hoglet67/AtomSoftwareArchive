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

    private Comparator<String> intuitiveStringComparator = new IntuitiveStringComparator<String>();

    private int titleHeaderSize = 4;

    private SecondaryTable shortPublishers = new SecondaryTableSingleValue(
            "ShortPublisher",
            null, // This reuses the same BitField as the Publisher
            AtomTitle::getShortPublisher,
            new LinkedHashMap<String, Integer>());

    private SecondaryTable publishers = new SecondaryTableSingleValue(
            "Publisher",
            new BitField(2, 0, 8),
            AtomTitle::getPublisher);

    private SecondaryTable genres = new SecondaryTableSingleValue(
            "Genre",
            new BitField(1, 3, 5),
            AtomTitle::getGenre);

    private SecondaryTable compatibles = new SecondaryTableSingleValue(
            "Compatible",
            new BitField(3, 5, 3),
            AtomTitle::getCompatible,
            Comparator.nullsLast(intuitiveStringComparator));

    private SecondaryTable versions = new SecondaryTableSingleValue(
            "Version",
            new BitField(3 ,0, 5),
            AtomTitle::getVersion,
            intuitiveStringComparator.reversed());

    private SecondaryTable collections = new SecondaryTableMultiValue (
            "Collection",
            new BitField(4, 0, 8),
            AtomTitle::getCollectionFirst, // for sorting (based on the first collection)
            AtomTitle::getCollections,     // for indexing
            Comparator.nullsLast(intuitiveStringComparator));

    private SecondaryTable[] secondaryTables = new SecondaryTable[] {
            shortPublishers,
            publishers,
            genres,
            compatibles,
            versions,
            collections
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
        for (int i = 0; i < secondaryTables.length; i++) { // All tables
            secondaryTables[i].setDebug(debug);
        }
    }

    @Override
    public void generateFiles(List<AtomTitle> items) throws IOException {

        int endOfLowerText;
        int lengthOfLowerText;
        int startOfUpperText;
        int lengthOfUpperText;

        // ------------------------------------------------------------------------------------
        // Decide where to place the various menu data segments
        // ------------------------------------------------------------------------------------

        // Note: RowReturnBuffer (2x13 bytes) now included in MENU in all
        // (AtoMMC/Econet/SDDOS) cases
        // MENU 094C 2800->314C
        // MENUSD 0983 2800->3183
        // MENUECO 0976 2800->3176

        // TODO: push the size calculation down into each table

        // If needed we could precalculate the size of the title table
        int titleTableAddr;
        int titleTableSpace;

        int sortTableAddr;
        int sortTableLen = items.size() * 2 + 4; // NumTitles + 0000 terminator

        int menuTableAddr;
        int menuTableSpace;
        int menuTableHeader = 2 * (1 + secondaryTables.length); // pointers to title table and all secondary indexes
        int menuTableLen = menuTableHeader;
        for (int i = 0; i < secondaryTables.length; i++) { // All tables
            menuTableLen += secondaryTables[i].calculateSize(i > 0);
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
        // Reset the secondary tables
        // ------------------------------------------------------------------------------------

        Map<String, String> longPubShortPub = new HashMap<String, String>();
        for (int i = 0; i < secondaryTables.length; i++) { // All tables
            secondaryTables[i].clear();
        }

        // ------------------------------------------------------------------------------------
        // Add the item metadata into the secondary tables
        // ------------------------------------------------------------------------------------

        for (AtomTitle item : items) {
            for (int i = 1; i < secondaryTables.length; i++) { // Skip first table (short pub)
                secondaryTables[i].addToIndex(item);
            }
            longPubShortPub.put(item.getPublisher(), item.getShortPublisher());
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

        // ------------------------------------------------------------------------------------
        // Build the list of Atom Titles
        // TODO: AtomTitle could be an interface implemented by spreadsheet item
        // TODO: This code is not get generic, so needs changing when the facets change
        // ------------------------------------------------------------------------------------

        List<AtomTitle> atomTitles = items;

        for (AtomTitle atomTitle : atomTitles) {
            atomTitle.setCollectionIds(collections.getMap());
        }

        // ------------------------------------------------------------------------------------
        // Generate the Title Table and Title Sort Table (MENU2)
        // ------------------------------------------------------------------------------------

        Collections.sort(atomTitles, Comparator.comparing(AtomTitle::getTitle));
        if (debug) {
            dumpTitles("Chunk " + chunk + " in title sort order", atomTitles);
        }

        // TODO: The title table is also not generic and depends on the facets
        byte[] titleTableBytes = new TitleTable(debug, titleHeaderSize).createTable(titleTableAddr, atomTitles, secondaryTables);
        int titleTableLen = titleTableBytes.length;

        byte[] titleSortTable = new SortTable("Title Sort", debug, Comparator.comparing(AtomTitle::getTitle)).createTable(atomTitles);

        if (titleTableLen > titleTableSpace) {
            throw new RuntimeException(
                    "Title Table too large: length = " + titleTableBytes.length + "; space = " + titleTableSpace);
        }

        // ------------------------------------------------------------------------------------
        // Generate the Secondary Tables (Shot Publisher, Publisher, ... (MENU1)
        // ------------------------------------------------------------------------------------

        int tmpAddr = menuTableAddr + menuTableHeader;
        // The first entry points to the title table (now a separate file)
        byte[][] tableDatas = new byte[1 + secondaryTables.length][];
        int[] tableLoads = new int[1 + secondaryTables.length];
        tableDatas[0] = null;
        tableLoads[0] = titleTableAddr;
        for (int i = 0; i < secondaryTables.length; i++) {
            byte[] tableData = secondaryTables[i].createTable(tmpAddr, i > 0 ? atomTitles : null);
            tableDatas[i + 1] = tableData;
            tableLoads[i + 1] = 0;
            tmpAddr += tableData.length;
        }

        // ------------------------------------------------------------------------------------
        // Write the tables as Atom Files
        // ------------------------------------------------------------------------------------

        writeTables(menuDir, "MENU1", menuTableAddr, tableLoads, tableDatas);
        writeTable(menuDir, "MENU2", titleTableAddr, titleTableBytes);
        writeTable(menuDir, "SORT0", sortTableAddr, titleSortTable);
        for (int i = 1; i < secondaryTables.length; i++) {
            byte[] sortTable = secondaryTables[i].createSortTable(atomTitles);
            writeTable(menuDir, "SORT" + i, sortTableAddr, sortTable);
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

    private String getKey(int value, Map<String, Integer> map) {
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            if (entry.getValue().equals(value)) {
                return entry.getKey();
            }
        }
        return null;
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

        int maxCollectionLen = collections.getMaxLen();

        System.out.println("==========================================================");
        System.out.println(type);
        System.out.println("==========================================================");
        for (AtomTitle item : items) {
            StringBuffer sb = new StringBuffer();
            sb.append(pad(item.getTitle(), maxTitleLen + 4) + " ");
            for (int i = 0; i < secondaryTables.length - 1; i++) {
                SecondaryTable table = secondaryTables[i];
                sb.append(pad(table.testIndex(item), table.getMaxLen() + 4) + " ");
            }
            if (item.getCollectionIds().size() > 0) {
                for (Integer collectionId : item.getCollectionIds()) {
                    sb.append(pad(Integer.toString(collectionId), 4));
                    sb.append(pad(getKey(collectionId, collections.getMap()), maxCollectionLen + 4));
                }
            } else {
                sb.append(pad("NO COLLECTIONS", maxCollectionLen + 4));
            }
            System.out.println(sb);
        }
    }

    @Override
    public Target getTarget() {
        return target;
    }
}
