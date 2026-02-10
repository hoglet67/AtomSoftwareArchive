package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class TitleTable extends TableBase {

    private int titleHeaderSize;
    private SecondaryTable[] secondaryTables;
    private Comparator<AtomTitle> comparator;

    public TitleTable(String name, int titleHeaderSize, SecondaryTable[] secondaryTables, Comparator<AtomTitle> comparator) {
        super(name);
        this.titleHeaderSize = titleHeaderSize;
        this.secondaryTables = secondaryTables;
        this.comparator = comparator;
    }

    @Override
    public byte[] createTable(int absoluteAddress, List<AtomTitle> items) throws IOException {
        if (debug) {
            System.out.println("----------------------------------------");
            System.out.println("Title Table");
            System.out.println("----------------------------------------");
            System.out.println("address " + Integer.toHexString(absoluteAddress));
        }
        // Create a new list so the order of the original list remains unchanged
        items = new ArrayList<AtomTitle>(items);
        // Sort items using the specified
        Collections.sort(items, comparator);
        // Build the data for the table
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        for (AtomTitle item : items) {
            item.setAbsoluteAddress(absoluteAddress + bos.size());
            byte[] header = new byte[titleHeaderSize];
            header[0] = (byte) (item.getIndex() & 0xff);
            header[1] = (byte) ((item.getIndex() >> 8) & 0x07);
            for (int i = 1; i < secondaryTables.length - 1; i++) {
                secondaryTables[i].setBitfield(header, item);
            }
            bos.write(header);
            for (Integer collectionId : item.getCollectionIds()) {
                writeByte(bos, 128 + collectionId);
            }
            writeString(bos, item.getTitle());
            writeByte(bos, 0);
        }
        if (debug) {
            System.out.println("length " + bos.size() + " bytes");
        }
        return bos.toByteArray();
    }

    @Override
    public int calculateSize(List<AtomTitle> titles) {
        int size = 0;
        for (AtomTitle title : titles) {
            size += titleHeaderSize;
            size += title.getCollectionIds().size();
            size += title.getTitle().length() + 1;
        }
        return size;
    }

}
