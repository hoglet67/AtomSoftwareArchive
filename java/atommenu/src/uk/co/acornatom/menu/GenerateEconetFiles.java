package uk.co.acornatom.menu;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class GenerateEconetFiles extends GenerateBase {

    public static final String DIRSEP = "/";

    public static final String ROOTDIR = "";

    public static final String BASEDIR = "ASA" + DIRSEP;

    public static final String LIBDIR = "LIBRARY" + DIRSEP;

    private ZipOutputStream zipStream;
    private ZipOutputStream nullStream;
    private File archiveDir;
    private String menuBase;
    private int numChunks;

    public GenerateEconetFiles(File archiveDir, File econetZipFile, String menuBase, int numChunks) throws IOException {
        this.archiveDir = archiveDir;
        this.menuBase = menuBase;
        this.numChunks = numChunks;
        this.zipStream = new ZipOutputStream(new FileOutputStream(econetZipFile));
        this.nullStream = new ZipOutputStream(new OutputStream() {
            @Override
            public void write(int b) throws IOException {
            }
        });
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
        extra[16] = 0x33; // Attribute = Public(RW) Owner(RW)
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
        // To improve compatibility with old Archimedes ZIP tools we
        // want to avoid the ZIP file containing streaming data
        // headers PK<07><08> i.e. 0x08074b50. These are included when
        // using DEFLATE compression and the size of the ZipEntry is
        // unknown, because it hasn't yet been compressed.
        //
        // To avoid this, we first write the ZipEntry to a dummy
        // stream which causes it to be compressed and the various
        // sizes in ZipEntry get filled in.
        nullStream.putNextEntry(entry);
        nullStream.write(atmFile.getData());
        nullStream.closeEntry();
        // This is needed as the openjdk-17 ZipEntry includes an
        // additional variable csizeSet, that is only set when
        // setCompressedSize() is called. ZipOutputStream now checks
        // this flag as well, and if it's still false it will use the
        // streaming data header pattern.
        //
        // What's really a bug is that ZipOutputStream sets csize
        // directly, rather than calling setCompressedSize(), which
        // results in the csizeSet flag being inconsistent.
        //
        // So we need to explicitely now call setCompressedSize() for
        // our previous workaround to work with openjdk-17.
        //
        // This is a horrible hack to make a horrible class do what we
        // want!
        entry.setCompressedSize(entry.getCompressedSize());
        zipStream.putNextEntry(entry);
        zipStream.write(atmFile.getData());
        zipStream.closeEntry();
    }

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

        // Splash files
        ATMFile splashFile1 = new ATMFile(new File(archiveDir, "SPLASH1"));
        addFile(BASEDIR, splashFile1);
        ATMFile splashFile2 = new ATMFile(new File(archiveDir, "SPLASH2"));
        addFile(BASEDIR, splashFile2);

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
        HashMap<Integer, Integer> patch = new HashMap<>();
        //
        // There are address changes from v2.40 to v3.50 or the ROM
        //
        patch.put(0xA793, 0xA788);
        patch.put(0xA7A4, 0xA799);
        patch.put(0xA7D8, 0xA7C3);
        patch.put(0xA7F7, 0xA658);
        patch.put(0xA80F, 0xA670);
        patch.put(0xA82F, 0xA690);
        patch.put(0xA85B, 0xA6BC);
        patch.put(0xA883, 0xA7F7);
        patch.put(0xA899, 0xA80D);
        patch.put(0xA8A4, 0xA818);
        patch.put(0xA8A6, 0xA81A);
        patch.put(0xA8C8, 0xA83C);
        patch.put(0xA8D4, 0xA848);
        patch.put(0xA8E9, 0xA85D);
        patch.put(0xA8ED, 0xA861);
        patch.put(0xA8FF, 0xA6F1);
        patch.put(0xA90C, 0xA873);
        patch.put(0xAD6C, 0xAD2A);
        patch.put(0xAD80, 0xAD3E);
        File file = new File(archiveDir, "../../atomlib");
        for (File child : file.listFiles()) {
            ATMFile atmFile = new ATMFile(child);
            atmFile.setTitle(child.getName());
            byte[] data = atmFile.getData();
            for (int i = 0; i < data.length - 3; i++) {
                if (data[i] == 0x20 || data[i] == 0x4c) {
                    Integer oldAddr = (data[i + 1] & 0xff) + ((data[i + 2] & 0xff) << 8);
                    Integer newAddr = patch.get(oldAddr);
                    if (oldAddr >= 0xa000 && oldAddr <= 0xafff) {
                        System.out.print("Patching: " + atmFile.getTitle() + " " + Integer.toHexString(oldAddr) + " => ");
                        if (newAddr != null) {
                            data[i + 1] = (byte) (newAddr & 0xff);
                            data[i + 2] = (byte) ((newAddr >> 8) & 0xff);
                            System.out.println(Integer.toHexString(newAddr));
                        } else {
                            System.out.println("FAILED");
                        }
                    }
                }
            }
            addFile(LIBDIR, atmFile);
        }
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

   private void patch_nomon(ATMFile atmFile, SpreadsheetTitle item) {
        byte[] bytes = atmFile.getData();
        String[] matches= {"N.\r", "NO.\r", "NOM.\r", "NOMO.\r", "NOMON\t"};
        for (String match : matches) {
           byte[] ref = match.getBytes();
           for (int i = 0; i < bytes.length - ref.length - 2; i++) {
              if (bytes[i] != 13 && bytes[i + 2] == '*' && bytes[i + 3] == 'N') {
                 for (int j = 0; j < ref.length && bytes[i + 3 + j] == ref[j]; j++) {
                    if (ref[j] == 13) {
                       System.out.println("Patching *" + match.substring(0, match.length() - 1) + " in " + item.getPublisher() + " " + item.getTitle() + " file " + atmFile.getTitle());
                       bytes[i + 2] = 'R';
                       bytes[i + 3] = 'E';
                       bytes[i + 4] = 'M';
                    }
                 }
              }
           }
        }
    }

    private void patch_interupt_vector(ATMFile atmFile) {
        byte[] bytes = atmFile.getData();
        for (int i = 0; i < bytes.length - 3; i++) {
            int addrhi = (bytes[i + 2] & 0xff);
            if (addrhi == 0x02) {
                int addrlo = (bytes[i + 1] & 0xff);
                if (addrlo == 0x04 || addrlo == 0x05) {
                    int opcode = bytes[i] & 0xff;
                    if (opcode == 0x8D || opcode == 0x8E || opcode == 0x8C ||    // LDA/X/Y absolute
                        opcode == 0xAD || opcode == 0xAE || opcode == 0xAC) {    // STA/X/Y absolute
                        System.out.println(String.format("Patching %s %04x %04x at %04X : %02X %02X %02X",
                                        atmFile.getTitle(),
                                        atmFile.getLoadAddr(),
                                        i,
                                        atmFile.getLoadAddr() + i,
                                        opcode,
                                        addrlo,
                                        addrhi));
                        bytes[i + 1] += (0x21c - 0x204);
                    }
                }
            }
        }
    }

    public void generateFiles(List<SpreadsheetTitle> items, Target target) throws IOException {

        // This needs more work to deal with long fine names
        //
        // addSysFolder();

        addLibFolder();

        for (SpreadsheetTitle item : items) {
            try {
                if (item.isPresent()) {
                    System.out.println(item.getTitle());

                    String dir = getDir(item.getIdentifier());

                    File bootfile = new File(new File(archiveDir, menuBase + item.getChunk().substring(0, 1)),
                            "" + item.getIdentifier());
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
                        patch_interupt_vector(atmFile);
                        patch_nomon(atmFile, item);
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
                            System.out.println("WARNING: " + item.getTitle() + ": missing in Econet build : " + m);
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
