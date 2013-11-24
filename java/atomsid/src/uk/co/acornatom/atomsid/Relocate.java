package uk.co.acornatom.atomsid;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class Relocate {

	public static boolean DEBUG = false;

	private static final int DEFAULT_SIDADDR = 0xBDC0;
	private static final int DEFAULT_LOADADDR = 0x2A00;
	private static final int DEFAULT_EXECADDR = 0x2A00;
	
	private enum Mode {
		FROM_ORIGINAL,
		FROM_ATOMSID,
		FROM_BEEBSID
	}

	public Relocate() {
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
	        while ( (read = ios.read(buffer)) != -1 ) {
        		ous.write(buffer, 0, read);
	        }
	    } finally { 
	        try {
	             if ( ous != null ) 
	                 ous.close();
	        } catch ( IOException e) {
	        }

	        try {
	             if ( ios != null ) 
	                  ios.close();
	        } catch ( IOException e) {
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
			if ((sid[i] == (byte) 0x8c) ||     // STY Absolute
					(sid[i] == (byte) 0x8d) || // STA Absolute
					(sid[i] == (byte) 0x8e) || // STX Absolute
					(sid[i] == (byte) 0x99) || // STA Absolute,Y
					(sid[i] == (byte) 0x9d))   // STA Absolute,X
			{
				if (sid[i + 1] >= (byte) (oldSidBaseLo) && sid[i + 1] < (byte) (oldSidBaseLo + 0x20) && sid[i + 2] == (byte) oldSidBaseHi) {
					System.out.println("Relocating " + i + " "
							+ Integer.toHexString(sid[i] & 0xff) + " "
							+ Integer.toHexString(sid[i + 1] & 0xff) + " "
							+ Integer.toHexString(sid[i + 2] & 0xff));
					sid[i + 1] = (byte) (((int) sid[i + 1]) + ((sidBase - oldSidBase) & 0xff));
					sid[i + 2] = (byte) (((int) sid[i + 2]) + ((sidBase - oldSidBase) >> 8) & 0xff);
					System.out.println("    to     " + i + " "
							+ Integer.toHexString(sid[i] & 0xff) + " "
							+ Integer.toHexString(sid[i + 1] & 0xff) + " "
							+ Integer.toHexString(sid[i + 2] & 0xff));
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

	public static final void main(String[] args) {
		try {
			if (args.length < 2 || args.length > 5) {
				System.err
						.println("usage: java -jar atomsid.jar <Src Sid File> <Dst Sid File> [sidAddr in hex] [loadAddr in hex] [exec Addr in hex]");
				System.exit(1);
			}
			File srcFile = new File(args[0]);
			if (!srcFile.exists()) {
				System.err.println("Source Sid File: " + srcFile + " does not exist");
				System.exit(1);
			}
			if (!srcFile.isFile()) {
				System.err.println("Source Sid File: " + srcFile + " is not a file");
				System.exit(1);
			}
			File dstFile = new File(args[1]);

			if (args[1].contains("/") || args[1].contains("\\")) {
				File directory = dstFile.getParentFile();
				directory.mkdirs();
			}

			int sidAddr = args.length > 2 ? Integer.parseInt(args[2], 16) : DEFAULT_SIDADDR;
			int loadAddr = args.length > 3 ? Integer.parseInt(args[3], 16) : DEFAULT_LOADADDR;
			int execAddr = args.length > 4 ? Integer.parseInt(args[4], 16) : DEFAULT_EXECADDR;

			System.out.println(dstFile + " " + Integer.toHexString(loadAddr) + " " + Integer.toHexString(execAddr));

			Relocate c = new Relocate();
			c.relocate(srcFile, dstFile, Mode.FROM_ATOMSID, sidAddr, loadAddr, execAddr);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
