package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;

public abstract class SecondaryTable extends TableBase {

    private String name;
    private BitField def;

    protected Function<? super AtomTitle, ? extends String> atomFieldExtractor; // Extracts a single field for sorting
    private Map<String, Integer> map;

    private int maxLen;
    private boolean debug = false;
    private int calculatedSize;

    protected SecondaryTable (String name,
            BitField def,
            Function<? super AtomTitle, ? extends String> atomFieldExtractor,
            Map<String, Integer> map
            ) {
        this.name = name;
        this.def = def;
        this.map = map;
        this.maxLen = 0;
        this.debug = false;
        this.atomFieldExtractor = atomFieldExtractor;
        for (String key : this.map.keySet()) {
            if (key.length() > this.maxLen) {
                maxLen = key.length();
            }
        }
    }

    public BitField getDef() {
        return def;
    }

    public abstract void addToIndex(AtomTitle item);

    public abstract boolean match(AtomTitle title, String value);

    public void assignIndexes() {
        int index = 0;
        for (String key : map.keySet()) {
            map.replace(key, index++);
        }
    }

    @Override
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

    public byte[] createTable(int absoluteAddress) throws IOException {
        return createTable(absoluteAddress, null);
    }

    public int calculateSize(boolean includeCounts) {
          calculatedSize = map.size() * 2 + 4;
          for (Map.Entry<String, Integer> entry : map.entrySet()) {
              String key = entry.getKey();
              calculatedSize += key.length() + 1;
              if (includeCounts) {
                  calculatedSize += 4; // Space for the counts
              }
          }
          return calculatedSize;
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
                    if (match(title, key)) {
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
        byte[] bytes = bos.toByteArray();
        if (bytes.length != calculatedSize) {
            System.out.println("WARNING: calculated and actual sizes differ for " + name);
        }
        return bytes;
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



    // Some methods that operate on the underlying map
    public void clear() {
        map.clear();
        calculatedSize = 0;
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

    public void setBitfield(byte[] header, AtomTitle title) {
        int mask = (1 << def.getSize()) - 1;
        int val = map.get(atomFieldExtractor.apply(title));
        if (val >= mask) {
            throw new RuntimeException("Value " + val + " too large for " + name);
        }
        header[def.getByteOffset()] &= ~(mask << def.getBitOffset());
        header[def.getByteOffset()] |= (val << def.getBitOffset());
    }

    public String testIndex(AtomTitle title) {
        String val = atomFieldExtractor.apply(title);
        Integer id = map.get(val);
        if (id == null) {
            return null;
        } else {
            return val;
        }
    }
}
