package uk.co.acornatom.menu;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Formatter;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class GenerateGoSDCFiles extends ArchiveGeneratorBase {

    public static final String DIRSEP = "/";

    public static final String BASEDIR = "ASA" + DIRSEP;

    private File archiveDir;
    private String menuBase;
    private int numChapters;
    private File gosdcFilesDir;
    private FileOutputStream scriptStream;
    private int scriptCounter;

    public GenerateGoSDCFiles(File archiveDir, String menuBase, int numChapters, File gosdcFilesDir) throws IOException {
        this.archiveDir = archiveDir;
        this.menuBase = menuBase;
        this.numChapters = numChapters;
        this.gosdcFilesDir = gosdcFilesDir;
        gosdcFilesDir.mkdir();
        scriptStream = new FileOutputStream(new File(gosdcFilesDir, "script"));
        scriptCounter = 0;
    }

    @Override
    public void filterTitles(List<AtomTitle> items) throws IOException {
        filterOZMOOTitles(items);
    }

    @Override
    public void close() throws IOException {
        scriptStream.close();
    }

    public void addFile(String dir, ATMFile atmFile) throws IOException {
        String objectName = dir + atmFile.getTitle();
        objectName = objectName.replace('/', '.');

        String madeupName = "0000000" + Integer.toString(scriptCounter++);
        madeupName = madeupName.substring(madeupName.length() - 8);

        StringBuilder scriptLine = new StringBuilder();
        Formatter formatter = new Formatter(scriptLine);
        formatter.format("ADD FILE %s %04x %04x %s\n", objectName, atmFile.getLoadAddr(), atmFile.getExecAddr(), madeupName);
        formatter.close();
        scriptStream.write(scriptLine.toString().getBytes());

        FileOutputStream file = new FileOutputStream(new File(gosdcFilesDir, madeupName));
        file.write(atmFile.getData());
        file.close();
    }

    private void createMenus() throws IOException {
        scriptStream.write("# Atom Software Archive menu\n".getBytes());

        // !BOOT
        ATMFile bootFile = new ATMFile("!BOOT", 0, 0, "*RUN MENU\r".getBytes());
        addFile(BASEDIR, bootFile);

        // MENU
        ATMFile menuFile = new ATMFile(new File(archiveDir, "MENUGOS"));
        menuFile.setTitle("MENU");
        addFile(BASEDIR, menuFile);

        // Splash files
        ATMFile splashFile = new ATMFile(new File(archiveDir, SPLASH_NAME));
        addFile(BASEDIR, splashFile);

        // MNU[A-F]/...
        if (numChapters > 8) {
            throw new RuntimeException("Too many menu Chapters");
        }
        for (int chapter = 0; chapter < numChapters; chapter++) {
            char chapterLetter = (char) ('A' + chapter);
            String dir = BASEDIR + "MNU" + chapterLetter + DIRSEP;
            for (int i = 0; i < ATOMMC_MENU_FILES.length; i++) {
                ATMFile atmFile = new ATMFile(new File(new File(archiveDir, menuBase + chapterLetter), ATOMMC_MENU_FILES[i]));
                addFile(dir, atmFile);
            }
            ATMFile chapFile;
            if (chapter == numChapters - 1) {
                chapFile = new ATMFile(new File(archiveDir, "ALLGOS"));
            } else {
                chapFile = new ATMFile(new File(archiveDir, "CHAPGOS"));
            }
            chapFile.setTitle("CHAP");
            addFile(dir, chapFile);
        }
    }

    @Override
    public void generateFiles(List<AtomTitle> items) throws IOException {

        createMenus();
        for (AtomTitle item : items) {
            try {
                if (debug) {
                    System.out.println(item.getTitle());
                }

                String comment = "# " + item.getTitle() + " | " + item.getPublisher() + "\n";
                scriptStream.write(comment.getBytes());

                StringBuilder dirname = new StringBuilder();
                Formatter formatter = new Formatter(dirname);
                formatter.format("%sE%03X%s", BASEDIR, item.getIdentifier(), DIRSEP);
                formatter.close();
                String dir = dirname.toString();

                File bootfile = new File(new File(archiveDir, menuBase + item.getChapter()),
                        "" + item.getIdentifier());
                ATMFile bootAtmFile = new ATMFile(bootfile);
                bootAtmFile.setTitle("BOOT");
                addFile(dir, bootAtmFile);

                Set<String> missing = new HashSet<String>(item.getLoadables());
                for (String filename : item.getFilenames()) {
                    if (debug) {
                        System.out.println("    >" + filename + "<");
                    }
                    File file = new File(new File(archiveDir, item.getDir()), filename);
                    ATMFile atmFile = new ATMFile(file);
                    missing.remove(filename);
                    patch_atommc_joystick(atmFile, item);
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
                        System.out.println("WARNING: " + item.getTitle() + ": missing in GoSDC build : " + m);
                    }
                }
            } catch (Exception e) {
                System.out.println("Problem GoSDC files for title " + item.getTitle());
                e.printStackTrace();
            }
        }
    }

    @Override
    public Target getTarget() {
        return Target.GOSDC;
    }
}
