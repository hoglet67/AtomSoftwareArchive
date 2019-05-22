package uk.co.acornatom.afsutils;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collection;
import java.util.SortedSet;
import java.util.TreeSet;

public class JesMap extends DiskObject {

    private static final String JESMAP = "JesMap";

    // Level 3 FS Allocation Map
    // -------------------------
    // 00-05: "JesMap" identifier.
    // 06 : Map chain squence number, 0 for final sector.
    // 07 : Unused, set to zero.
    // 08 : LSB of object length.
    // 09 : Unused, set to zero.
    // 0A-0E: First group of allocated sectors.
    // 0A-0C: Logical sector number.
    // 0D-0E: Number of logical sectors.
    // 0F-13: Second group of allocated sectors.
    // 0F-11: Logical sector number.
    // 12-13: Number of logical sectors.
    // ...
    // FA-FE: Final group of allocated sectors.
    // FA-FC: Logical sector number.
    // FD-FE: Number of logical sectors.
    // FF : Copy of map chain sequence number.

    private AFSVolume volume;
    private int sin;
    private byte[] jesmap;
    private boolean dirty = false;

    private int length_lsb;

    private SortedSet<Integer> sectors = new TreeSet<Integer>();

    public JesMap(AFSVolume volume) throws IOException {
        this.volume = volume;
        this.sin = volume.allocateSector();
        this.jesmap = new byte[SECT_SIZE];
        this.dirty = true;
    }

    public JesMap(AFSVolume volume, int sin) throws IOException {
        this.volume = volume;
        this.sin = sin;
        this.jesmap = volume.readSector(sin);
        this.dirty = false;

        String id = readString(jesmap, 0x00, 0x06, -1);
        if (!JESMAP.equals(id)) {
            throw new AFSException("JesMap not found", sin);
        }
        int chainSequence = read8(jesmap, 0x06);
        int chainSequence2 = read8(jesmap, 0xff);
        if (chainSequence != chainSequence2) {
            throw new AFSException("Mismatched chain sequence numbers", sin);
        }
        length_lsb = read8(jesmap, 0x08);
        int i = 0x0A;
        do {
            int sector = read24(jesmap, i);
            int num = read16(jesmap, i + 3);
            if (num == 0) {
                break;
            }
            for (int j = sector; j < sector + num; j++) {
                sectors.add(j);
            }
            i += 5;
        } while (i < 0xff);
    }

    public int getLength() {
        return sectors.size() * SECT_SIZE + length_lsb;
    }

    public Collection<Integer> getSectors() {
        return sectors;
    }

    public byte[] getBytes() throws IOException {
        int size = getLength();
        byte[] bytes = new byte[size];
        int offset = 0;
        for (int i : sectors) {
            int length = size >= SECT_SIZE ? SECT_SIZE : size;
            volume.readSector(i, bytes, offset, length);
            offset += length;
            size -= length;
        }
        return bytes;
    }

    private void flush(boolean force) throws IOException {
        if (force || this.dirty) {
            byte cycle = (byte) ((jesmap[0x06] + 1) & 0xff);
            Arrays.fill(jesmap, (byte) 0);
            writeString(jesmap, 0, JESMAP);
            jesmap[0x06] = cycle;
            jesmap[0x08] = (byte) (length_lsb & 0xff);
            jesmap[0xff] = cycle;
            int i = 0x0A;
            int last = -1;
            for (int sector : sectors) {
                // System.out.println("i = " + i + " Sector = " + sector + "
                // Last = " + last);
                if (last >= 0 && sector == last + 1) {
                    int num = read16(jesmap, i - 2);
                    write16(jesmap, i - 2, num + 1);
                } else {
                    write24(jesmap, i, sector);
                    write16(jesmap, i + 3, 1);
                    i += 5;
                    if (i >= 0xff) {
                        // throw new AFSException("JesMap full", this.sin);
                        System.out.println("*** WARNING JesMap full ****");
                        break;
                    }
                }
                last = sector;
            }
            volume.writeSector(sin, jesmap, 0, SECT_SIZE);
        }
        this.dirty = false;
    }

    public void setBytes(byte[] bytes) throws IOException {
        int oldSectors = sectors.size();
        int newSectors = (bytes.length + SECT_SIZE - 1) / SECT_SIZE;
        // System.out.println("sin = " + getSin() + " old = " + oldSectors + "
        // new = " + newSectors);
        if (newSectors > oldSectors) {
            for (int i = 0; i < newSectors - oldSectors; i++) {
                sectors.add(volume.allocateSector());
            }
        } else if (oldSectors > newSectors) {
            for (int i = 0; i < oldSectors - newSectors; i++) {
                int sector = sectors.last();
                sectors.remove(sector);
                volume.freeSector(sector);
            }
        }
        int size = bytes.length;
        this.length_lsb = size & 0xff;
        int offset = 0;
        for (int i : sectors) {
            int length = size >= SECT_SIZE ? SECT_SIZE : size;
            volume.writeSector(i, bytes, offset, length);
            offset += length;
            size -= length;
        }
        flush(true);
    }

    protected int getSin() {
        return sin;
    }

    protected AFSVolume getVolume() {
        return volume;
    }

}
