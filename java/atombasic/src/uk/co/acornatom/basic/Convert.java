package uk.co.acornatom.basic;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;

public class Convert {

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

	private void writeByte(OutputStream out, int value) throws IOException {
		byte[] buffer = new byte[1];
		buffer[0] = (byte) (value & 0xff);
		out.write(buffer);
	}

	private void convertToAtm(File srcFile, File dstFile) throws IOException {
		String line;
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		BufferedReader reader = new BufferedReader(new FileReader(srcFile));
		try {
			while ((line = reader.readLine()) != null) {
				String originalLine = line;
				// Parse the line number
				int i = 0;
				while (i < line.length() && Character.isWhitespace(line.charAt(i))) {
					i = i + 1;
				}
				if (i == line.length()) {
					continue;
				}
				line = line.substring(i);
				i = 0;
				while (i < line.length() && Character.isDigit(line.charAt(i))) {
					i = i + 1;
				}
				if (i == 0) {
					throw new IOException("Malformed basic line: " + originalLine);
				}
				int lineNum = Integer.parseInt(line.substring(0, i));
				if (lineNum > 32676) {
					throw new IOException("Line number too large: " + originalLine);					
				}
				// Remove line number
				line = line.substring(i);
				if (line.length() == 0) {
					System.err.println("Warning: empty line: " + originalLine);
				}
				// Write to the ATM file
				writeByte(bos, 13);
				writeByte(bos, lineNum / 256);
				writeByte(bos, lineNum % 256);
				writeString(bos, line);
			}
			writeByte(bos, 13);
			writeByte(bos, 255);
		} finally {
			reader.close();
		}
		FileOutputStream fos = new FileOutputStream(dstFile);
		writeATMFile(fos, dstFile.getName(), 0x2900, 0xC2B2, bos.toByteArray());
		fos.close();
	}

	public static final void main(String[] args) {
		try {
			if (args.length != 2) {
				System.err.println("usage: java -jar atombasic.jar <Src Atom Basic Text File> <Dst ATM File>");
				System.exit(1);
			}
			File srcFile = new File(args[0]);
			if (!srcFile.exists()) {
				System.err.println("Source Atom Basic File: " + srcFile + " does not exist");
				System.exit(1);
			}
			if (!srcFile.isFile()) {
				System.err.println("Source Atom Basic File: " + srcFile + " is not a file");
				System.exit(1);
			}

			File dstFile = new File(args[1]);
			if (dstFile.exists()) {
				System.err.println("Destination ATM File: " + dstFile + " already exists");
				System.exit(1);
			}

			Convert c = new Convert();
			c.convertToAtm(srcFile, dstFile);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
