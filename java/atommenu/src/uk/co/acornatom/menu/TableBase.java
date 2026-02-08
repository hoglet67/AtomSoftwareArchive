package uk.co.acornatom.menu;

import java.io.IOException;
import java.io.OutputStream;

public abstract class TableBase {

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
}
