package uk.co.acornatom.menu;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

public class GenerateSDDOS2Files extends GenerateDiskImageFiles {

    public static final int SD_SEC_SIZE = 512;
    public static final int SD_NUM_SECS = 204632;

    public static final int SDCARD_SIZE = SD_NUM_SECS * SD_SEC_SIZE;

    private File sdImageFile;
    byte[] SDimage;

    public GenerateSDDOS2Files(File archiveDir, String menuBase, int numChunks, File imageFile)
            throws IOException {
        super(archiveDir, menuBase, numChunks);
        this.sdImageFile = imageFile;
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

    protected void createSDImage(Target target) throws IOException {
        byte[] SDimage = new byte[SDCARD_SIZE];
        Arrays.fill(SDimage, (byte) 0xFF);
        for (int i = 0; i < diskTable.length; i++) {
            SDimage[i] = (byte) diskTable[i];
        }
        this.SDimage = SDimage;
        createMenuDisks(target);
    }

    @Override
    protected String getMenuDiskName() {
        return "0";
    }

    @Override
    protected String getChapterDiskName(int chunk) {
        return "" + (1 + chunk);
    }

    protected int calcFileSpace(File archiveDir, SpreadsheetTitle item) {
        int total = 0;
        for (String filename : item.getFilenames()) {
            File file = new File(new File(archiveDir, item.getDir()), filename);
            total += (file.length() + 0xFF) & 0xFFFF00;
        }
        // Account for boot file
        total += 0x100;
        return total;
    }

    protected boolean areItemsCombinable(File archiveDir, SpreadsheetTitle item1, SpreadsheetTitle item2) {

        int item1_numFiles = item1.getFilenames().size();
        int item2_numFiles = item2.getFilenames().size();

        // 29 allows two free catalog entries for the boot files
        if (item1_numFiles + item2_numFiles > 29) {
            System.out.println("Not combinable due to number of files:" + item1.getTitle() + " and " + item2.getTitle());
            return false;
        }

        int cat_space = 0x200;
        int item1_space = calcFileSpace(archiveDir, item1) + 0x100; // + 0x100 to allow for boot file
        int item2_space = calcFileSpace(archiveDir, item2) + 0x100;

        if (cat_space + item1_space + item2_space > 40 * 10 * 0x100) {
            System.out.println("Not combinable due to space:" + item1.getTitle() + " and " + item2.getTitle());
            return false;
        }

        HashSet<String> filenames = new HashSet<String>();
        filenames.addAll(item1.getFilenames());
        filenames.addAll(item2.getFilenames());
        if (filenames.size() != item1_numFiles + item2_numFiles) {
            System.out.println("Not combinable due to name conflicts:" + item1.getTitle() + " and " + item2.getTitle());
            return false;
        }

        return true;
    }

    @Override
    public void allocateDisks(List<SpreadsheetTitle> items) throws IOException {
        super.allocateDisks(items);
        // Generate disk numbers up front, combining pairs of titles if possible
        // (this is just used by SDDOS)
        int diskNo = numChunks; // Skip the menu disks
        SpreadsheetTitle lastItem = null;
        for (SpreadsheetTitle item : items) {
            // Test if two items are combinable
            if (lastItem != null && areItemsCombinable(archiveDir, item, lastItem)) {
                // Append the item to the current disk
                item.setDiskNo(diskNo * 2 + 1);
                lastItem = null;
            } else {
                // Start a new disk for this item
                diskNo++;
                item.setDiskNo(diskNo * 2);
                lastItem = item;
            }
        }
    }

    @Override
    protected void addDisk(byte[] image, String name) throws IOException {
        int diskNum = Integer.parseInt(name);
        addDisk(image, diskNum);
    }

    private void addDisk(byte[] image, int diskNum) throws IOException {
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
    }

    @Override
    public void generateFiles(List<SpreadsheetTitle> items, Target target) throws IOException {
        createSDImage(target);
        byte[] image = null;
        Integer diskNo = null;
        for (SpreadsheetTitle item : items) {
            try {
                if ((item.getDiskNo() & 1) == 0) {
                    if (diskNo != null) {
                        addDisk(image, diskNo >> 1);
                    }
                    diskNo = item.getDiskNo();
                    image = createBlankDiskImage(item.getTitle());
                    addTitle(image, item, "BOOT0");
                } else {
                    addTitle(image, item, "BOOT1");
                }
            } catch (Exception e) {
                System.out.println("Problem DiskImage files for title " + item.getTitle());
                e.printStackTrace();
            }
        }
        try {
            if (diskNo != null) {
                addDisk(image, diskNo >> 1);
            }
        } catch (Exception e) {
            System.out.println("Problem DiskImage files for last title");
            e.printStackTrace();
        }
    }

    @Override
    public void writeImage() throws IOException {
        System.out.println("Writing SDDOS SD Card Image: " + sdImageFile);
        FileOutputStream fos = new FileOutputStream(sdImageFile);
        fos.write(SDimage);
        fos.close();
    }
}
