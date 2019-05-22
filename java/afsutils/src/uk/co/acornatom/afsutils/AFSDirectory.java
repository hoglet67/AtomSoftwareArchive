package uk.co.acornatom.afsutils;

import java.io.IOException;
import java.util.Arrays;

public class AFSDirectory extends JesMap {

    public static final int ENTRY_SIZE = 0x1A;
    public static final int NAME_SIZE = 0x0A;

    // Directory Header
    // ----------------
    // 00-01: Pointer to first entry in directory
    // 02 : Cycle number of directory, same as last byte
    // 03-0C: Directory name padded with spaces
    // 0D-0E: Pointer to first free entry in directory
    // 0F : Number of entries in directory
    // 10 : Unused, set to zero

    // Directory Entries
    // -----------------
    // 00-01: Pointer to next entry in the list
    // 02-0B: Object name padded with spaces
    // 0C-0F: Load address
    // 10-13: Execution address
    // 14 : Access byte in internal NFS format:
    // b7 : reserved
    // b6 : reserved
    // b5 : directory
    // b4 : locked
    // b3 : owner write
    // b2 : owner read
    // b1 : public write
    // b0 : public read
    // Files are created with 'WR/' access, directories are created with
    // 'DL/' access.
    // 15-16: Modification date in standard format
    // 17-19: SIN of object

    // Directory Footer
    // ----------------
    // xxx : Copy of cycle number.

    byte[] directory;

    private void createBackLink(AFSDirectory parent) throws IOException {
        if (parent != null && getEntry(BACK_LINK) == null) {
            DirectoryEntry entry = createEntry(BACK_LINK);
            entry.setAccessByte(0x30);
            entry.setSin(parent.getSin());
        }
    }

    public AFSDirectory(AFSVolume volume, AFSDirectory parent, String name) throws IOException {
        super(volume);
        directory = new byte[SECT_SIZE * 4];
        Arrays.fill(directory, (byte) 0);
        setName(name);
        int offset = directory.length - 1 - ENTRY_SIZE;
        // Link all the directory entries together backwards!
        setFree(offset);
        while (offset > 0) {
            int next = offset - ENTRY_SIZE;
            if (next <= 0x10) {
                next = 0;
            }
            write16(directory, offset, next);
            offset = next;
        }
        createBackLink(parent);
    }

    public AFSDirectory(AFSVolume volume, AFSDirectory parent, int sin) throws IOException {
        super(volume, sin);
        directory = getBytes();
        int cycle1 = read8(directory, 0x02);
        int cycle2 = read8(directory, directory.length - 1);
        if (cycle2 != cycle1) {
            throw new AFSException("Mismatched directory cycle numbers", sin);
        }
        createBackLink(parent);   
    }

    private void saveDirectory() throws IOException {
        setBytes(directory);
    }

    private int getFirst() {
        return read16(directory, 0x00);
    }

    private void setFirst(int first) {
        write16(directory, 0x00, first);
    }

    private int getFree() {
        return read16(directory, 0x0D);
    }

    private void setFree(int free) {
        write16(directory, 0x0D, free);
    }

    private int getNumEntries() {
        return read16(directory, 0x0F);
    }

    private void setNumEntries(int numEntries) {
        write16(directory, 0x0F, numEntries);
    }

    private String getName() {
        return readString(directory, 0x03, NAME_SIZE, ' ');
    }

    private void setName(String name) {
        writeString(directory, 0x03, name, NAME_SIZE);
    }

