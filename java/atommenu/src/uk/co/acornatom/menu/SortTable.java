package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class SortTable extends TableBase {

    private String name;
    private boolean debug;
    Comparator<AtomTitle> comparator;

    public SortTable(String name, boolean debug, Comparator<AtomTitle> comparator) {
        this.name = name;
        this.debug = debug;
        this.comparator = comparator;
    }

    public byte[] createTable(List<AtomTitle> items) throws IOException {
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
}
