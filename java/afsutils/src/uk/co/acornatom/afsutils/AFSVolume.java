package uk.co.acornatom.afsutils;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import org.apache.commons.io.IOUtils;

public class AFSVolume extends ADFSVolume {

    protected int afs_start_sector;
    protected int afs_end_sector;
    protected int afs_sectors_per_track;

    protected String disk_id;
    protected String disk_title;
    protected int afs_tracks;
    protected int afs_sectors;
    protected int num_disks;
    protected int num_sectors_per_track;
    protected int num_sectors_per_bitmap;
    protected int root_sin;
    protected int init_date;
    protected int first_free_track;

    protected byte[] diskInfoBlock;

    protected byte[] root_jesmap;

    protected byte[] free_space_map;

    protected AFSDirectory rootDir;

    public AFSVolume(File file, String mode) throws IOException {
        super(file, mode);
    }

    public void parseDiskInfoBlock() throws IOException {
        super.parseFreeSpaceMap();
        afs_start_sector = read24(sector0, 0xf6) - 1;
        afs_sectors_per_track = read24(sector1, 0xf6) - read24(sector0, 0xf6);
        System.out.println("ADFS:      AFS Start Sector = " + afs_start_sector);
        System.out.println("ADFS: AFS Sectors Per Track = " + afs_sectors_per_track);
        System.out.println();
        diskInfoBlock = readSector(afs_start_sector + 1);

        // NFS Sector 1 - Disk Information Block
        // -------------------------------------
        // This is &100 bytes into the Level 3 FS partition, and is pointed to
        // by the
        // pointer at &F6-&F8 in sector 0.
        //
        // 00-03: "AFS0" identifier.
        // 04-13: Disk title, padded with spaces if less than 16 characters.
        // 14-15: Number of tracks (cylinders) on whole disk.
        // 16-18: Number of sectors on whole disk, ie &000A00 for a 640K floppy.
        // 19 : Number of physical disks on file server, usually 1.
        // 1A-1B: Number of sectors per track, ie 16 for a 640K floppy.
        // 1C : Number of sectors per bitmap, usually 1.
        // 1D : Increment to next drive, usually 0 for only one drive.
        // 1E : Unused, set to zero.
        // 1F-21: System Internal Name (SIN) of root directory.
        // 22-23: Initialisation date in filing system standard date format.
        // 24-25: First free cylinder.

        disk_id = readString(diskInfoBlock, 0x00, 0x04);
        disk_title = readString(diskInfoBlock, 0x04, 0x10);
        int num_tracks = read16(diskInfoBlock, 0x14);
        int num_sectors = read24(diskInfoBlock, 0x16);
        num_disks = read8(diskInfoBlock, 0x19);
        num_sectors_per_track = read16(diskInfoBlock, 0x1A);
        num_sectors_per_bitmap = read8(diskInfoBlock, 0x1B);
        root_sin = read24(diskInfoBlock, 0x1F);
        init_date = read16(diskInfoBlock, 0x22);
        first_free_track = read16(diskInfoBlock, 0x24);

        System.out.println("AFS:                disk_id = " + disk_id);
        System.out.println("AFS:             disk_title = " + disk_title);
        System.out.println("AFS:             num_tracks = " + num_tracks);
        System.out.println("AFS:            num_sectors = " + num_sectors);
        System.out.println("AFS:              num_disks = " + num_disks);
        System.out.println("AFS:  num_sectors_per_track = " + num_sectors_per_track);
        System.out.println("AFS: num_sectors_per_bitmap = " + num_sectors_per_bitmap);
        System.out.println("AFS:               root_sin = " + root_sin);
        System.out.println("AFS:              init_date = " + init_date);
        System.out.println("AFS:       first_free_track = " + first_free_track);
        System.out.println();

        // Sanity check
        if (afs_sectors_per_track != num_sectors_per_track) {
            throw new AFSException("afs_nd adfs disagree on cylinder size", afs_start_sector + 1);
        }

        if (num_sectors % num_sectors_per_track != 0) {
            throw new AFSException("num_sectors not on an integer number of cylinders", afs_start_sector + 1);
        }

        if (afs_start_sector % num_sectors_per_track != 0) {
            throw new AFSException("afs_start_sector not on a cylinder boundary", afs_start_sector + 1);
        }

        // Update num_tracks so it reflects just the size of the AFS volume
        afs_sectors = num_sectors - afs_start_sector;
        afs_tracks = afs_sectors / num_sectors_per_track;

        System.out.println("AFS:            afs_sectors = " + afs_sectors);
        System.out.println("AFS:             afs_tracks = " + afs_tracks);

    }

