package uk.co.acornatom.menu;

import java.util.Comparator;
import java.util.Map;
import java.util.TreeMap;
import java.util.function.Function;

public class SecondaryTableSingleValue extends SecondaryTable {

    protected Function<? super AtomTitle, ? extends String> atomFieldExtractor; // Extracts a single field for sorting


    public SecondaryTableSingleValue (
            String name,
            BitField def,
            Function<? super AtomTitle, ? extends String> atomFieldExtractor
            ) {
        this(name, def, atomFieldExtractor, new TreeMap<String, Integer>());
    }

    public SecondaryTableSingleValue (
            String name,
            BitField def,
            Function<? super AtomTitle, ? extends String> atomFieldExtractor,
            Map<String, Integer> map
            ) {
        super(name, def, map);
        this.atomFieldExtractor = atomFieldExtractor;
    }

    public SecondaryTableSingleValue (
            String name,
            BitField def,
            Function<? super AtomTitle, ? extends String> atomFieldExtractor,
            Comparator<String> comparator) {
        this(name, def, atomFieldExtractor, new TreeMap<String, Integer>(comparator));
    }

    @Override
    public void addToIndex(AtomTitle item) {
        String value = atomFieldExtractor.apply(item);
        put(value, -1);
    }

    @Override
    public boolean match(AtomTitle title, String value) {
        String titleValue = atomFieldExtractor.apply(title);
        return titleValue.equals(value);
    }

    @Override
    public void setBitfield(byte[] header, AtomTitle title) {
        int mask = (1 << def.getSize()) - 1;
        int offset = def.getByteOffset();
        int val = map.get(atomFieldExtractor.apply(title));
        if (val > mask) {
            throw new RuntimeException("Value " + val + " too large for " + name);
        }
        header[offset] &= ~(mask << def.getBitOffset());
        header[offset] |= (val << def.getBitOffset());
    }


    @Override
    public String testIndex(AtomTitle title) {
        String val = atomFieldExtractor.apply(title);
        Integer id = map.get(val);
        if (id == null) {
            return null;
        } else {
            return val;
        }
    }

    @Override
    public boolean isMultiValue() {
        return false;
    }
}
