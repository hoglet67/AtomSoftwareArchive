package uk.co.acornatom.tape;

import java.io.File;
import java.io.IOException;

public class AtomPackage {

	public static final void extractFiles(File dstDir, File src, boolean makeAtm, boolean makeBas, boolean makeWav, boolean makeCsw)
			throws IOException {

		if (src.isDirectory()) {

			for (File child : src.listFiles()) {
				extractFiles(dstDir, child, makeBas, makeAtm, makeWav, makeCsw);
			}

		} else {

			AtomBase base = null;
			String name = src.getName().toLowerCase();
			if (name.endsWith(".40t") || name.endsWith(".80t") || name.endsWith(".dsk") || name.endsWith(".ssd")) {
				// For DISK files, the name of the dest directory is derived
				// from the name of the TAP file
				String dirName = src.getName();
				dirName = dirName.substring(0, dirName.lastIndexOf('.'));
				File dst = new File(dstDir, dirName);
				base = new AtomDisk(src, dst);
			} else if (name.endsWith(".dsd")) {
			    throw new RuntimeException("Double sided (.dsd) files are not supported");
			} else if (name.endsWith(".inf")) {
				// For INF files, the name of the dest directory is derived from
				// directory the INF file is in
				String dirName = src.getParentFile().getName();
				File dst = new File(dstDir, dirName);
				File infFile = src;
				File binFile = new File(src.getCanonicalPath().substring(0, src.getCanonicalPath().length() - 4));
				base = new AtomInf(infFile, binFile, dst);
			} else if (name.endsWith(".atom1")) {
				// For INF files, the name of the dest directory is derived from
				// directory the INF file is in
				String dirName = src.getParentFile().getName();
				File dst = new File(dstDir, dirName);
				base = new AtomAtom1(src, dst);
			} else {
				// For TAP files, the name of the dest directory is derived from
				// the name of the TAP file
				String dirName = src.getName();
				int lastDot = dirName.lastIndexOf('.');
				if (lastDot > 0) {
					dirName = dirName.substring(0, lastDot);
				}
				File dst = new File(dstDir, dirName);
				base = new AtomTape(src, dst);
			}

			if (base != null) {
				System.out.println("####################################################");
				System.out.println("# " + base);
				System.out.println("####################################################");
				try {
					base.processArchive();
					base.generateFiles(makeBas, makeAtm, makeWav, makeCsw);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}
	}

	public static final void usage(String error) {
        System.err.println("usage: java -jar atomtape.jar [-a] [-b] [-w] [-c] <Src Dir or File> <Dst Dir>");
        System.err.println("");
        System.err.println("output options:");
        System.err.println("    -a : Output a .ATM AtoMMC emulator file");
        System.err.println("    -b : Output a .BAS BASIC text file");
        System.err.println("    -w : Output a .WAV audio file");
        System.err.println("    -c : Output a .CSW compressed square wave emulator file");
        System.err.println("");
        System.err.println(error);
        System.exit(1);
	    
	}
	public static final void main(String args[]) {
	    boolean makeAtm = false;
        boolean makeBas = false;
        boolean makeWav = false;
        boolean makeCsw = false;
	    
		try {

		    int numOptions = args.length - 2;
		    
			if (numOptions < 0) {
			    usage("Too few arguments");
			}
			
			for (int i = 0; i < numOptions; i++) {
                if (args[i].equals("-a")) {
                    makeAtm = true;
                } else if (args[i].equals("-b")) {
			        makeBas = true;
			    } else if (args[i].equals("-w")) {
			        makeWav = true;
                } else if (args[i].equals("-c")) {
                    makeCsw = true;
                } else {
                    usage("Unknown option: " + args[i]);
                }
			}
			
			if (!makeAtm && !makeBas && !makeWav && !makeCsw) {
			    usage("At least one output option must be specificed");
			}

			File srcDirOrFile = new File(args[numOptions]);
			if (!srcDirOrFile.exists()) {
				System.err.println("Source directory or file: " + srcDirOrFile + " does not exist");
				System.exit(1);
			}

			File dstDir = new File(args[numOptions + 1]);
			if (!dstDir.exists()) {
				System.err.println("Destination directory: " + dstDir + " does not exist");
				System.exit(1);
			}
			if (!dstDir.isDirectory()) {
				System.err.println("Destination directory: " + dstDir + " is not a directory");
				System.exit(1);
			}

			extractFiles(dstDir, srcDirOrFile, makeAtm, makeBas, makeWav, makeCsw);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
