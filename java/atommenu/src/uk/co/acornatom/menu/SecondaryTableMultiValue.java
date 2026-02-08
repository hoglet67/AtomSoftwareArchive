package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Collection;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.function.Function;

public class SecondaryTableMultiValue extends TableBase {

    private String name;
    private Map<String, Integer> map;
    private int maxLen;
    private boolean debug = false;
    private Function<? super SpreadsheetTitle, ? extends Collection<String>> spreadsheetFieldExtractor; // Extracts a collection field
    private Function<? super AtomTitle, ? extends String> atomFieldExtractor; // Extracts a single field for sorting
    private Function<? super AtomTitle, ? extends Collection<String>> atomFieldMatcher;
    private Comparator<String> comparator;

    public SecondaryTableMultiValue (String name,
            Function<? super SpreadsheetTitle, ? extends List<String>> spreadsheetItemExtractor,
            Function<? super AtomTitle, ? extends String> atomFieldExtractor,
            Function<? super AtomTitle, ? extends List<String>> atomFieldMatcher,
            Comparator<String> comparator) {
        this.name = name;
        this.map = new TreeMap<String, Integer>(comparator);
        this.comparator = comparator;
        this.maxLen = 0;
        this.debug = false;
        this.spreadsheetFieldExtractor = spreadsheetItemExtractor;
        this.atomFieldExtractor = atomFieldExtractor;
        this.atomFieldMatcher = atomFieldMatcher;
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
        SortTable sortTable = new SortTable(name + " Sort", debug, Comparator.comparing(atomFieldExtractor, comparator));
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
                    if (atomFieldMatcher.apply(title).contains(key)) {
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
        Collection<String> values = spreadsheetFieldExtractor.apply(item);
        for (String value : values) {
            put(value, -1);
        }
    }

    public void addToIndex(Collection<String> values) {
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

    public Map<String, Integer> getMap() {
        return map;
    }
}
