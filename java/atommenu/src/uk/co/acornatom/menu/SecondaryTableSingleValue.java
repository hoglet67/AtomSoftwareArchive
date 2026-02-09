package uk.co.acornatom.menu;

import java.util.Comparator;
import java.util.Map;
import java.util.TreeMap;
import java.util.function.Function;

public class SecondaryTableSingleValue extends SecondaryTable {

    private Function<? super AtomTitle, ? extends String> spreadsheetFieldExtractor;

    public SecondaryTableSingleValue (
            String name,
            Function<? super AtomTitle, ? extends String> atomFieldExtractor,
            Function<? super AtomTitle, ? extends String> spreadsheetItemExtractor
            ) {
        this(name, atomFieldExtractor, spreadsheetItemExtractor, new TreeMap<String, Integer>());
    }

    public SecondaryTableSingleValue (
            String name,
            Function<? super AtomTitle, ? extends String> atomFieldExtractor,
            Function<? super AtomTitle, ? extends String> spreadsheetItemExtractor,
            Map<String, Integer> map
            ) {
        this(name, atomFieldExtractor, spreadsheetItemExtractor, Comparator.naturalOrder(), map);
    }

    public SecondaryTableSingleValue (String name,
            Function<? super AtomTitle, ? extends String> atomFieldExtractor,
            Function<? super AtomTitle, ? extends String> spreadsheetItemExtractor,
            Comparator<String> comparator) {
        this(name, atomFieldExtractor, spreadsheetItemExtractor, comparator, new TreeMap<String, Integer>(comparator));
    }

    public SecondaryTableSingleValue (String name,
            Function<? super AtomTitle, ? extends String> atomFieldExtractor,
            Function<? super AtomTitle, ? extends String> spreadsheetItemExtractor,
            Comparator<String> comparator,
            Map<String, Integer> map) {
        super(name, atomFieldExtractor, comparator, map);
        this.spreadsheetFieldExtractor = spreadsheetItemExtractor;
    }

    @Override
    public void addToIndex(AtomTitle item) {
        String value = spreadsheetFieldExtractor.apply(item);
        put(value, -1);
    }

    @Override
    public boolean match(AtomTitle title, String value) {
        String titleValue = atomFieldExtractor.apply(title);
        return titleValue.equals(value);
    }



}
