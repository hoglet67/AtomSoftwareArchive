package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class SortTable extends TableBase {

    Comparator<AtomTitle> comparator;

    public SortTable(String name, Comparator<AtomTitle> comparator) {
        super(name);
        this.comparator = comparator;
    }

    @Override
    public byte[] createTable(int absoluteAddress, List<AtomTitle> items) throws IOException {
        if (debug) {
            System.out.println("----------------------------------------");
            System.out.println("Sort Table: " + name);
            System.out.println("----------------------------------------");
        }
        // Create a new list so the order of the original list remains unchanged
        items = new ArrayList<AtomTitle>(items);
        // Sort items using the specified
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

    @Override
    public int calculateSize(List<AtomTitle> titles) {
        // <NumTitles> <Pointer 0> ... <Pointer N-1> <0000>
        return 2 + titles.size() * 2 + 2;
    }
}
