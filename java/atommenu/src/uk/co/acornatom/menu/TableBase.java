package uk.co.acornatom.menu;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

public abstract class TableBase {

    protected boolean debug;
    protected String name;

    protected TableBase(String name) {
        this.name = name;
        this.debug = false;
    }

    public void setDebug(boolean debug) {
        this.debug = true;
    }

    protected void writeString(OutputStream out, String value) throws IOException {
        out.write(value.getBytes());
    }

    protected void writeShort(OutputStream out, int value) throws IOException {
        out.write(value & 0xff);
        out.write((value >> 8) & 0xff);
    }

    protected void writeByte(OutputStream out, int value) throws IOException {
        out.write(value & 0xff);
    }

    public abstract byte[] createTable(int absoluteAddress, List<AtomTitle> titles) throws IOException;

    public abstract int calculateSize(List<AtomTitle> titles);

    public String getName() {
        return name;
    }

}
