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
         * 0 extra header id 2 bytes "AC" 2 extra header sublength 2 bytes
         * ------------v 4 Acorn header id 4 bytes "ARC0" 4 8 load address 4
         * bytes 8 12 execution address 4 bytes 12 16 attributes 4 bytes 16 20
         * &00000000 4 bytes 20 24 creation time 2 bytes 22 26 creation date 2
         * bytes 24 28 main account number 2 bytes 26 30 auxilary account number
         * 2 bytes 28
         */
        byte[] extra = new byte[16];
        extra[0] = 'A';
        extra[1] = 'C';
        extra[2] = 12;
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
        String root = "";
        ATMFile menuFile = new ATMFile(new File(archiveDir, "MENUECO"));
        menuFile.setTitle("MENU");
        addFile(root, menuFile);
        ATMFile helpFile = new ATMFile(new File(archiveDir, "HELP"));
        addFile(root, helpFile);
        if (numChunks > 8) {
            throw new RuntimeException("Too many menu chunks");
        }
        for (int chunk = 0; chunk < numChunks; chunk++) {
            char chunkLetter = (char) ('A' + chunk);
            String dir = "MNU" + chunkLetter + "/";
            for (int i = 0; i < ATOMMC_MENU_FILES.length; i++) {
                ATMFile atmFile = new ATMFile(new File(new File(archiveDir, menuBase + chunkLetter), ATOMMC_MENU_FILES[i]));
                addFile(dir, atmFile);
            }
            addFile(dir, helpFile);
        }
    }

    // private void addSysFolder() throws IOException {
    // String dir = "SYS/";
    // File file = new File(archiveDir, "SYS");
    // for (File child : file.listFiles()) {
    // ATMFile atmFile = new ATMFile(child);
    // addFile(dir, atmFile);
    // }
    // }

    private String getDir(int index) {
        int i0 = (index >> 8) & 0x0f;
        int i1 = (index >> 4) & 0x0f;
        int i2 = (index >> 0) & 0x0f;
        StringBuilder dir = new StringBuilder();
        dir.append(Integer.toHexString(i0).toUpperCase());
        dir.append("/");
        dir.append(Integer.toHexString(i1).toUpperCase());
        dir.append("/");
        dir.append(Integer.toHexString(i2).toUpperCase());
        dir.append("/");
        return dir.toString();

    }

    public void generateFiles(List<SpreadsheetTitle> items) throws IOException {

        // This needs more work to deal with long fine names
        //
        // addSysFolder();

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
