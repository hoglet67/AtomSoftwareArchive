package uk.co.acornatom.menu;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class GenerateEconetFiles extends GenerateBase {

    public static final String DIRSEP = "/";

    public static final String ROOTDIR = "";

    public static final String BASEDIR = "ASA" + DIRSEP;

    public static final String LIBDIR = "ATOMLIB" + DIRSEP;

    private ZipOutputStream zipStream;
    private File archiveDir;
    private String menuBase;
    private int numChunks;

    public GenerateEconetFiles(File archiveDir, File econetZipFile, String menuBase, int numChunks) throws IOException {
        this.archiveDir = archiveDir;
        this.menuBase = menuBase;
        this.numChunks = numChunks;
        this.zipStream = new ZipOutputStream(new FileOutputStream(econetZipFile));
        createMenus();
    }

    public void close() throws IOException {
        zipStream.close();
    }

    private byte[] build_extra_field(ATMFile atmFile) {
        /*
         * For the Acorn specific ZIP header, see
         * http://mdfs.net/Docs/ManPages/Z/1Zip.htm
         */
        byte[] extra = new byte[24];
        extra[0] = 'A';
        extra[1] = 'C';
        extra[2] = 20;
        extra[3] = 0;
        extra[4] = 'A';
        extra[5] = 'R';
        extra[6] = 'C';
        extra[7] = '0';
        extra[8] = (byte) (atmFile.getLoadAddr() & 0xff);
        extra[9] = (byte) ((atmFile.getLoadAddr() >> 8) & 0xff);
        extra[10] = 0;
        extra[11] = 0;
        extra[12] = (byte) (atmFile.getExecAddr() & 0xff);
        extra[13] = (byte) ((atmFile.getExecAddr() >> 8) & 0xff);
        extra[14] = 0;
        extra[15] = 0;
        extra[16] = 3; // Attribute = RW
        extra[17] = 0;
        extra[18] = 0;
        extra[19] = 0;
        extra[20] = 0;
        extra[21] = 0;
        extra[22] = 0;
        extra[23] = 0;
        return extra;
    }

    public void addFile(String dir, ATMFile atmFile) throws IOException {
        String filename = dir + atmFile.getTitle();
        ZipEntry entry = new ZipEntry(filename);
        entry.setExtra(build_extra_field(atmFile));
        zipStream.putNextEntry(entry);
        zipStream.write(atmFile.getData());
        zipStream.closeEntry();
    }

    // Original AtomMMC Names
    public static String[] ATOMMC_MENU_FILES = { "MENUDAT1", "MENUDAT2", "SORTDAT0", "SORTDAT1", "SORTDAT2", "SORTDAT3", "SPLASH" };

    private void createMenus() throws IOException {
        // !BOOT
        ATMFile bootFile = new ATMFile("!BOOT", 0, 0, "*MENU\r".getBytes());
        addFile(BASEDIR, bootFile);
        // MENU
        ATMFile menuFile = new ATMFile(new File(archiveDir, "MENUECO"));
        menuFile.setTitle("MENU");
        addFile(BASEDIR, menuFile);
        // Add a second copy to the lib directory
        addFile(LIBDIR, menuFile);
        // HELP
        ATMFile helpFile = new ATMFile(new File(archiveDir, "HELP"));
        addFile(BASEDIR, helpFile);
        // MNU[A-F]/...
        if (numChunks > 8) {
            throw new RuntimeException("Too many menu chunks");
        }
        for (int chunk = 0; chunk < numChunks; chunk++) {
            char chunkLetter = (char) ('A' + chunk);
            String dir = BASEDIR + "MNU" + chunkLetter + DIRSEP;
            for (int i = 0; i < ATOMMC_MENU_FILES.length; i++) {
                ATMFile atmFile = new ATMFile(new File(new File(archiveDir, menuBase + chunkLetter), ATOMMC_MENU_FILES[i]));
                addFile(dir, atmFile);
            }
            addFile(dir, helpFile);
        }
    }

    // private void addSysFolder() throws IOException {
    // String dir = BASEDIR + "SYS" + DIRSEP;
    // File file = new File(archiveDir, "SYS");
    // for (File child : file.listFiles()) {
    // ATMFile atmFile = new ATMFile(child);
    // addFile(dir, atmFile);
    // }
    // }

    private void addLibFolder() throws IOException {
        ATMFile nomon = new ATMFile("NOMON", 0x03c5, 0x03c5,
                new byte[] {
                        (byte) 0x60                               //        RTS
                        });
        addFile(LIBDIR, nomon);
        ATMFile run = new ATMFile("RUN", 0x2800, 0x2800
                , new byte[] {
                        (byte) 0xa0, (byte) 0x00,                 //        LDY #$00
                        (byte) 0x20, (byte) 0x76, (byte) 0xf8,    //        JSR $F876
                        (byte) 0x88,                              //        DEY
                        (byte) 0xc8,                              // .loop1 INY
                        (byte) 0xb9, (byte) 0x00, (byte) 0x01,    //        LDA $0100,Y
                        (byte) 0xc9, (byte) 0x0d,                 //        CMP #$0D
                        (byte) 0xf0, (byte) 0x1a,                 //        BEQ exit
                        (byte) 0xc9, (byte) 0x20,                 //        CMP #$20
                        (byte) 0xd0, (byte) 0xf4,                 //        BNE loop1
                        (byte) 0x20, (byte) 0x76, (byte) 0xf8,    //        JSR $F876
                        (byte) 0xa2, (byte) 0x00,                 //        LDX #$00
                        (byte) 0xb9, (byte) 0x00, (byte) 0x01,    // .loop2 LDA $0100,Y
                        (byte) 0x9d, (byte) 0x00, (byte) 0x01,    //        STA $0100,Y
                        (byte) 0xc8,                              //        INY
                        (byte) 0xe8,                              //        INX
                        (byte) 0xc9, (byte) 0x0d,                 //        CMP #$0D
                        (byte) 0xd0, (byte) 0xf4,                 //        BNE loop2
                        (byte) 0x4c, (byte) 0xf7, (byte) 0xff,    //        JMP $FFF7
                        (byte) 0x60                               // .exit RTS
                      });
        addFile(LIBDIR, run);
    }

    private String getDir(int index) {
        int i0 = (index >> 8) & 0x0f;
        int i1 = (index >> 4) & 0x0f;
        int i2 = (index >> 0) & 0x0f;
        StringBuilder dir = new StringBuilder();
        dir.append(BASEDIR);
        dir.append(Integer.toHexString(i0).toUpperCase());
        dir.append(DIRSEP);
        dir.append(Integer.toHexString(i1).toUpperCase());
        dir.append(DIRSEP);
        dir.append(Integer.toHexString(i2).toUpperCase());
        dir.append(DIRSEP);
        return dir.toString();
    }

    public void generateFiles(List<SpreadsheetTitle> items) throws IOException {

        // This needs more work to deal with long fine names
        //
        // addSysFolder();

        addLibFolder();

        for (SpreadsheetTitle item : items) {
            try {
                if (item.isPresent()) {
                    System.out.println(item.getTitle());

                    String dir = getDir(item.getIndex());

                    File bootfile = new File(new File(archiveDir, menuBase + item.getChunk().substring(0, 1)),
                            "" + item.getIndex());
                    ATMFile bootAtmFile = new ATMFile(bootfile);
                    bootAtmFile.setTitle("BOOT");
                    addFile(dir, bootAtmFile);

                    Set<String> missing = new HashSet<String>(item.getLoadables());
                    for (String filename : item.getFilenames()) {
                        System.out.println("    >" + filename + "<");
                        File file = new File(new File(archiveDir, item.getDir()), filename);
                        ATMFile atmFile = new ATMFile(file);
                        missing.remove(filename);
                        atmFile.setTitle(filename);
                        addFile(dir, atmFile);
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
                            System.out.println("WARNING: " + item.getTitle() + ": missing : " + m);
                        }
                    }
                }
            } catch (Exception e) {
                System.out.println("Problem Econet files for title " + item.getTitle());
                e.printStackTrace();
            }
        }
    }
}