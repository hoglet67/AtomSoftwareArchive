package uk.co.acornatom.menu;

import java.util.Collection;
import java.util.Comparator;
import java.util.List;
import java.util.TreeMap;
import java.util.function.Function;

public class SecondaryTableMultiValue extends SecondaryTable {

    private Function<? super AtomTitle, ? extends Collection<String>> atomFieldMatcher;

    public SecondaryTableMultiValue (String name,
            Function<? super AtomTitle, ? extends String> atomFieldExtractor,
            Function<? super AtomTitle, ? extends List<String>> atomFieldMatcher,
            Comparator<String> comparator) {
        super(name, atomFieldExtractor, comparator, new TreeMap<String, Integer>(comparator));
        this.atomFieldMatcher = atomFieldMatcher;
    }

    @Override
    public void addToIndex(AtomTitle item) {
        Collection<String> values = atomFieldMatcher.apply(item);
        for (String value : values) {
            put(value, -1);
        }
    }

    @Override
    public boolean match(AtomTitle title, String value) {
        Collection<String> titleValues = atomFieldMatcher.apply(title);
        return titleValues.contains(value);
    }
}
