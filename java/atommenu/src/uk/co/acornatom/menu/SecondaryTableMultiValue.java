package uk.co.acornatom.menu;

import java.util.Collection;
import java.util.Comparator;
import java.util.List;
import java.util.TreeMap;
import java.util.function.Function;

public class SecondaryTableMultiValue extends SecondaryTable {

    private Function<? super AtomTitle, ? extends Collection<String>> atomFieldExtractor;

    public SecondaryTableMultiValue (String name,
            BitField def,
            Function<? super AtomTitle, ? extends List<String>> atomFieldExtractor,
            Comparator<String> comparator) {
        super(name, def, new TreeMap<String, Integer>(comparator));
        this.atomFieldExtractor = atomFieldExtractor;
    }

    @Override
    public void addToIndex(AtomTitle title) {
        Collection<String> values = atomFieldExtractor.apply(title);
        for (String value : values) {
            put(value, -1);
        }
    }

    @Override
    public boolean match(AtomTitle title, String value) {
        Collection<String> values = atomFieldExtractor.apply(title);
        return values.contains(value);
    }


    @Override
    public void setBitfield(byte[] header, AtomTitle title) {
        if (def.getSize() != 7) {
            throw new RuntimeException("MultiValue secondary tables only support 7-bit IDs");
        }
        int mask = (1 << def.getSize()) - 1;
        int offset = def.getByteOffset();
        Collection<String> values = atomFieldExtractor.apply(title);
        for (String value : values) {
            Integer val = map.get(value);
            if (val >= mask) {
                throw new RuntimeException("Value " + val + " too large for " + name);
            }
            val |= 0x80; // TODO: Hack: The MSB is used to mark this as a CollectionID
            header[offset] &= ~(mask << def.getBitOffset());
            header[offset] |= (val << def.getBitOffset());
            offset++;
        }
    }

    @Override
    public String testIndex(AtomTitle title) {
        Collection<String> values = atomFieldExtractor.apply(title);
        boolean first = true;
        if (values.isEmpty()) {
            return "EMPTY";
        } else {
            StringBuffer sb = new StringBuffer();
            for (String value : values) {
                Integer id = map.get(value);
                if (!first) {
                    sb.append(",");
                }
                if (id == null) {
                    sb.append("NULL");
                } else {
                    sb.append(value);
                }
                first = false;
            }
            return sb.toString();
        }
    }

    @Override
    public boolean isMultiValue() {
        // TODO Auto-generated method stub
        return false;
    }
}
