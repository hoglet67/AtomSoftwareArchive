package uk.co.acornatom.afsutils;

public class DiskObject {

    public static final int SECT_SIZE = 256;

    public int read8(byte[] bytes, int offset) {
        return bytes[offset] & 0xff;
    }

    public int read16(byte[] bytes, int offset) {
        return read8(bytes, offset) + (read8(bytes, offset + 1) << 8);
    }

    public int read24(byte[] bytes, int offset) {
        return read8(bytes, offset) + (read8(bytes, offset + 1) << 8) + (read8(bytes, offset + 2) << 16);
    }

    public int read32(byte[] bytes, int offset) {
        return read16(bytes, offset) + (read16(bytes, offset + 2) << 16);
    }

    public String readString(byte[] bytes, int offset, int length) {
        StringBuffer sb = new StringBuffer(length);
        for (int i = 0; i < length; i++) {
            sb.append((char) bytes[offset + i]);
        }
        return sb.toString();
    }

    public void write8(byte[] bytes, int offset, int value) {
        bytes[offset] = (byte) (value & 0xFF);
    }

    public void write16(byte[] bytes, int offset, int value) {
        write8(bytes, offset, value);
        write8(bytes, offset + 1, value >> 8);
    }

    public void write24(byte[] bytes, int offset, int value) {
        write8(bytes, offset, value);
        write8(bytes, offset + 1, value >> 8);
        write8(bytes, offset + 2, value >> 16);
    }

    public void write32(byte[] bytes, int offset, int value) {
        write8(bytes, offset, value);
        write8(bytes, offset + 1, value >> 8);
        write8(bytes, offset + 2, value >> 16);
        write8(bytes, offset + 3, value >> 24);
    }

    public void writeString(byte[] bytes, int offset, String value) {
        for (int i = 0; i < value.length(); i++) {
            write8(bytes, offset + i, value.charAt(i));
        }
    }

    public void writeString(byte[] bytes, int offset, String value, int length) {
        writeString(bytes, offset, value);
        for (int i = value.length(); i < length; i++) {
            write8(bytes, offset + i, ' ');
        }
    }

    public String pad(int n) {
        StringBuffer sb = new StringBuffer(n);
        for (int i = 0; i < n; i++) {
            sb.append(' ');
        }
        return sb.toString();
    }

}
