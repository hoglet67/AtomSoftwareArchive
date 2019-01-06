package uk.co.acornatom.atomsid;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintStream;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class BeebSIDtoAtomSID {

	private static final byte[] vu = {
		(byte) 0x8c, (byte) 0xc4, (byte) 0xbd, (byte) 0x8c, (byte) 0x00, (byte) 0x97, (byte) 0x60, (byte) 0x8c,
		(byte) 0xcb, (byte) 0xbd, (byte) 0x8c, (byte) 0x07, (byte) 0x97, (byte) 0x60, (byte) 0x8c, (byte) 0xd2,
		(byte) 0xbd, (byte) 0x8c, (byte) 0x0e, (byte) 0x97, (byte) 0x60, (byte) 0x8d, (byte) 0xc4, (byte) 0xbd,
		(byte) 0x8d, (byte) 0x00, (byte) 0x97, (byte) 0x60, (byte) 0x8d, (byte) 0xcb, (byte) 0xbd, (byte) 0x8d,
		(byte) 0x07, (byte) 0x97, (byte) 0x60, (byte) 0x8d, (byte) 0xd2, (byte) 0xbd, (byte) 0x8d, (byte) 0x0e,
		(byte) 0x97, (byte) 0x60, (byte) 0x8e, (byte) 0xc4, (byte) 0xbd, (byte) 0x8e, (byte) 0x00, (byte) 0x97,
		(byte) 0x60, (byte) 0x8e, (byte) 0xcb, (byte) 0xbd, (byte) 0x8e, (byte) 0x07, (byte) 0x97, (byte) 0x60,
		(byte) 0x8e, (byte) 0xd2, (byte) 0xbd, (byte) 0x8e, (byte) 0x0e, (byte) 0x97, (byte) 0x60, (byte) 0x99,
		(byte) 0xc4, (byte) 0xbd, (byte) 0x99, (byte) 0x00, (byte) 0x97, (byte) 0x60, (byte) 0x9d, (byte) 0xc4,
		(byte) 0xbd, (byte) 0x9d, (byte) 0x00, (byte) 0x97, (byte) 0x60
	};

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
		if (!file.exists()) {
			throw new IOException("Could not read " + file);
		}
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

	private int relocate(File srcFile, File dstFile, Mode mode, int sidBase, int loadAddr, int initAddr, int playAddr, int relocateAddr) throws IOException {

		int ret = 0;

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

		} else if (mode == Mode.FROM_BEEBSID) {

			sid = orig;

			oldSidBase = 0xfc20;

		} else {
			throw new RuntimeException("Unimplemented mode: " + mode);
		}

		if (relocateAddr != 0) {
			// Write out a valid SID file, with header
			File oldSidFile = File.createTempFile("old", "sid");
			File newSidFile = File.createTempFile("new", "sid");
			byte[] sidHeader = makeSidHeader(loadAddr, initAddr, playAddr, 1, 1);
			FileOutputStream fos = new FileOutputStream(oldSidFile);
			fos.write(sidHeader, 0, sidHeader.length);
			fos.write(sid, 0, sid.length);
			fos.close();

			String command = "./sidreloc -t 10 --no-zp-reloc --sid-source-address fc20 --sid-dest-addr fc20 -p " + Integer.toHexString(relocateAddr >> 8) + " " +
				oldSidFile.getAbsolutePath() + " " +
				newSidFile.getAbsolutePath();
			System.out.println(command);
			Process p = Runtime.getRuntime().exec(command);
			ret = -1;
			try {
				ret = p.waitFor();
			} catch (InterruptedException e) {
			}

			System.out.println("Return code = " + ret);

			// Mask out the warning bits...
			ret = ret & 31;

            String line;

            BufferedReader error = new BufferedReader(new InputStreamReader(p.getErrorStream()));
            while((line = error.readLine()) != null){
                System.out.println(line);
            }
            error.close();

            BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));
            while((line=input.readLine()) != null){
                System.out.println(line);
            }

            input.close();

            OutputStream outputStream = p.getOutputStream();
            PrintStream printStream = new PrintStream(outputStream);
            printStream.println();
            printStream.flush();
            printStream.close();;

            if (ret == 0) {
				// Read the new SID File
				byte[] newSid = readFile(newSidFile);

				System.out.println(newSid.length);

				// Copy back, removing the header
				System.arraycopy(newSid, 0x76, sid, 0, sid.length);

				initAddr += (relocateAddr - loadAddr);
				playAddr += (relocateAddr - loadAddr);
				loadAddr = relocateAddr;
            }
		}




		System.out.println("Old SID base = " + Integer.toHexString(oldSidBase));
		System.out.println("New SID base = " + Integer.toHexString(sidBase));

		int oldSidBaseLo = oldSidBase & 0xff;
		int oldSidBaseHi = (oldSidBase >> 8) & 0xff;

		// Move SID Registers
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

		int addr = loadAddr + sid.length;

		// Append the vu code
		byte[] sidVu = new byte[sid.length + vu.length];
		System.arraycopy(sid, 0, sidVu, 0, sid.length);
		System.arraycopy(vu, 0, sidVu, sid.length, vu.length);
		sid = sidVu;

		// Patch in VU Meter
		checkAndReplace(sid, 0x8c, sidBase + 0x04, addr + 0x00);
		checkAndReplace(sid, 0x8c, sidBase + 0x0b, addr + 0x07);
		checkAndReplace(sid, 0x8c, sidBase + 0x12, addr + 0x0e);
		checkAndReplace(sid, 0x8d, sidBase + 0x04, addr + 0x15);
		checkAndReplace(sid, 0x8d, sidBase + 0x0b, addr + 0x1c);
		checkAndReplace(sid, 0x8d, sidBase + 0x12, addr + 0x23);
		checkAndReplace(sid, 0x8e, sidBase + 0x04, addr + 0x2a);
		checkAndReplace(sid, 0x8e, sidBase + 0x0b, addr + 0x31);
		checkAndReplace(sid, 0x8e, sidBase + 0x12, addr + 0x38);
		checkAndReplace(sid, 0x99, sidBase + 0x04, addr + 0x3f);
		checkAndReplace(sid, 0x9d, sidBase + 0x04, addr + 0x46);


		if (mode == Mode.FROM_ATOMSID) {
			FileOutputStream fos = new FileOutputStream(dstFile);
			fos.write(sid, 0, sid.length);
			fos.close();
		} else {
			FileOutputStream fos = new FileOutputStream(dstFile);
			writeATMFile(fos, dstFile.getName(), loadAddr, initAddr, sid);
			fos.close();
		}


		return ret;
	}

	private void checkAndReplace(byte[] sid, int opcode, int regAddr, int subAddr) {
		for (int i = 0; i < sid.length - 2 - vu.length; i++) {
		    if (sid[i] == (byte) opcode && sid[i + 1] == (byte) (regAddr & 0xff) && sid[i + 2] == (byte)((regAddr >> 8) & 0xff)) {
				sid[i] = (byte) 0x20;
				sid[i + 1] = (byte) (subAddr & 0xff);
				sid[i + 2] = (byte) ((subAddr >> 8) & 0xff);
			}
		}
	}

	private byte[] makeSidHeader(int loadAddr, int initAddr, int playAddr, int numSongs, int startSong) {

		byte[] sidHeader = new byte[0x76];
		for (int i = 0; i < sidHeader.length; i++) {
			sidHeader[i] = 0;
		}
		// Magic Number
		sidHeader[0] = 'P';
		sidHeader[1] = 'S';
		sidHeader[2] = 'I';
		sidHeader[3] = 'D';
		// Version
		sidHeader[5] = 1;
		// Data Offset
		sidHeader[7] = 0x76;
		// Load Addr
		sidHeader[8] = (byte) ((loadAddr >> 8) & 0xff);
		sidHeader[9] = (byte) (loadAddr & 0xff);
		// Init Addr
		sidHeader[10] = (byte) ((initAddr >> 8) & 0xff);
		sidHeader[11] = (byte) (initAddr & 0xff);
		// Play Addr
		sidHeader[12] = (byte) ((playAddr >> 8) & 0xff);
		sidHeader[13] = (byte) (playAddr & 0xff);
		// Number of Songs
		sidHeader[14] = (byte) ((numSongs >> 8) & 0xff);
		sidHeader[15] = (byte) (numSongs & 0xff);
		// Number of Songs
		sidHeader[16] = (byte) ((startSong >> 8) & 0xff);
		sidHeader[17] = (byte) (startSong & 0xff);
		return sidHeader;
	}

	public void beebSIDtoAtomSID(File beebSIDMenuFile, File atomSIDMenuFile, File blacklistFile, File atomSidDir, int relocateAddrBase) throws IOException {

		// Parse the blacklist file
		Set<String> blackList = new HashSet<String>();
		InputStream fis = new FileInputStream(blacklistFile);
		BufferedReader br = new BufferedReader(new InputStreamReader(fis, Charset.forName("UTF-8")));
		String item;
		while ((item = br.readLine()) != null) {
			blackList.add(item.trim());
		}
		br.close();


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

				// Read the init, play and load addresses from the BeebSid Menu
				int initAddr = (beebSIDMenu[offset + 0] & 0xff) + ((beebSIDMenu[offset + 1] & 0xff) << 8);
				int playAddr = (beebSIDMenu[offset + 2] & 0xff) + ((beebSIDMenu[offset + 3] & 0xff) << 8);
				int loadAddr = (beebSIDMenu[offset + 9] & 0xff) + ((beebSIDMenu[offset + 10] & 0xff) << 8);

				System.out.println("initAddr = " + Integer.toHexString(initAddr));
				System.out.println("playAddr = " + Integer.toHexString(playAddr));
				System.out.println("loadAddr = " + Integer.toHexString(loadAddr));
				// Read the filename from the BeebSid Menu
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

				// Read and Relocate the Beeb SID File
				File srcSidFile = new File(beebSidDir, fileName);
				File dstSidFile = new File(atomSidDir, fileName);

				// Important to only try to relocate by an exact number of pages
				int relocateAddr = 0;
				if (blackList.contains(srcSidFile.toString())) {
					System.out.println("Skipping  sidreloc on " + srcSidFile + " because file was blacklisted");
				} else if (relocateAddrBase == 0) {
					System.out.println("Skipping  sidreloc on " + srcSidFile + " because relocAddr was 0");
				} else {
					relocateAddr = relocateAddrBase + (loadAddr & 0xff);
				}

				// Do the relocation
				int ret = relocate(srcSidFile, dstSidFile, Mode.FROM_BEEBSID, 0xbdc0, loadAddr, initAddr, playAddr, relocateAddr);

				// If relocation was successful, update the addresses
				if (relocateAddr != 0 && ret == 0) {
					initAddr += (relocateAddr - loadAddr);
					playAddr += (relocateAddr - loadAddr);
					loadAddr = relocateAddr;
				}

				String title;
				if (earlySid || (j >= songs.get(i + 1))) {
					title = fileName;
					earlySid = true;
				} else {
					title = "";
					while (beebSIDMenu[j] != (byte) 0 && beebSIDMenu[j] != (byte) 13 && beebSIDMenu[j] != (byte) 0x2e) {
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

				System.out.println("### " + title + " " + Integer.toHexString(loadAddr) + " " + Integer.toHexString(initAddr) + " "
						+ Integer.toHexString(playAddr) + " " + fileName);



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
			if (args.length != 4 && args.length != 5) {
				System.err.println("usage: java -jar atomsid.jar <BeebSIDMenu> <AtomSIDMenuBase> <BlackList File> <Output Dir> [ <relocateAddr> ]");
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

			File blacklist = new File(args[2]);
			if (!blacklist.exists()) {
				System.err.println("File: " + blacklist + " does not exist");
				System.exit(1);
			}

			File dir = new File(args[3]);
			dir.mkdirs();

			int relocateAddrBase = 0;
			if (args.length == 5) {
				relocateAddrBase = Integer.parseInt(args[4], 16);
			}
			BeebSIDtoAtomSID c = new BeebSIDtoAtomSID();
			c.beebSIDtoAtomSID(beebSIDMenuFile, atomSIDMenuFile, blacklist, dir, relocateAddrBase);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
