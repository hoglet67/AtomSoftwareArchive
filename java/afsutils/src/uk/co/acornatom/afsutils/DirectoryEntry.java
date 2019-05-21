package uk.co.acornatom.afsutils;

public class DirectoryEntry extends DiskObject {

    // Directory Entries
    // -----------------
    // 00-01: Pointer to next entry in the list
    // 02-0B: Object name padded with spaces
    // 0C-0F: Load address
    // 10-13: Execution address
    // 14 : Access byte in internal NFS format:
    // b7: reserved
    // b6: reserved
    // b5: directory
    // b4: locked
    // b3: owner write
    // b2: owner read
    // b1: public write
    // b0: public read
    // Files are created with 'WR/' access, directories are created with
    // 'DL/' access.
    // 15-16: Modification date in standard format
    // 17-19: SIN of object

    private byte[] directory;
    private int offset;
    private boolean used;

    public DirectoryEntry(byte[] directory, int offset) {
        this.directory = directory;
        this.offset = offset;
    }

    public int getOffset() {
        return offset;
    }

    public int getNext() {
        return read16(directory, offset + 0x00);
    }

    public void setNext(int next) {
        write16(directory, offset + 0x00, next);
    }

    public String getName() {
        return readString(directory, offset + 0x02, 10);
    }

    public void setName(String name) {
        writeString(directory, offset + 0x02, name, 10);
    }

    public int getLoadAddress() {
        return read32(directory, offset + 0x0C);
    }

    public void setLoadAddress(int loadAddress) {
        write32(directory, offset + 0x0C, loadAddress);
    }

    public int getExecAddress() {
        return read32(directory, offset + 0x10);
    }

    public void setExecAddress(int execAddress) {
        write32(directory, offset + 0x10, execAddress);
    }

    public int getAccessByte() {
        return read8(directory, offset + 0x14);
    }

    public void setAccessByte(int accessByte) {
        write8(directory, offset + 0x14, accessByte);
    }

    public int getLastModified() {
        return read16(directory, offset + 0x15);
    }

    public void setLastModified(int lastModified) {
        write16(directory, offset + 0x15, lastModified);
    }

    public int getSin() {
        return read24(directory, offset + 0x17);
    }

    public void setSin(int sin) {
        write24(directory, offset + 0x17, sin);
    }

    public boolean isDirectory() {
        return (getAccessByte() & 0x20) > 0;
    }

    public void dump(int depth) {
        String pad = pad(depth * 8);
        if (!used) {
            System.out.println(pad + "FREE Entry: (" + offset + ")");
        } else if (isDirectory()) {
            System.out.println(pad + "DIR Entry: (" + offset + ") " + getName() + " " + Integer.toHexString(getSin()));
        } else {
            System.out.println(pad + "FILE Entry: (" + offset + ") " + getName() + " " + Integer.toHexString(getSin()) + " "
                    + Integer.toHexString(getLoadAddress()) + " " + Integer.toHexString(getExecAddress()));
        }
    }
}
