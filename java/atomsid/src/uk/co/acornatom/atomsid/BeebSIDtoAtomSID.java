package uk.co.acornatom.atomsid;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

public class BeebSIDtoAtomSID {

	private static final int MENU_ADDR = 0x8200;

	private static final String SID_MENU_NAME = "SIDMENU";

	private enum Mode {
		FROM_ORIGINAL, FROM_ATOMSID, FROM_BEEBSID
	}

	public BeebSIDtoAtomSID() {
	}

	protected void writeATMFile(OutputStream out, String title, int loadAddr, int execAddr, byte[] data) throws IOException {
		writeString(out, title);
		for (int i = 0; i < 16 - title.length(); i++) {
			out.write(0);
		}
		writeShort(out, loadAddr);
		writeShort(out, execAddr);
		writeShort(out, data.length);
		out.write(data);
	}

	private void writeString(OutputStream out, String value) throws IOException {
		out.write(value.getBytes());
	}

	private void writeShort(OutputStream out, int value) throws IOException {
		byte[] buffer = new byte[2];
		buffer[0] = (byte) (value & 0xff);
		buffer[1] = (byte) ((value >> 8) & 0xff);
		out.write(buffer);
	}

	private void writeByte(OutputStream out, int value) throws IOException {
		byte[] buffer = new byte[1];
		buffer[0] = (byte) (value & 0xff);
		out.write(buffer);
	}

	private byte[] readFile(File file) throws IOException {
		ByteArrayOutputStream ous = null;
		InputStream ios = null;
		try {
			byte[] buffer = new byte[4096];
			ous = new ByteArrayOutputStream();
			ios = new FileInputStream(file);
			int read = 0;
			while ((read = ios.read(buffer)) != -1) {
				ous.write(buffer, 0, read);
			}
		} finally {
			try {
				if (ous != null)
					ous.close();
			} catch (IOException e) {
			}

			try {
				if (ios != null)
					ios.close();
			} catch (IOException e) {
			}
		}
		return ous.toByteArray();
	}

	private void relocate(File srcFile, File dstFile, Mode mode, int sidBase, int loadAddr, int execAddr) throws IOException {

		byte[] orig = readFile(srcFile);
		byte[] sid = null;

		int oldSidBase;

		System.out.println("File " + srcFile + " was " + orig.length + " bytes");

		if (mode == Mode.FROM_ORIGINAL) {

			// Check it is a PSID file
			if (orig[0] != 'P' || orig[1] != 'S' || orig[2] != 'I' || orig[3] != 'D') {
				throw new RuntimeException(srcFile + " is not a valid PSID file; bad magic number");
			}
			if (orig[4] != 0) {
				throw new RuntimeException(srcFile + " is not a valid PSID file; bad MS version");
			}
			if (orig[5] != 1 && orig[5] != 2) {
				throw new RuntimeException(srcFile + " is not a valid PSID file; bad LS version");
			}
			int offset = orig[6] * 256 + orig[7] + 2;
			System.out.println("SID Offset = " + Integer.toHexString(offset));

			int load = (orig[8] & 0xff) * 256 + (orig[9] & 0xff);
			int init = (orig[10] & 0xff) * 256 + (orig[11] & 0xff);
			int play = (orig[12] & 0xff) * 256 + (orig[13] & 0xff);

			System.out.println("Load = " + Integer.toHexString(load));
			System.out.println("Init = " + Integer.toHexString(init));
			System.out.println("Play = " + Integer.toHexString(play));

			// Remove the SID Header
			sid = new byte[orig.length - offset];
			System.arraycopy(orig, offset, sid, 0, sid.length);

			oldSidBase = 0xd400;

		} else if (mode == Mode.FROM_ATOMSID) {

			sid = orig;

			oldSidBase = 0xbdc0;

			// TODO Read Inf File

		} else if (mode == Mode.FROM_BEEBSID) {

			sid = orig;

			oldSidBase = 0xfc20;

		} else {
			throw new RuntimeException("Unimplemented mode: " + mode);
		}

		System.out.println("Old SID base = " + Integer.toHexString(oldSidBase));
		System.out.println("New SID base = " + Integer.toHexString(sidBase));

		int oldSidBaseLo = oldSidBase & 0xff;
		int oldSidBaseHi = (oldSidBase >> 8) & 0xff;

		// Relocate
		for (int i = 0; i < sid.length - 2; i++) {
			if ((sid[i] == (byte) 0x8c) || // STY Absolute
					(sid[i] == (byte) 0x8d) || // STA Absolute
					(sid[i] == (byte) 0x8e) || // STX Absolute
					(sid[i] == (byte) 0x99) || // STA Absolute,Y
					(sid[i] == (byte) 0x9d)) // STA Absolute,X
			{
				if (sid[i + 1] >= (byte) (oldSidBaseLo) && sid[i + 1] < (byte) (oldSidBaseLo + 0x20)
						&& sid[i + 2] == (byte) oldSidBaseHi) {
					System.out.println("Relocating " + i + " " + Integer.toHexString(sid[i] & 0xff) + " "
							+ Integer.toHexString(sid[i + 1] & 0xff) + " " + Integer.toHexString(sid[i + 2] & 0xff));
					sid[i + 1] = (byte) (((int) sid[i + 1]) + ((sidBase - oldSidBase) & 0xff));
					sid[i + 2] = (byte) (((int) sid[i + 2]) + ((sidBase - oldSidBase) >> 8) & 0xff);
					System.out.println("    to     " + i + " " + Integer.toHexString(sid[i] & 0xff) + " "
							+ Integer.toHexString(sid[i + 1] & 0xff) + " " + Integer.toHexString(sid[i + 2] & 0xff));
				}
			}
		}

		if (mode == Mode.FROM_ATOMSID) {
			FileOutputStream fos = new FileOutputStream(dstFile);
			fos.write(sid, 0, sid.length);
			fos.close();
		} else {
			FileOutputStream fos = new FileOutputStream(dstFile);
			writeATMFile(fos, dstFile.getName(), loadAddr, execAddr, sid);
			fos.close();
		}
	}

