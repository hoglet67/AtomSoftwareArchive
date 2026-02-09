package uk.co.acornatom.menu;

public class BitField {

    private int byteOffset;
    private int bitOffset;
    private int size;

    public  BitField(int byteOffset, int bitOffset, int size) {
        this.byteOffset = byteOffset;
        this.bitOffset = bitOffset;
        this.size = size;
        if (bitOffset + size > 8) {
            throw new RuntimeException("Invalid bitfield def: bitoffset=" + bitOffset + "; size=" + size);
        }
    }

    public int getByteOffset() {
        return byteOffset;
    }

    public int getBitOffset() {
        return bitOffset;
    }

    public int getSize() {
        return size;
    }
}
