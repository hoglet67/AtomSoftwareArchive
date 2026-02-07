package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

public class GenerateMenuFiles extends GenerateBase {

    private Comparator<String> intuitiveStringComparator = new IntuitiveStringComparator<String>();

    private Map<String, Integer> shortPublishers = new LinkedHashMap<String, Integer>();
    private Map<String, Integer> publishers = new TreeMap<String, Integer>();
    private Map<String, Integer> genres = new TreeMap<String, Integer>();
    private Map<String, Integer> collections = new TreeMap<String, Integer>(intuitiveStringComparator);
    private Map<String, Integer> compatibles = new TreeMap<String, Integer>();
    private Map<String, Integer> versions = new TreeMap<String, Integer>(intuitiveStringComparator);
    private int maxTitleLen;
    private int maxShortPublisherLen;
    private int maxPublisherLen;
    private int maxGenreLen;
    private int maxCompatibleLen;
    private int maxVersionLen;
    private int maxCollectionLen;
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

    private void dumpIndexes(String type, Map<String, Integer> map) {
        System.out.println("==========================================================");
        System.out.println(type);
        System.out.println("==========================================================");
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            System.out.println(entry.getValue() + "\t" + entry.getKey());
        }
    }

    private void addToIndex(String value, Map<String, Integer> map) {
        map.put(value, -1);
    }

    private void addToIndex(List<String> values, Map<String, Integer> map) {
        for (String value : values) {
            addToIndex(value, map);
        }
    }

    private void assignIndexes(Map<String, Integer> map) {
        int index = 0;
        for (String key : map.keySet()) {
            map.put(key, index++);
        }
    }

    @Override
    public void generateFiles(List<SpreadsheetTitle> items) throws IOException {

        // ------------------------------------------------------------------------------------
        // Process the spreadsheet items to generate IDs for Publishers, Genres
        // and Collections
        // ------------------------------------------------------------------------------------

        HashMap<String, String> longPubShortPub = new HashMap<String, String>();

        publishers.clear();
        genres.clear();
        compatibles.clear();
        versions.clear();
        collections.clear();

        maxTitleLen = 0;
        maxPublisherLen = 0;
        maxShortPublisherLen = 0;
        maxGenreLen = 0;
        maxCollectionLen = 0;
        maxCompatibleLen = 0;
        maxVersionLen = 0;

        for (SpreadsheetTitle item : items) {
            if (item.getTitle().length() > maxTitleLen) {
                maxTitleLen = item.getTitle().length();
            }
            if (item.getPublisher().length() > maxPublisherLen) {
                maxPublisherLen = item.getPublisher().length();
            }
            if (item.getShortPublisher().length() > maxShortPublisherLen) {
                maxShortPublisherLen = item.getShortPublisher().length();
            }
            if (item.getGenre().length() > maxGenreLen) {
                maxGenreLen = item.getGenre().length();
            }
            for (String collection : item.getCollections()) {
                if (collection.length() > maxCollectionLen) {
                    maxCollectionLen = collection.length();
                }
            }
            if (item.getCompatible().length() > maxCompatibleLen) {
                maxCompatibleLen = item.getCompatible().length();
            }
            if (item.getVersion().length() > maxVersionLen) {
                maxVersionLen = item.getVersion().length();
            }
            addToIndex(item.getPublisher(), publishers);
            addToIndex(item.getGenre(), genres);
            addToIndex(item.getCompatible(), compatibles);
            addToIndex(item.getVersion(), versions);
            addToIndex(item.getCollections(), collections);
            longPubShortPub.put(item.getPublisher(), item.getShortPublisher());
        }
        assignIndexes(publishers);
        assignIndexes(genres);
        assignIndexes(compatibles);
        assignIndexes(versions);
        assignIndexes(collections);

        // Build the short publisher map so the key order is the same as the
        // long publisher
        shortPublishers.clear();
        for (String key : publishers.keySet()) {
            if (longPubShortPub.containsKey(key)) {
                shortPublishers.put(longPubShortPub.get(key), publishers.get(key));
            }
        }

        if (debug) {
            dumpIndexes("ShortPublishers", shortPublishers);
            dumpIndexes("Publishers", publishers);
            dumpIndexes("Genres", genres);
            dumpIndexes("Compatibles", compatibles);
            dumpIndexes("Versions", versions);
            dumpIndexes("Collections", collections);
        }

        List<AtomTitle> atomTitles = new ArrayList<AtomTitle>();
        for (SpreadsheetTitle item : items) {
            AtomTitle atomTitle = new AtomTitle();
            atomTitle.setTitle(item.getTitle());
            if (item.getDiskNo() != null) {
                atomTitle.setIndex(item.getDiskNo()); // Use the disk number if it's been set by the generator
            } else {
                atomTitle.setIndex(item.getIdentifier()); // Use persistent identifier everywhere else
            }
            atomTitle.setShortPublisher(item.getShortPublisher());
            atomTitle.setPublisher(item.getPublisher());
            atomTitle.setPublisherId(publishers.get(item.getPublisher()));
            atomTitle.setGenre(item.getGenre());
            atomTitle.setGenreId(genres.get(item.getGenre()));
            atomTitle.setCompatible(item.getCompatible());
            atomTitle.setCompatibleId(compatibles.get(item.getCompatible()));
            atomTitle.setVersion(item.getVersion());
            atomTitle.setVersionId(versions.get(item.getVersion()));
            atomTitle.setCollections(item.getCollections(), collections);
            atomTitles.add(atomTitle);
        }

        // ------------------------------------------------------------------------------------
        // Sort by title for the main table
        // ------------------------------------------------------------------------------------

        Collections.sort(atomTitles, new TitleOrderSort());
        if (debug) {
            dumpTitles("Chunk " + chunk + " in title sort order", atomTitles);
        }

        // ------------------------------------------------------------------------------------
        // Generate the data for the main table
        //
        // This resides in the upper text space
        // ------------------------------------------------------------------------------------

        int endOfLowerText;
        int lengthOfLowerText;
        int startOfUpperText;
        int lengthOfUpperText;

        // Note: RowReturnBuffer (2x13 bytes) now included in MENU in all
        // (AtoMMC/Econet/SDDOS) cases
        // MENU 094C 2800->314C
        // MENUSD 0983 2800->3183
        // MENUECO 0976 2800->3176
        if (allChunk) {
            // swap the lower and upper text spaces
            lengthOfLowerText = 0x1600;
            endOfLowerText = 0x9800;
            startOfUpperText = 0x2200; // Avoid the DOS/SDDOS disk buffers
            lengthOfUpperText = 0x8000 - startOfUpperText; // ALL Chapter menu 1000
        } else if (agdChunk) {
            // swap the lower and upper text spaces
            lengthOfLowerText = 0x1600;
            endOfLowerText = 0x9800;
            startOfUpperText = 0x3200;
            lengthOfUpperText = 0x7000 - startOfUpperText; // Some RAM/ROM boards use the #7xxx for the RAM slot
        } else {
            lengthOfLowerText = 0x0A00;
            endOfLowerText = 0x3c00;
            startOfUpperText = 0x8200;
            lengthOfUpperText = 0x1600;
        }

        int titleTableAddr = startOfUpperText;

        byte[] titleTable = createTitleTable(titleTableAddr, atomTitles);

        // ------------------------------------------------------------------------------------
        // Generate the data for the sort tables
        //
        // these reside right at the end in the Atom lower text space
        //
        // a side effect of generating these is that the
        // publisher/genres/collections maps are
        // updated with the address in the sort table of the first occurrence of
        // the each
        // publisher/genre/collection
        // ------------------------------------------------------------------------------------

        byte[] titleSortTable = createSortTable("Title Sort", atomTitles, new TitleOrderSort(), null);

        List<AtomTitle> publisherSortList = new ArrayList<AtomTitle>(atomTitles);
        byte[] publisherSortTable = createSortTable("Publisher Sort", publisherSortList, new PublisherOrderSort(), publishers);

        List<AtomTitle> genreSortList = new ArrayList<AtomTitle>(atomTitles);
        byte[] genreSortTable = createSortTable("Genre Sort", genreSortList, new GenreOrderSort(), genres);

        List<AtomTitle> compatibleSortList = new ArrayList<AtomTitle>(atomTitles);
        byte[] compatibleSortTable = createSortTable("Compatible Sort", compatibleSortList, new CompatibleOrderSort(), compatibles);

        List<AtomTitle> versionSortList = new ArrayList<AtomTitle>(atomTitles);
        byte[] versionSortTable = createSortTable("Version Sort", versionSortList, new VersionOrderSort(), versions);

        List<AtomTitle> collectionSortList = new ArrayList<AtomTitle>(atomTitles);
        byte[] collectionSortTable = createSortTable("Collection Sort", collectionSortList, new CollectionOrderSort(), collections);


        // ------------------------------------------------------------------------------------
        // Generate the Secondary Tables (Publisher, Genre, Compatible, Version Collections)
        //
        // these reside in the Atom higher text space
        // ------------------------------------------------------------------------------------

        // We want to place the other tables as high as possible in the lower
        // text space
        // Do a "two pass" assembly were on the second pass the addresss will be
        // correct

        byte[] shortPublisherTable = null;
        byte[] publisherTable = null;
        byte[] genreTable = null;
        byte[] compatibleTable = null;
        byte[] versionTable = null;
        byte[] collectionsTable = null;

        int menuTableAddr = 0;
        int sortTableAddr = endOfLowerText - titleSortTable.length;

        for (int pass = 0; pass < 2; pass++) {

            int menuAddr = menuTableAddr + 14;

            shortPublisherTable = createSecondaryTable("ShortPublisher", menuAddr, shortPublishers, null, null);
            menuAddr += shortPublisherTable.length;

            publisherTable = createSecondaryTable("Publisher", menuAddr, publishers, publisherSortList, new IFieldSelector() {
                @Override
                public Set<String> getField(AtomTitle title) {
                    Set<String> fields = new HashSet<String>();
                    fields.add(title.getPublisher());
                    return fields;
                }
            });
            menuAddr += publisherTable.length;

            genreTable = createSecondaryTable("Genre", menuAddr, genres, genreSortList, new IFieldSelector() {
                @Override
                public Set<String> getField(AtomTitle title) {
                    Set<String> fields = new HashSet<String>();
                    fields.add(title.getGenre());
                    return fields;
                }
            });
            menuAddr += genreTable.length;

            compatibleTable = createSecondaryTable("Compatible", menuAddr, compatibles, compatibleSortList, new IFieldSelector() {
                @Override
                public Set<String> getField(AtomTitle title) {
                    Set<String> fields = new HashSet<String>();
                    fields.add(title.getCompatible());
                    return fields;
                }
            });
            menuAddr += compatibleTable.length;

            versionTable = createSecondaryTable("Version", menuAddr, versions, versionSortList, new IFieldSelector() {
                @Override
                public Set<String> getField(AtomTitle title) {
                    Set<String> fields = new HashSet<String>();
                    fields.add(title.getVersion());
                    return fields;
                }
            });
            menuAddr += versionTable.length;

            collectionsTable = createSecondaryTable("Collection", menuAddr, collections, collectionSortList, new IFieldSelector() {
                @Override
                public Set<String> getField(AtomTitle title) {
                    Set<String> fields = new HashSet<String>();
                    fields.addAll(title.getCollections());
                    return fields;
                }
            });
            menuAddr += collectionsTable.length;

            // At the end of pass, calculate the menu base address property
            if (pass == 0) {
                menuTableAddr = sortTableAddr;
                menuTableAddr -= shortPublisherTable.length;
                menuTableAddr -= publisherTable.length;
                menuTableAddr -= genreTable.length;
                menuTableAddr -= compatibleTable.length;
                menuTableAddr -= versionTable.length;
                menuTableAddr -= collectionsTable.length;
                menuTableAddr -= 14; // two bytes for each table: title, short
                                     // pub, pub, genre, compatible, version, collections
            }
        }

        // ------------------------------------------------------------------------------------
        // Sanity check the end addresses
        // ------------------------------------------------------------------------------------

        if (menuTableAddr < endOfLowerText - lengthOfLowerText) {
            throw new RuntimeException("Lower Text Space is full");
        }

        if (titleTable.length > lengthOfUpperText) {
            throw new RuntimeException(
                    "Upper Text Space is full: length = " + titleTable.length + "; space = " + lengthOfUpperText);
        }

        // ------------------------------------------------------------------------------------
        // Write the tables as Atom Files
        // ------------------------------------------------------------------------------------

        writeTables(menuDir, "MENU1", menuTableAddr, new int[] { titleTableAddr, 0, 0, 0, 0 },
                    new byte[][] { null, shortPublisherTable, publisherTable, genreTable, compatibleTable, versionTable, collectionsTable });
        writeTable(menuDir, "MENU2", titleTableAddr, titleTable);
        writeTable(menuDir, "SORT0", sortTableAddr, titleSortTable);
        writeTable(menuDir, "SORT1", sortTableAddr, publisherSortTable);
        writeTable(menuDir, "SORT2", sortTableAddr, genreSortTable);
        writeTable(menuDir, "SORT3", sortTableAddr, compatibleSortTable);
        writeTable(menuDir, "SORT4", sortTableAddr, versionSortTable);
        writeTable(menuDir, "SORT5", sortTableAddr, collectionSortTable);

        ATMFile.copy(new File(archiveDir, "HELP"), new File(menuDir, "HELP"));
        if (allChunk) {
            ATMFile.copy(new File(archiveDir, "ALL"), new File(menuDir, "CHAP"));
        } else {
            ATMFile.copy(new File(archiveDir, "CHAP"), new File(menuDir, "CHAP"));
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
    }

    private byte[] createTitleTable(int absoluteAddress, List<AtomTitle> items) throws IOException {
        if (debug) {
            System.out.println("----------------------------------------");
            System.out.println("Title Table");
            System.out.println("----------------------------------------");
            System.out.println("address " + Integer.toHexString(absoluteAddress));
        }
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        for (AtomTitle item : items) {
            item.setAbsoluteAddress(absoluteAddress + bos.size());
            writeShort(bos, item.getIndex() + (item.getGenreId() << 11));
            writeByte(bos, item.getPublisherId());
            writeByte(bos, (item.getCompatibleId() << 6) + item.getVersionId());
            for (Integer collectionId : item.getCollectionIds()) {
                writeByte(bos, 128 + collectionId);
            }
            writeString(bos, item.getTitle());
            writeByte(bos, 0);
        }
        if (debug) {
            System.out.println("length " + bos.size() + " bytes");
        }
        return bos.toByteArray();
    }

    private byte[] createSecondaryTable(String tableName, int absoluteAddress, Map<String, Integer> map, List<AtomTitle> sort,
            IFieldSelector fieldSelector) throws IOException {
        if (debug) {
            System.out.println("----------------------------------------");
            System.out.println("Secondary Table: " + tableName);
            System.out.println("----------------------------------------");
            System.out.println("address " + Integer.toHexString(absoluteAddress));
        }
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        absoluteAddress += map.size() * 2 + 4; // Skip over the pointers plus
                                               // the length and terminator
        writeShort(bos, map.size());
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            writeShort(bos, absoluteAddress);
            absoluteAddress += (sort != null ? 4 : 0) + entry.getKey().length() + 1;
        }
        writeShort(bos, 0x0000);
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            if (sort != null) {
                int count = 0;
                // Count the number of occurrences of this secondary key in the
                // specified sort table
                for (int i = 0; i < sort.size(); i++) {
                    if (fieldSelector.getField(sort.get(i)).contains(entry.getKey())) {
                        count++;
                    }
                }
                writeShort(bos, count);
                writeShort(bos, 0);
            }
            writeString(bos, entry.getKey());
            writeByte(bos, 0);
        }
        if (debug) {
            System.out.println("length " + bos.size() + " bytes");
        }
        return bos.toByteArray();
    }

    private byte[] createSortTable(String tableName, List<AtomTitle> items, Comparator<AtomTitle> comparator,
            Map<String, Integer> map) throws IOException {
        if (debug) {
            System.out.println("----------------------------------------");
            System.out.println("Sort Table: " + tableName);
            System.out.println("----------------------------------------");
        }
        // Sort items using the supplier comparator
        Collections.sort(items, comparator);
        // Build the data for the table
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        writeShort(bos, items.size());
        for (AtomTitle item : items) {
            writeShort(bos, item.getAbsoluteAddress());
        }
        writeShort(bos, 0x0000);
        if (debug) {
            System.out.println("length " + bos.size() + " bytes");
        }
        return bos.toByteArray();
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
        System.out.println("==========================================================");
        System.out.println(type);
        System.out.println("==========================================================");
        for (AtomTitle item : items) {
            System.out.print(pad(item.getTitle(), maxTitleLen + 4) + " "
                    + pad(getKey(item.getPublisherId(), shortPublishers), maxShortPublisherLen + 4) + " "
                    + pad(getKey(item.getPublisherId(), publishers), maxPublisherLen + 4) + " "
                    + pad(getKey(item.getGenreId(), genres), maxGenreLen + 4) + " "
                    + pad(getKey(item.getCompatibleId(), compatibles), maxCompatibleLen + 4) + " "
                    + pad(getKey(item.getVersionId(), versions), maxVersionLen + 4) + " ");
            if (item.getCollectionIds().size() > 0) {
                for (Integer collectionId : item.getCollectionIds()) {
                    System.out.print(pad(Integer.toString(collectionId), 4));
                    System.out.print(pad(getKey(collectionId, collections), maxCollectionLen + 4));
                }
            } else {
                System.out.println(pad("NO COLLECTIONS", maxCollectionLen + 4));
            }
            System.out.println();
        }
    }

    public class TitleOrderSort implements Comparator<AtomTitle> {
        @Override
        public int compare(AtomTitle o1, AtomTitle o2) {
            return o1.getTitle().compareTo(o2.getTitle());
        }
    }

    public abstract class ComparatorBase implements Comparator<AtomTitle> {
        public int compareWithZeroLast(int o1, int o2) {
            if (o1 < 0) {
                o1 = Integer.MAX_VALUE;
            }
            if (o2 < 0) {
                o2 = Integer.MAX_VALUE;
            }
            return o1 - o2;
        }
    }

    public class CollectionOrderSort extends ComparatorBase {
        @Override
        public int compare(AtomTitle o1, AtomTitle o2) {
            int col1 = o1.getCollectionIds().size() > 0 ? o1.getCollectionIds().get(0) : Integer.MAX_VALUE;
            int col2 = o2.getCollectionIds().size() > 0 ? o2.getCollectionIds().get(0) : Integer.MAX_VALUE;
            int ret = compareWithZeroLast(col1, col2);
            return ret != 0 ? ret : o1.getTitle().compareTo(o2.getTitle());
        }
    }

    public class GenreOrderSort extends ComparatorBase implements Comparator<AtomTitle> {
        @Override
        public int compare(AtomTitle o1, AtomTitle o2) {
            int ret = o1.getGenreId() - o2.getGenreId();
            return ret != 0 ? ret : o1.getTitle().compareTo(o2.getTitle());
        }
    }

    public class CompatibleOrderSort extends ComparatorBase implements Comparator<AtomTitle> {
        @Override
        public int compare(AtomTitle o1, AtomTitle o2) {
            int ret = o1.getCompatibleId() - o2.getCompatibleId();
            return ret != 0 ? ret : o1.getTitle().compareTo(o2.getTitle());
        }
    }

    public class VersionOrderSort extends ComparatorBase implements Comparator<AtomTitle> {
        @Override
        public int compare(AtomTitle o1, AtomTitle o2) {
            int ret = o1.getVersionId() - o2.getVersionId();
            return ret != 0 ? ret : o1.getTitle().compareTo(o2.getTitle());
        }
    }

    public class PublisherOrderSort extends ComparatorBase {
        @Override
        public int compare(AtomTitle o1, AtomTitle o2) {
            int ret = o1.getPublisherId() - o2.getPublisherId();
            return ret != 0 ? ret : o1.getTitle().compareTo(o2.getTitle());
        }
    }

    @Override
    public Target getTarget() {
        return target;
    }
}
