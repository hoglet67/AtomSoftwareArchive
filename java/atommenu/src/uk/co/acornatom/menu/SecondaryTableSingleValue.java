package uk.co.acornatom.menu;

import java.util.Comparator;
import java.util.Map;
import java.util.TreeMap;
import java.util.function.Function;

public class SecondaryTableSingleValue extends SecondaryTable {


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
        super(name, def, atomFieldExtractor, map);
    }

    public SecondaryTableSingleValue (String name,
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



}
