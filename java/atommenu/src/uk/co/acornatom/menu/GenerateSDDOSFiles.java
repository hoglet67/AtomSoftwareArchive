package uk.co.acornatom.menu;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;

public class GenerateSDDOSFiles extends GenerateDiskImageFiles {

    public static final int SD_SEC_SIZE = 512;
    public static final int SD_NUM_SECS = 204632;

    public static final int SDCARD_SIZE = SD_NUM_SECS * SD_SEC_SIZE;

    private File sdImageFile;
    byte[] SDimage;
    
    public GenerateSDDOSFiles(File archiveDir, String menuBase, int numChunks, File imageFile)
            throws IOException {
        super(archiveDir, menuBase, numChunks);
        this.sdImageFile = imageFile;
        createSDImage();
    }

    // ;=================================================================
    // ; SD-CARD:
    // ;=================================================================
    // ; The format of the SD-card is:
    // ;
    // ; sector Description
    // ;------------------------------------------------------
    // ; 0 - 31 DISKTABLE + DISK INFORMATION TABLE
    // ; 32 - 231 DISK IMAGE 0000
    // ; 232 - 463 DISK IMAGE 0001
    // ; .. .. ..
    // ; .. .. ..
    // ; 104432 - 204631 DISK IMAGE 1022
    // ;
    // ;------------------------------------------------------
    // ; DISKTABLE (16 bytes)
    // ;------------------------------------------------------
    // ; 0,1 - Current diskette number in drive 0
    // ; 2,3 - Current diskette number in drive 1
    // ; 4,5 - Current diskette number in drive 2
    // ; 6,7 - Current diskette number in drive 3
    // ; 8-F - Unused
    // ;------------------------------------------------------
    // ;
    // ;------------------------------------------------------
    // ; DISKINFO TABLE (1023 * 16 bytes)
    // ;------------------------------------------------------
    // ; 0-C - Diskname
    // ; D,E - Unused
    // ; F - Diskette Status 00 = Read Only
    // ; 0F = R/W
    // ; F0 = Unformatted
    // ; FF = No valid diskno.
    // ;------------------------------------------------------

    int[] diskTable = { 0, 0, 1, 0, 2, 0, 3, 0, 'S', 'D', 'D', 'O', 'S', ' ', ' ', ' ' };

    protected void createSDImage() throws IOException {
        byte[] SDimage = new byte[SDCARD_SIZE];
        Arrays.fill(SDimage, (byte) 0xFF);
        for (int i = 0; i < diskTable.length; i++) {
            SDimage[i] = (byte) diskTable[i];
        }
        this.SDimage = SDimage;
        createMenuDisk(0, 1016);
    }

    protected void addDisk(byte[] image, SpreadsheetTitle item) throws IOException {
        // In the SDDOS image we use the compressed index identifier
        addDisk(image, item.getIndex());
    }
    
    @Override
    protected void addDisk(byte[] image, int diskNum) throws IOException {
        if (diskNum > 1022) {
            throw new RuntimeException("diskNum of " + diskNum + " too large");
        }        
        // *** RAW SD IMAGE FILE ***
        // Copy the disk title
        for (int i = 0; i < 13; i++) {
            SDimage[16 + diskNum * 16 + i] = image[i < 8 ? i : i + 248];
        }
        // Unused
        SDimage[16 + diskNum * 16 + 13] = (byte) 0x88;
        SDimage[16 + diskNum * 16 + 14] = (byte) 0x88;
        // Set the Diskette Status to R/W
        SDimage[16 + diskNum * 16 + 15] = 15;
        // Copy the disk data
        System.arraycopy(image, 0, SDimage, SD_SEC_SIZE * (32 + diskNum * 200), image.length);
        
        // Also write the disk to the file system
        writeDiskFile(new File("disks/" + diskNum), image);
    }
    

    public void writeImage() throws IOException {
        System.out.println("Writing SDDOS SD Card Image: " + sdImageFile);
        FileOutputStream fos = new FileOutputStream(sdImageFile);
        fos.write(SDimage);
        fos.close();
    }
    
    private void writeDiskFile(File file, byte[] image) throws IOException {
        System.out.println("Writing DSK Image: " + file);
        FileOutputStream fos = new FileOutputStream(file);
        fos.write(image);
        fos.close();
    }
    

    
}
