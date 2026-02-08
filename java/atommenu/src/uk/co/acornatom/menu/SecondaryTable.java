package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.function.Function;

public class SecondaryTable extends TableBase {

    private String name;
    private Map<String, Integer> map;
    private int maxLen;
    private boolean debug = false;
    private Function<? super SpreadsheetTitle, ? extends String> spreadsheetItemExtractor;
    private Function<? super AtomTitle, ? extends String> atomTitleExtractor;
    private Comparator<String> comparator;

    public SecondaryTable (
            String name,
            Function<? super SpreadsheetTitle, ? extends String> spreadsheetItemExtractor,
            Function<? super AtomTitle, ? extends String> atomTitleExtractor
            ) {
        this(name, spreadsheetItemExtractor, atomTitleExtractor, new TreeMap<String, Integer>());
    }

    public SecondaryTable (
            String name,
            Function<? super SpreadsheetTitle, ? extends String> spreadsheetItemExtractor,
            Function<? super AtomTitle, ? extends String> atomTitleExtractor,
            Map<String, Integer> map
            ) {
        this(name, spreadsheetItemExtractor, atomTitleExtractor, Comparator.naturalOrder(), map);
    }

    public SecondaryTable (String name,
            Function<? super SpreadsheetTitle, ? extends String> spreadsheetItemExtractor,
            Function<? super AtomTitle, ? extends String> atomTitleExtractor,
            Comparator<String> comparator) {
        this(name, spreadsheetItemExtractor, atomTitleExtractor, comparator, new TreeMap<String, Integer>(comparator));
    }

    private SecondaryTable (String name,
            Function<? super SpreadsheetTitle, ? extends String> spreadsheetItemExtractor,
            Function<? super AtomTitle, ? extends String> atomTitleExtractor,
            Comparator<String> comparator,
            Map<String, Integer> map) {
        this.name = name;
        this.map = map;
        this.comparator = comparator;
        this.maxLen = 0;
        this.debug = false;
        this.spreadsheetItemExtractor = spreadsheetItemExtractor;
        this.atomTitleExtractor = atomTitleExtractor;
        for (String key : this.map.keySet()) {
            if (key.length() > this.maxLen) {
                maxLen = key.length();
            }
        }
    }

    public void assignIndexes() {
        int index = 0;
        for (String key : map.keySet()) {
            map.replace(key, index++);
        }
    }

    public void setDebug(boolean debug) {
        this.debug = debug;
    }

    public void dumpIndexes() {
        System.out.println("==========================================================");
        System.out.println(name);
        System.out.println("==========================================================");
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            System.out.println(entry.getValue() + "\t" + entry.getKey());
        }
    }

    public int getMaxLen() {
        return maxLen;
    }

    public byte[] createSortTable(List<AtomTitle> items) throws IOException {
        SortTable sortTable = new SortTable(name + " Sort", debug, Comparator.comparing(atomTitleExtractor, comparator));
        return sortTable.createTable(items);
    }

    public byte[] createTable(int absoluteAddress) throws IOException {
        return createTable(absoluteAddress, null);
    }

    public byte[] createTable(int absoluteAddress, List<AtomTitle> titles) throws IOException {
        if (debug) {
            System.out.println("----------------------------------------");
            System.out.println("Secondary Table: " + name);
            System.out.println("----------------------------------------");
            System.out.println("address " + Integer.toHexString(absoluteAddress));
        }
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        absoluteAddress += map.size() * 2 + 4; // Skip over the pointers plus
                                               // the length and terminator
        writeShort(bos, map.size());
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            writeShort(bos, absoluteAddress);
            absoluteAddress += (titles != null ? 4 : 0) + entry.getKey().length() + 1;
        }
        writeShort(bos, 0x0000);
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            String key = entry.getKey();
            if (titles != null) {
                int count = 0;
                // Count the number of occurrences of this secondary key in the
                // specified sort table
                for (AtomTitle title : titles) {
                    if (atomTitleExtractor.apply(title).equals(key)) {
                        count++;
                    }
                }
                writeShort(bos, count);
                writeShort(bos, 0);
            }
            writeString(bos, key);
            writeByte(bos, 0);
        }
        if (debug) {
            System.out.println("length " + bos.size() + " bytes");
        }
        return bos.toByteArray();
    }

    // WARNING: this is expensive and should only be used sparingly
    // It's needed to support some logging code
    public String getKey(int value) {
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            if (entry.getValue().equals(value)) {
                return entry.getKey();
            }
        }
        return null;
    }


    public void addToIndex(SpreadsheetTitle item) {
        String value = spreadsheetItemExtractor.apply(item);
        put(value, -1);
    }

    public void addToIndex(List<String> values) {
        for (String value : values) {
            put(value, -1);
        }
    }

    // Some methods that operate on the underlying map
    public void clear() {
        map.clear();
    }

    public Integer put(String key, Integer value) {
        if (key.length() > this.maxLen) {
            maxLen = key.length();
        }
        return map.put(key, value);
    }

    public Set<String> keySet() {
        return map.keySet();
    }

    public Integer get(Object key) {
        return map.get(key);
    }


}