    public void dump(boolean recurse, int depth) throws IOException {
        int pointer;
        String pad = pad(depth * 8);
        System.out.println(pad + "DIR: sin = " + Integer.toHexString(getSin()));
        System.out.println(pad + "DIR: length = " + directory.length);
        System.out.println(pad + "DIR: first = " + getFirst());
        System.out.println(pad + "DIR: name = " + getName());
        System.out.println(pad + "DIR: num_entries = " + getNumEntries());
        // System.out.println(pad + "DIR: cycle1 = " + cycle1);
        // System.out.println(pad + "DIR: cycle2 = " + cycle2);

        pointer = getFirst();
        while (pointer != 0) {
            DirectoryEntry entry = new DirectoryEntry(directory, pointer);
            entry.dump(depth, true);
            if (recurse && entry.isDirectory() && !entry.getName().equals(BACK_LINK)) {
                AFSDirectory child = new AFSDirectory(getVolume(), null, entry.getSin());
                child.dump(recurse, depth + 1);
            }
            pointer = entry.getNext();
        }
        pointer = getFree();
        while (pointer != 0) {
            DirectoryEntry entry = new DirectoryEntry(directory, pointer);
            entry.dump(depth, false);
            pointer = entry.getNext();
        }
    }

    private DirectoryEntry getEntry(String name) {
        int pointer = getFirst();
        while (pointer != 0) {
            DirectoryEntry entry = new DirectoryEntry(directory, pointer);
            // System.out.println("Scanning name >" + entry.getName() + "<");
            if (entry.getName().equals(name)) {
                return entry;
            }
            pointer = entry.getNext();
        }
        return null;
    }

    private DirectoryEntry createEntry(String name) throws IOException {
        System.out.println("Create " + name + " in " + getName() + " sin " + getSin());
        if (getEntry(name) != null) {
            throw new AFSException("Directory already contains " + name, 0);
        }
        if (getFree() == 0) {
            throw new AFSException("Directory full", 0);
        }
        DirectoryEntry newEntry = new DirectoryEntry(directory, getFree());
        setFree(newEntry.getNext());
        newEntry.setName(name);

        setNumEntries(getNumEntries() + 1);

        int pointer = getFirst();
        if (pointer == 0) {
            // The directory is empty, so make this the first entry
            setFirst(newEntry.getOffset());
            newEntry.setNext(0);
        } else {
            // Work down the entry list until the next entry is greater than
            // this one
            // or there is no next entry
            DirectoryEntry lastEntry = null;
            while (true) {
                DirectoryEntry entry = (pointer > 0) ? new DirectoryEntry(directory, pointer) : null;
                if (entry == null || entry.compareTo(newEntry) > 0) {
                    if (lastEntry == null) {
                        setFirst(newEntry.getOffset());
                    } else {
                        lastEntry.setNext(newEntry.getOffset());
                    }
                    if (entry == null) {
                        newEntry.setNext(0);
                    } else {
                        newEntry.setNext(entry.getOffset());
                    }
                    break;
                }

                lastEntry = entry;
                pointer = entry.getNext();
            }
        }
        return newEntry;
    }

    private void checkName(String name) throws AFSException {
        if (name.length() > NAME_SIZE) {
            throw new AFSException("Name too long: " + name, 0);
        }
    }

    protected AFSFile addFile(String name, int load, int exec, byte[] bytes) throws IOException {
        checkName(name);
        DirectoryEntry entry = createEntry(name);
        AFSFile file = new AFSFile(getVolume());
        file.setBytes(bytes);
        entry.setLoadAddress(load);
        entry.setExecAddress(exec);
        entry.setAccessByte(0x0F);
        entry.setSin(file.getSin());
        saveDirectory();
        return file;
    }

    protected AFSDirectory addDir(String name) throws IOException {
        checkName(name);
        AFSDirectory dir;
        DirectoryEntry entry = getEntry(name);
        if (entry != null) {
            if (entry.isDirectory()) {
                dir = new AFSDirectory(getVolume(), this, entry.getSin());
            } else {
                throw new AFSException("Add Dir: found a file instead", 0);
            }
        } else {
            entry = createEntry(name);
            dir = new AFSDirectory(getVolume(), this, name);
            entry.setAccessByte(0x30);
            entry.setSin(dir.getSin());
            saveDirectory();
            dir.saveDirectory();
        }
        return dir;
    }
}
