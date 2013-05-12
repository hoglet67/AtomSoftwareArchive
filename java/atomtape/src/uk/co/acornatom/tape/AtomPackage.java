package uk.co.acornatom.tape;
import java.io.File;
import java.io.IOException;

public class AtomPackage {

	public static final void extractFiles(File dstDir, File srcDir, boolean makeBas, boolean makeAtm, boolean makeWav) throws IOException {
		for (File src : srcDir.listFiles()) {
			if (src.isDirectory()) {
				extractFiles(dstDir, src, makeBas, makeAtm, makeWav);
			} else {

				AtomBase base = null;

				if (src.getName().toLowerCase().endsWith(".40t") || src.getName().toLowerCase().endsWith(".80t") || src.getName().toLowerCase().endsWith(".dsk")) {
					// For DISK files, the name of the dest directory is derived from the name of the TAP file
					String dirName = src.getName();
					dirName = dirName.substring(0, dirName.lastIndexOf('.'));
					File dst = new File(dstDir, dirName);
					base = new AtomDisk(src, dst);
				} else if ((src.getName().toLowerCase().endsWith(".tap") || src.getName().toLowerCase().endsWith(".atm"))) {
					// For TAP files, the name of the dest directory is derived from the name of the TAP file
					String dirName = src.getName();
					dirName = dirName.substring(0, dirName.lastIndexOf('.'));
					File dst = new File(dstDir, dirName);
					base = new AtomTape(src, dst);
				} else if (src.getName().toLowerCase().endsWith(".inf")) {
					// For INF files, the name of the dest directory is derived from directory the INF file is in
					String dirName = src.getParentFile().getName();
					File dst = new File(dstDir, dirName);
					File infFile = src;
					File binFile = new File(src.getCanonicalPath().substring(0, src.getCanonicalPath().length() - 4));
					base = new AtomInf(infFile, binFile, dst);
				} else if (src.getName().toLowerCase().endsWith(".atom1")) {
					// For INF files, the name of the dest directory is derived from directory the INF file is in
					String dirName = src.getParentFile().getName();
					File dst = new File(dstDir, dirName);
					base = new AtomAtom1(src, dst);
				}

				
				if (base != null) {
					System.out.println("####################################################");
					System.out.println("# " + base);
					System.out.println("####################################################");
					try {
						base.processArchive();
						base.generateFiles(makeBas, makeAtm, makeWav);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	public static final void main(String args[]) {

		try {
//			File srcDir = new File("originals");
//			File srcDir = new File("originals/gamebase/AcornAtom/Emulator/AtomMMC");
			File srcDir = new File("originals/dave");

			File dstDir1 = new File("atms");
			extractFiles(dstDir1, srcDir, true, true, false);

//			File dstDir2 = new File("wavs");
//			extractFiles(dstDir2, srcDir, false, false, true);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
