package uk.co.acornatom.tape;

import java.io.File;
import java.io.IOException;

public class AtomPackage {

	public static final void extractFiles(File dstDir, File src, boolean makeBas, boolean makeAtm, boolean makeWav, boolean makeCsw)
			throws IOException {

		if (src.isDirectory()) {

			for (File child : src.listFiles()) {
				extractFiles(dstDir, child, makeBas, makeAtm, makeWav, makeCsw);
			}

		} else {

			AtomBase base = null;
			String name = src.getName().toLowerCase();
			if (name.endsWith(".40t") || name.endsWith(".80t") || name.endsWith(".dsk") || name.endsWith(".ssd") || name.endsWith(".dsd")) {
				// For DISK files, the name of the dest directory is derived
				// from the name of the TAP file
				String dirName = src.getName();
				dirName = dirName.substring(0, dirName.lastIndexOf('.'));
				File dst = new File(dstDir, dirName);
				base = new AtomDisk(src, dst);
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

	public static final void main(String args[]) {

		try {

			if (args.length != 2) {
				System.err.println("usage: java -jar atomtape.jar <Src Dir or File> <Dst Dir>");
				System.exit(1);
			}

			File srcDirOrFile = new File(args[0]);
			if (!srcDirOrFile.exists()) {
				System.err.println("Source directory or file: " + srcDirOrFile + " does not exist");
				System.exit(1);
			}

			File dstDir = new File(args[1]);
			if (!dstDir.exists()) {
				System.err.println("Destination directory: " + dstDir + " does not exist");
				System.exit(1);
			}
			if (!dstDir.isDirectory()) {
				System.err.println("Destination directory: " + dstDir + " is not a directory");
				System.exit(1);
			}

			// booleans are: makeBas, makeAtm, makeWav
			extractFiles(dstDir, srcDirOrFile, false, true, false, false);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
