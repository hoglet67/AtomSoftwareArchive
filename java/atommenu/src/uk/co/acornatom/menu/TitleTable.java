package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

public class TitleTable extends TableBase {

    private boolean debug;

    public TitleTable(boolean debug) {
        this.debug = debug;
    }

    public byte[] createTable(int absoluteAddress, List<AtomTitle> items) throws IOException {
        if (debug) {
            System.out.println("----------------------------------------");
            System.out.println("Title Table");
            System.out.println("----------------------------------------");
            System.out.println("address " + Integer.toHexString(absoluteAddress));
        }
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        for (AtomTitle item : items) {
            item.setAbsoluteAddress(absoluteAddress + bos.size());
            writeShort(bos, item.getIndex() + (item.getGenreId() << 11));
            writeByte(bos, item.getPublisherId());
            writeByte(bos, (item.getCompatibleId() << 6) + item.getVersionId());
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
