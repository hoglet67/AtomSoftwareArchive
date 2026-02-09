package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

public class TitleTable extends TableBase {

    private boolean debug;
    private int titleHeaderSize;

    public TitleTable(boolean debug, int titleHeaderSize) {
        this.debug = debug;
        this.titleHeaderSize = titleHeaderSize;
    }

    public byte[] createTable(int absoluteAddress, List<AtomTitle> items, SecondaryTable[] secondaryTables) throws IOException {
        if (debug) {
            System.out.println("----------------------------------------");
            System.out.println("Title Table");
            System.out.println("----------------------------------------");
            System.out.println("address " + Integer.toHexString(absoluteAddress));
        }
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

}