	public void beebSIDtoAtomSID(File beebSIDMenuFile, File atomSIDMenuFile, File atomSidDir) throws IOException {

		System.out.println("### " + atomSidDir.getName());

		byte[] beebSIDMenu = readFile(beebSIDMenuFile);
		byte[] atomSIDMenuBase = readFile(atomSIDMenuFile);

		File beebSidDir = beebSIDMenuFile.getParentFile();

		List<Integer> songs = new ArrayList<Integer>();
		byte[] search = "LOAD ".getBytes();

		for (int i = 0; i < beebSIDMenu.length - search.length; i++) {
			for (int j = 0; j < search.length; j++) {
				if (beebSIDMenu[i + j] == search[j]) {
					if (j == search.length - 1) {
						songs.add(i - 11);
					}
				} else {
					break;
				}
			}
		}
		songs.add(beebSIDMenu.length);

		System.out.println("Found " + (songs.size() - 1) + " songs");

		// Start building the AtomSIDMenu
		byte[] atomSIDMenu = new byte[16384]; // Larger than it should ever be
		// Copy the generic part of the menu
		System.arraycopy(atomSIDMenuBase, 0, atomSIDMenu, 0, atomSIDMenuBase.length);

		int data = atomSIDMenuBase.length;

		int line = data + 2 * songs.size();

		boolean earlySid = false;

		for (int i = 0; i < songs.size(); i++) {

			if (i == songs.size() - 1) {

				// Write the line pointer
				atomSIDMenu[data + 2 * i] = (byte) 0;
				atomSIDMenu[data + 2 * i + 1] = (byte) 0;

			} else {

				// Write the line pointer
				atomSIDMenu[data + 2 * i] = (byte) ((MENU_ADDR + line) & 0xff);
				atomSIDMenu[data + 2 * i + 1] = (byte) (((MENU_ADDR + line) >> 8) & 0xff);

				int offset = songs.get(i);

				int initAddr = (beebSIDMenu[offset + 0] & 0xff) + ((beebSIDMenu[offset + 1] & 0xff) << 8);
				int playAddr = (beebSIDMenu[offset + 2] & 0xff) + ((beebSIDMenu[offset + 3] & 0xff) << 8);
				int loadAddr = (beebSIDMenu[offset + 9] & 0xff) + ((beebSIDMenu[offset + 10] & 0xff) << 8);

				int j = offset + 16;
				String fileName = "";
				while (beebSIDMenu[j] != (byte) ' ' && beebSIDMenu[j] != (byte) 13) {
					fileName += (char) beebSIDMenu[j];
					j++;
				}
				while (beebSIDMenu[j] != (byte) 0) {
					j++;
				}
				j++;

				String title;
				if (earlySid || (j >= songs.get(i + 1))) {
					title = fileName;
					earlySid = true;
				} else {
					title = "";
					while (beebSIDMenu[j] != (byte) 0 && beebSIDMenu[j] != (byte) 13) {
						title += (char) beebSIDMenu[j];
						j++;
					}
				}

				// Mangle title to the format AtomSIDMenu needs
				title = "" + (char) ('A' + i) + ". " + title;
				while (title.length() < 30) {
					title += " ";
				}
				if (title.length() > 30) {
					title = title.substring(0, 30);
				}
				title = title.toUpperCase();

				System.out.println("### " + title + " " + Integer.toHexString(loadAddr) + " " + Integer.toHexString(initAddr) + " "
						+ Integer.toHexString(playAddr) + " " + fileName);

				// Write the title, padded to 30 char
				byte[] titleBytes = title.getBytes();
				System.arraycopy(titleBytes, 0, atomSIDMenu, line, titleBytes.length);
				line += titleBytes.length;
				// Write a null terminator for the title
				atomSIDMenu[line++] = 0;

				// Write the load, init, play
				atomSIDMenu[line++] = (byte) (loadAddr & 0xff);
				atomSIDMenu[line++] = (byte) ((loadAddr >> 8) & 0xff);
				atomSIDMenu[line++] = (byte) (initAddr & 0xff);
				atomSIDMenu[line++] = (byte) ((initAddr >> 8) & 0xff);
				atomSIDMenu[line++] = (byte) (playAddr & 0xff);
				atomSIDMenu[line++] = (byte) ((playAddr >> 8) & 0xff);

				// Write the LOAD FILE, terminated with 0D
				byte[] fileNameBytes = ("LOAD " + fileName + "\r").getBytes();
				System.arraycopy(fileNameBytes, 0, atomSIDMenu, line, fileNameBytes.length);
				line += fileNameBytes.length;

				// Read the Beeb SID File
				File srcSidFile = new File(beebSidDir, fileName);
				File dstSidFile = new File(atomSidDir, fileName);
				relocate(srcSidFile, dstSidFile, Mode.FROM_BEEBSID, 0xbdc0, loadAddr, initAddr);
			}
		}

		byte[] atomSIDMenuFinal = new byte[line];
		System.arraycopy(atomSIDMenu, 0, atomSIDMenuFinal, 0, atomSIDMenuFinal.length);

		String menu = atomSidDir + File.separator + SID_MENU_NAME;
		System.out.println("### writing menu " + menu);
		FileOutputStream out = new FileOutputStream(menu);
		writeATMFile(out, SID_MENU_NAME, MENU_ADDR, MENU_ADDR, atomSIDMenuFinal);
		out.close();

	}

	public static final void main(String[] args) {
		try {
			if (args.length != 3) {
				System.err.println("usage: java -jar atomsid.jar <BeebSIDMenu> <AtomSIDMenuBase> <Output Dir>");
				System.exit(1);
			}
			File beebSIDMenuFile = new File(args[0]);
			if (!beebSIDMenuFile.exists()) {
				System.err.println("File: " + beebSIDMenuFile + " does not exist");
				System.exit(1);
			}
			if (!beebSIDMenuFile.isFile()) {
				System.err.println("File: " + beebSIDMenuFile + " is not a file");
				System.exit(1);
			}

			File atomSIDMenuFile = new File(args[1]);
			if (!atomSIDMenuFile.exists()) {
				System.err.println("File: " + atomSIDMenuFile + " does not exist");
				System.exit(1);
			}
			if (!beebSIDMenuFile.isFile()) {
				System.err.println("File: " + atomSIDMenuFile + " is not a file");
				System.exit(1);
			}

			File dir = new File(args[2]);
			dir.mkdirs();

			BeebSIDtoAtomSID c = new BeebSIDtoAtomSID();
			c.beebSIDtoAtomSID(beebSIDMenuFile, atomSIDMenuFile, dir);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
