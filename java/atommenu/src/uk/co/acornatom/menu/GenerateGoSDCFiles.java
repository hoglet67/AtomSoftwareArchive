package uk.co.acornatom.menu;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Formatter;

public class GenerateGoSDCFiles extends GenerateBase {

    public static final String DIRSEP = "/";

    public static final String BASEDIR = "ASA" + DIRSEP;

    private File archiveDir;
    private String menuBase;
    private int numChunks;
    private File gosdcFilesDir;
    private FileOutputStream scriptStream;
    private int scriptCounter;

    public GenerateGoSDCFiles(File archiveDir, String menuBase, int numChunks, File gosdcFilesDir) throws IOException {
        this.archiveDir = archiveDir;
        this.menuBase = menuBase;
        this.numChunks = numChunks;
	this.gosdcFilesDir = gosdcFilesDir;
	gosdcFilesDir.mkdir();
	scriptStream = new FileOutputStream(new File(gosdcFilesDir, "script"));
	scriptCounter = 0;
        createMenus();
    }

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

    public void generateFiles(List<SpreadsheetTitle> items, Target target) throws IOException {

        for (SpreadsheetTitle item : items) {
            try {
                if (item.isPresent()) {
                    System.out.println(item.getTitle());

		    String comment = "# " + item.getTitle() + " | " + item.getPublisher() + "\n";
		    scriptStream.write(comment.getBytes());

		    StringBuilder dirname = new StringBuilder();
		    Formatter formatter = new Formatter(dirname);
		    formatter.format("%sE%03X%s", BASEDIR, item.getIdentifier(), DIRSEP);
		    String dir = dirname.toString();

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
                }
            } catch (Exception e) {
                System.out.println("Problem GoSDC files for title " + item.getTitle());
                e.printStackTrace();
            }
        }
    }
}
