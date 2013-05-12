package uk.co.acornatom.basic;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

public class Convert {

	private static final int DEFAULT_LOADADDR = 0x2900;
	private static final int DEFAULT_EXECADDR = 0xc2b2;

	private static final int ASCII_0 = 48;
	private static final int ASCII_9 = 57;
	private static final int ASCII_CR = 13;
	private static final int ASCII_LF = 10;
	private static final int ASCII_SPACE = 32;
	private static final int ASCII_TAB = 9;

	private enum STATE {
		SEEKING, NUMBER, LINE
	};

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

	private void convertToAtm(File srcFile, File dstFile, int loadAddr, int execAddr) throws IOException {
		int b;
		int offset = 0;
		ByteArrayOutputStream bos = new ByteArrayOutputStream();

		STATE state = STATE.SEEKING;
		StringBuffer lineNumBuf = new StringBuffer();
		FileInputStream fis = new FileInputStream(srcFile);
		try {
			while ((b = fis.read()) > 0) {
				// STATE oldState = state;
				switch (state) {
				case SEEKING:
					if (b >= ASCII_0 && b <= ASCII_9) {
						lineNumBuf.setLength(0);
						lineNumBuf.append((char) b);
						state = STATE.NUMBER;
					} else if (b != ASCII_CR && b != ASCII_LF && b != ASCII_SPACE && b != ASCII_TAB) {
						throw new IOException("Encountered unexected character ascii: " + b + " in state " + state
								+ " at file offset " + offset);
					}
					break;
				case NUMBER:
					if (b == ASCII_CR || b == ASCII_LF) {
						System.err.println("Warning: skipping empty line: " + lineNumBuf.toString());
						state = STATE.SEEKING;
					} else if (b < ASCII_0 || b > ASCII_9) {
						int lineNum = Integer.parseInt(lineNumBuf.toString());
						if (lineNum > 0x7FFF) {
							throw new IOException("Line number too large: " + lineNumBuf.toString());
						}
						writeByte(bos, 13);
						writeByte(bos, lineNum / 256);
						writeByte(bos, lineNum % 256);
						writeByte(bos, b);
						state = STATE.LINE;
					} else {
						lineNumBuf.append((char) b);
					}
					break;
				case LINE:
					if (b == ASCII_CR || b == ASCII_LF) {
						state = STATE.SEEKING;
					} else {
						writeByte(bos, b);
					}
				}
				// System.out.println(b + " " + oldState + "->" + state);
			}
		} finally {
			fis.close();
		}
		writeByte(bos, 13);
		writeByte(bos, 255);
		FileOutputStream fos = new FileOutputStream(dstFile);
		writeATMFile(fos, dstFile.getName(), loadAddr, execAddr, bos.toByteArray());
		fos.close();
	}

	public static final void main(String[] args) {
		try {
			if (args.length < 2 || args.length > 4) {
				System.err.println("usage: java -jar atombasic.jar <Src Atom Basic Text File> <Dst ATM File> [loadAddr in hex] [exec Addr in hex]");
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

			int loadAddr = args.length > 2 ? Integer.parseInt(args[2], 16) : DEFAULT_LOADADDR;
			int execAddr = args.length > 3 ? Integer.parseInt(args[3], 16) : DEFAULT_EXECADDR;
			
			Convert c = new Convert();
			c.convertToAtm(srcFile, dstFile, loadAddr, execAddr);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
