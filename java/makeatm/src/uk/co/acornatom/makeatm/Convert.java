package uk.co.acornatom.makeatm;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class Convert {
	
	public static boolean DEBUG = false;

	private static final int DEFAULT_LOADADDR = 0xa000;
	private static final int DEFAULT_EXECADDR = 0xc2b2;

	public Convert() {
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

	private void convertToAtm(File srcFile, File dstFile, int loadAddr, int execAddr) throws IOException {
		byte[] raw = readFile(srcFile);
		FileOutputStream fos = new FileOutputStream(dstFile);
		writeATMFile(fos, dstFile.getName(), loadAddr, execAddr, raw);
		fos.close();
	}

	public static final void main(String[] args) {
		try {
			if (args.length < 2 || args.length > 4) {
				System.err.println("usage: java -jar makeatm.jar <Src Raw File> <Dst ATM File> [loadAddr in hex] [exec Addr in hex]");
				System.exit(1);
			}
			File srcFile = new File(args[0]);
			if (!srcFile.exists()) {
				System.err.println("Source File: " + srcFile + " does not exist");
				System.exit(1);
			}
			if (!srcFile.isFile()) {
				System.err.println("Source File: " + srcFile + " is not a file");
				System.exit(1);
			}
			File dstFile = new File(args[1]);
			
			if (args[1].contains("/") || args[1].contains("\\")) {
				File directory = dstFile.getParentFile();
				directory.mkdirs();
			}

			int loadAddr = args.length > 2 ? Integer.parseInt(args[2], 16) : DEFAULT_LOADADDR;
			int execAddr = args.length > 3 ? Integer.parseInt(args[3], 16) : DEFAULT_EXECADDR;

			System.out.println(dstFile + " " + Integer.toHexString(loadAddr) + " " + Integer.toHexString(execAddr));
			
			Convert c = new Convert();
			c.convertToAtm(srcFile, dstFile, loadAddr, execAddr);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
