package uk.co.acornatom.menu;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

public abstract class GenerateDiskImageFiles extends ArchiveGeneratorBase {

    protected static final int NUM_TRACKS = 40;
    protected static final int NUM_SECS_PER_TRACK = 10;
    protected static final int NUM_SECS = NUM_TRACKS * NUM_SECS_PER_TRACK;
    protected static final int CAT_SECS = 2;
    protected static final int CAT_FILES = 31;
    protected static final int SEC_SIZE = 256;

    protected File archiveDir;
    protected String menuBase;
    protected int numChapters;
    protected int sectorNum;
    protected String title;

    public GenerateDiskImageFiles(File archiveDir, String menuBase, int numChapters) {
        super();
        this.archiveDir = archiveDir;
        this.menuBase = menuBase;
        this.numChapters = numChapters;
    }

    abstract protected String getMenuDiskName();

    abstract protected String getChapterDiskName(int chapter);

    abstract protected void addDisk(byte[] image, String name) throws IOException;

    @Override
    abstract public void generateFiles(List<AtomTitle> items) throws IOException;

    @Override
    public void filterTitles(List<AtomTitle> items) throws IOException {
        dropOZMOOTitles(items);
        Iterator<AtomTitle> itemIterator = items.iterator();
        while (itemIterator.hasNext()) {
            AtomTitle item = itemIterator.next();
            if (item.getEstimatedDiskSectors() > NUM_SECS - CAT_SECS) {
                System.out.println("WARNING: dropping title from " + getTarget().name() + " because it's too large: " + item);
                itemIterator.remove();
            } else if (item.getFilenames().size() > CAT_FILES - 1) {
                System.out.println("WARNING: dropping title from " + getTarget().name() + " because it has too many files: " + item);
                itemIterator.remove();
            }
        }
    }

    @Override
    public void allocateDisks(List<AtomTitle> items) throws IOException {
        super.allocateDisks(items);
    }

    protected int getImageLen(byte[] image) {
        int lastUsedSector = -1;
        for (int i = 0; i < CAT_FILES; i++) {
            int dir = 256 + (i << 3) + 8;
            int file_start_sec = (image[7 + dir] & 0xff) + ((image[6 + dir] & 0x03) << 8);
            int file_len = (image[4 + dir] & 0xff) + ((image[5 + dir] & 0xff) << 8) + ((image[6 + dir] & 0x30) << 12);
            int file_end_sec = file_start_sec + (file_len >> 8);
            if (debug) {
                System.out.println(i + " = " + file_start_sec + " " + file_len + " " + file_end_sec);
            }
            if (file_end_sec > lastUsedSector) {
                lastUsedSector = file_end_sec;
            }

        }
        return (lastUsedSector + 1) << 8;
    }

    protected byte[] createBlankDiskImage(String title) {
        this.title = title;
        byte[] image = new byte[SEC_SIZE * NUM_SECS];
        Arrays.fill(image, (byte) 0);
        // Prepare a 13 character title (padded with spaces)
        if (title.length() > 13) {
            title = title.substring(0, 13);
        }
        for (int i = title.length(); i < 13; i++) {
            title += " ";
        }
        for (int i = 0; i < 13; i++) {
            image[i < 8 ? i : i - 8 + 256] = (byte) title.charAt(i);
        }
        // Write the number of sectors
        image[0x106] = (byte) ((NUM_SECS >> 8) & 0xff);
        image[0x107] = (byte) (NUM_SECS & 0xff);
        // Point to the first free sector
        sectorNum = 2;
        return image;
    }

