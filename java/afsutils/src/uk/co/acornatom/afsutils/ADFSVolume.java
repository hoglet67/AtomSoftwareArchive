package uk.co.acornatom.afsutils;

import java.io.File;
import java.io.IOException;

public class ADFSVolume extends Volume {

    protected byte[] sector0;
    protected byte[] sector1;

    public ADFSVolume(File f, String mode) throws IOException {
        super(f, mode);
        sector0 = readSector(0);
        sector1 = readSector(1);
    }

    // Sector 0/1 - ADFS Free Space Map
    // --------------------------------
    // The Level 3 File Server filesystem coexists on the disk with an ADFS
    // filesystem. The first two sectors contain the ADFS free space map with
    // pointers to the start of the Level 3 FS partition.
    //
    // 000-002 Start sector of first ADFS free space
    // 003-005 Start sector of second ADFS free space
    // 006-008 Start sector of third ADFS free space
    // ...
    // 0F6-0F8 (Start of Level 3 FS partition)+1
    // Note that RISC OS stores half the disk name at 0F7-0FB,
    // interleaved with the even characters at 1F6-1FA.
    // 0F9-0FB Reserved (set to zero)
    // 0FC-0FE Total number of sectors on disk
    // 0FF Checksum of sector 0
    //
    // 100-102 Length of first ADFS free space
    // 103-105 Length of second ADFS free space
    // 106-108 Length of third ADFS free space
    // ...
    // 1F6-1F8 (Start of Level 3 FS partition)+1+sectors_per_track
    // Note that RISC OS stores half the disk name at 1F6-1FA,
    // interleaved with the odd characters at 0F7-0FB)
    // 1FB-1FC ADFS Disk identifier
    // 1FD ADFS Boot option, set with *OPT 4
    // 1FE Pointer to end of ADFS free space list
    // ie, 3*(number of free space blocks)
    // 1FF Checksum of sector 1
    //
    // The relevant information for the Level 3 FS filesystem is:
    //
    // 0F6-0F8 (Start of Level 3 FS partition)+1
    // 1F6-1F8 (Start of Level 3 FS partition)+1+sectors_per_track

    public int calculateChecksum(byte[] sector) {
        int sum = 255;
        for (int i = SECT_SIZE - 2; i >= 0; i--) {
            if (sum > 0xff) {
                sum = (sum + 1) & 0xff;
            }
            sum = sum + read8(sector, i);
        }
        return sum & 0xff;
    }

    public boolean validateChecksum(byte[] sector) {
        int sum_expected = sector[SECT_SIZE - 1] & 0xff;
        int sum_actual = calculateChecksum(sector);
        return sum_actual == sum_expected;
    }

    public void parseFreeSpaceMap() {
        System.out.println("ADFS:     Sector 0 checksum = " + (validateChecksum(sector0) ? "valid" : "invalid"));
        System.out.println("ADFS:     Sector 1 checksum = " + (validateChecksum(sector0) ? "valid" : "invalid"));
        int end_of_free_space_list = read8(sector1, 0xfe);
        int end_of_free_space = read24(sector0, end_of_free_space_list) + read24(sector1, end_of_free_space_list);
        System.out.println("ADFS:    End of ADFS Volume = " + end_of_free_space);
    }
}
