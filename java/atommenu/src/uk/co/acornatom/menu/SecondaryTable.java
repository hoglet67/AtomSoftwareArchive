package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Set;

public abstract class SecondaryTable extends TableBase {

    protected BitField def;
    protected Map<String, Integer> map;
    protected boolean includeCounts = true;

    private int maxLen;

    protected SecondaryTable (String name,
            BitField def,
            Map<String, Integer> map
            ) {
        super(name);
        this.def = def;
        this.map = map;
        this.maxLen = 0;
        this.debug = false;
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

    public abstract void setBitfield(byte[] header, AtomTitle title);

    public abstract String testIndex(AtomTitle title);

    public abstract boolean isMultiValue();

    public SecondaryTable excludeCounts() {
        this.includeCounts = false;
        return this;
    }

    public SecondaryTable includeCounts() {
        this.includeCounts = true;
        return this;
    }

    public void assignIndexes() {
        int index = 0;
        for (String key : map.keySet()) {
            map.replace(key, index++);
        }
    }

    public void dumpIndexes() {
        System.out.println("==========================================================");
        System.out.println(name);
        System.out.println("==========================================================");
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            System.out.println(entry.getValue() + "\t" + entry.getKey());
        }
        System.out.println(String.format("Index %16s uses %3d entries; max is %3d", name, map.size(), (1 << def.getSize())));
    }

    public int getMaxLen() {
        return maxLen;
    }

    public byte[] createTable(int absoluteAddress) throws IOException {
        return createTable(absoluteAddress, null);
    }

    @Override
    public int calculateSize(List<AtomTitle> titles) {
          int calculatedSize = map.size() * 2 + 4;
          for (Map.Entry<String, Integer> entry : map.entrySet()) {
              String key = entry.getKey();
              calculatedSize += key.length();
              if (includeCounts) {
                  calculatedSize += 4; // Space for the counts
              } else {
                  calculatedSize++; // Just a terminator
              }
          }
          calculatedSize++;
          return calculatedSize;
    }

    @Override
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
            absoluteAddress += (titles != null ? 4 : 1) + entry.getKey().length();
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
                writeByte(bos, (byte)(0x80 | ((count >> 8) & 0x7f)));
                writeByte(bos, (byte)(count & 0xff));
                writeShort(bos, 0);
                writeString(bos, key);
            } else {
                writeString(bos, key);
                writeByte(bos, -1);
            }
        }
        writeByte(bos, -1);
        if (debug) {
            System.out.println("length " + bos.size() + " bytes");
        }
        byte[] bytes = bos.toByteArray();
        return bytes;
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