    private void addFile(byte[] image, ATMFile atmFile) {
        int filePtr = image[0x105] & 0xFF;

        filePtr += 8;
        if (filePtr > 255) {
            throw new RuntimeException("Too many files in title: " + atmFile.getTitle());
        }
        image[0x105] = (byte) filePtr;

        // Move all the files down to make room
        for (int i = filePtr + 7; i >= 16; i--) {
            image[i] = image[i - 8];
            image[i + 0x100] = image[i + 0x100 - 8];
        }

        // Always the new file in the first position
        filePtr = 8;

        String filename = atmFile.getTitle();
        if (filename.length() > 7) {
            throw new RuntimeException("Filename too long: " + filename);
        }
        for (int i = filename.length(); i < 7; i++) {
            filename += " ";
        }
        for (int i = 0; i < 7; i++) {
            image[filePtr + i] = (byte) filename.charAt(i);
        }

        // This is the file qualifier (a one character directory)
        // Bit 7 set if the file is locked
        image[filePtr + 7] = 32;

        image[filePtr + 0x100] = (byte) (atmFile.getLoadAddr() & 0xff);
        image[filePtr + 0x101] = (byte) ((atmFile.getLoadAddr() >> 8) & 0xff);
        image[filePtr + 0x102] = (byte) (atmFile.getExecAddr() & 0xff);
        image[filePtr + 0x103] = (byte) ((atmFile.getExecAddr() >> 8) & 0xff);
        image[filePtr + 0x104] = (byte) (atmFile.getLength() & 0xff);
        image[filePtr + 0x105] = (byte) ((atmFile.getLength() >> 8) & 0xff);
        image[filePtr + 0x106] = (byte) (((atmFile.getLength() >> 12) & 0xf0) | ((sectorNum >> 8) & 0x0f));
        image[filePtr + 0x107] = (byte) (sectorNum & 0xff);

        int lengthInSecs = (atmFile.getLength() + 255) / SEC_SIZE;

        if (sectorNum + lengthInSecs >= NUM_SECS) {
            throw new RuntimeException("Disk full - title: " + title + " file: " + atmFile.getTitle());
        }
        System.arraycopy(atmFile.getData(), 0, image, sectorNum * SEC_SIZE, atmFile.getLength());
        sectorNum += lengthInSecs;

    }

    protected void createMenuDisks() throws IOException {
        // Disk 0 is just the menu disk
        byte[] image = createBlankDiskImage("MENU");

        // MENU
        ATMFile menuFile = new ATMFile(new File(archiveDir, "MENU" + getTarget().name()));
        menuFile.setTitle("MENU");
        addFile(image, menuFile);

        // Splash files
        // In AtoMMC these are present in the root directory, but in SDDOS they are needed in the MENU disk (disk 0)
        ATMFile splashFile = new ATMFile(new File(archiveDir, SPLASH_NAME));
        addFile(image, splashFile);

        addDisk(image, getMenuDiskName());

        for (int chapter = 0; chapter < numChapters; chapter++) {
            char chapterLetter = (char) ('A' + chapter);
            byte[] chapterImage = createBlankDiskImage("MENU" + chapterLetter);
            for (int i = 0; i < ATOMMC_MENU_FILES.length; i++) {
                ATMFile atmFile = new ATMFile(new File(new File(archiveDir, menuBase + chapterLetter), ATOMMC_MENU_FILES[i]));
                addFile(chapterImage, atmFile);
            }
            ATMFile chapFile;
            if (chapter == numChapters - 1) {
                chapFile = new ATMFile(new File(archiveDir, "ALL" + getTarget().name()));
            } else {
                chapFile = new ATMFile(new File(archiveDir, "CHAP" + getTarget().name()));
            }
            chapFile.setTitle("CHAP");
            addFile(chapterImage, chapFile);
            addDisk(chapterImage, getChapterDiskName(chapter));
        }
    }

    protected void addTitle(byte[] image, AtomTitle item, String bootName) throws IOException {
        if (debug) {
            System.out.println(item.getTitle());
        }
        File bootfile = new File(new File(archiveDir, menuBase + item.getChapter()),
                                 "" + item.getIdentifier());
        ATMFile bootAtmFile = new ATMFile(bootfile);
        bootAtmFile.setTitle(bootName);
        addFile(image, bootAtmFile);

        Set<String> missing = new HashSet<String>(item.getLoadables());
        for (String filename : item.getFilenames()) {
            if (debug) {
                System.out.println("    >" + filename + "<");
            }
            File file = new File(new File(archiveDir, item.getDir()), filename);
            // Some of the ATM files still contain the original long
            // tape titles
            if (filename.length() > 7) {
                filename = filename.substring(0, 7);
            }
            ATMFile atmFile = new ATMFile(file);
            missing.remove(filename);
            atmFile.setTitle(filename);
            patch_atommc_joystick(atmFile, item);
            addFile(image, atmFile);
            if (item.getRunnables().contains(filename)) {
                if (atmFile.getExecAddr() == (0xc2b2)) {
                    System.out.println("WARNING: " + item.getTitle() + ": " + filename + " load:"
                                       + Integer.toHexString(atmFile.getLoadAddr()) + " exec:"
                                       + Integer.toHexString(atmFile.getExecAddr()));
                }
            }
        }
        if (!missing.isEmpty()) {
            for (String m : missing) {
                System.out.println("WARNING: " + item.getTitle() + ": missing in SDDOS build : " + m);
            }
        }
    }

}