    protected void dumpFreeSpaceMap() {
        for (int i = 0; i < afs_tracks; i++) {
            for (int j = 0; j < num_sectors_per_track; j++) {
                byte m = free_space_map[i * num_sectors_per_track + j];
                if (m == 0) {
                    System.out.print("*");
                } else {
                    System.out.print(".");
                }
            }
            System.out.println();
        }
    }

    protected void readFreeSpaceMap() throws IOException {
        byte[] sector = new byte[SECT_SIZE];
        free_space_map = new byte[num_sectors_per_track * afs_tracks];
        int m = 0;
        for (int i = 0; i < afs_tracks; i++) {
            readSector(afs_start_sector + num_sectors_per_track * i, sector, 0, SECT_SIZE);
            for (int j = 0; j < num_sectors_per_track; j++) {
                byte bit = (byte) ((sector[j >> 3] >> (j & 7)) & 1);
                free_space_map[m++] = bit;
            }
        }
        dumpFreeSpaceMap();

    }

    protected int allocateSector() throws IOException {
        int i = 0;
        while (i < free_space_map.length && free_space_map[i] == 0) {
            i++;
        }
        if (i == free_space_map.length) {
            dumpFreeSpaceMap();
            throw new AFSException("Volume is full!", afs_start_sector);
        }
        free_space_map[i] = 0; // 0 = in use
        return afs_start_sector + i;
    }

    protected void freeSector(int sector) throws IOException {
        int i = sector - afs_start_sector;
        if (free_space_map[i] == 1) {
            throw new AFSException("Freeing free sector", sector);
        }
        free_space_map[i] = 1; // 1 = free
    }

    protected void parseRootDirectory() throws IOException {
        rootDir = new AFSDirectory(this, root_sin);
        rootDir.dump(true, 0);
    }

    protected void addFile(String path, int load, int exec, byte[] bytes) throws IOException {

        System.out.println("Adding " + path + " load=" + Integer.toHexString(load) + " exec=" + Integer.toHexString(exec) + " len="
                + bytes.length);

        AFSDirectory dir = rootDir;

        while (path.contains("/")) {
            int pos = path.indexOf("/");
            String name = path.substring(0, pos);
            path = path.substring(pos + 1);
            dir = dir.addDir(name);
        }

        dir.addFile(path, load, exec, bytes);
    }

    public void addZip(File file) throws IOException {
        ZipFile zipFile = new ZipFile(file);
        Enumeration<? extends ZipEntry> entries = zipFile.entries();
        while (entries.hasMoreElements()) {
            ZipEntry entry = entries.nextElement();
            if (!entry.isDirectory()) {
                InputStream in = zipFile.getInputStream(entry);
                ByteArrayOutputStream out = new ByteArrayOutputStream();
                IOUtils.copy(in, out);
                in.close();
                out.close();

                byte[] extra = entry.getExtra();
                // System.out.println("LEN = " + extra.length);
                // for (int i = 0; i < extra.length; i++) {
                // System.out.print(Integer.toHexString(extra[i] & 0xff) + " ");
                // }
                // System.out.println();
                int load = 0;
                int exec = 0;
                // 0 extra header id 2 bytes "AC"
                // 2 extra header sublength 2 bytes ------------v
                // 4 Acorn header id 4 bytes "ARC0" 4
                // 8 load address 4 bytes 8
                // 12 execution address 4 bytes 12
                // 16 attributes 4 bytes 16
                // 20 &00000000 4 bytes 20
                // 24 creation time 2 bytes 22
                // 26 creation date 2 bytes 24
                // 28 main account number 2 bytes 26
                // 30 auxilary account number 2 bytes 28
                int i = 0;
                while (i < extra.length) {
                    int id = read16(extra, i);
                    int len = read16(extra, i + 2);
                    if (id == 0x4341) {
                        load = read32(extra, i + 8);
                        exec = read32(extra, i + 12);
                        break;
                    }
                    i += len + 4;
                }
                addFile(entry.getName(), load, exec, out.toByteArray());
            }
        }
        System.out.println("Closing zip file");
        zipFile.close();
    }
}
