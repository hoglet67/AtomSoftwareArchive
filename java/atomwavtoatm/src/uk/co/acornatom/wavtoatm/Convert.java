package uk.co.acornatom.wavtoatm;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

public class Convert {

	public static boolean DEBUG = false;

	private static final int ASCII_STAR = '*';
	private static final int ASCII_CR = 13;

	private enum STATE {
		SYNC0, SYNC1, SYNC2, SYNC3, FILENAME, BLOCKFLAG, BLOCKNUMLO, BLOCKNUMHI, DATALEN, EXECHI, EXECLO, LOADHI, LOADLO, DATA, CKSUM
	};

	File dstFile;
	
	
	STATE state = STATE.SYNC0;
	STATE oldState = state;

	ByteArrayOutputStream data = new ByteArrayOutputStream();

	int execaddr = 0;
	int loadaddr = 0;
	String fileName = null;

	String blockFileName = null;
	int blockflag = 0;
	int blockloadaddr = 0;
	int blockexecaddr = 0;
	int blocklen = 0;
	int blocknum = 0;
	int blockcksum = 0;

	int expectedBlockNum = 0;

	boolean seenGoodBlock = false;

	
	public Convert(File dstFile) {
		this.dstFile = dstFile;
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

	String toHex2(int i) {
		String pad = "";
		if (i < 16) {
			pad = "0";
		}
		return pad + Integer.toString(i, 16);
	}

	String toHex4(int i) {
		String pad = "";
		if (i < 16) {
			pad = "000";
		} else if (i < 256) {
			pad = "00";
		} else if (i < 4096) {
			pad = "0";
		}
		
		return pad + Integer.toString(i, 16);
	}

	private void convertToAtm(File srcFile) throws IOException {

		int b;
		FileInputStream fis = new FileInputStream(srcFile);
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		while ((b = fis.read()) >= 0) {
			bos.write(b);
		}
		fis.close();
		byte bytes[] = bos.toByteArray();

		process(bytes);

	}

		


	
	private void process(byte[] bytes) throws IOException {

		
		for (int i = 0; i < bytes.length; i++) {

			int b = (((int) bytes[i]) + 0x100) & 0xff;

			oldState = state;
			switch (state) {
			case SYNC0:
				
				blockflag = 0;
				blockloadaddr = 0;
				blockexecaddr = 0;
				blocklen = 0;
				blocknum = 0;
				blockcksum = 0xa8; // Sum of ****
				blockFileName = "";

				if (b == ASCII_STAR) {
					state = STATE.SYNC1;
				} else {
					state = STATE.SYNC0;
				}
				break;
			case SYNC1:
				if (b == ASCII_STAR) {
					state = STATE.SYNC2;
				} else {
					state = STATE.SYNC0;
				}
				break;
			case SYNC2:
				if (b == ASCII_STAR) {
					state = STATE.SYNC3;
				} else {
					
					// cope with case of sync marker truncated					
					blockcksum += b;
					blockFileName = blockFileName + (char) b;
					System.out.println("    WARNING: Block Sync truncated to **");
					
					state = STATE.FILENAME;
				}
				break;
			case SYNC3:
				if (b == ASCII_STAR) {
					state = STATE.FILENAME;
				} else {
					
					// cope with case of sync marker truncated					
					blockcksum += b;
					blockFileName = blockFileName + (char) b;
					System.out.println("    WARNING: Block Sync truncated to ***");

					state = STATE.FILENAME;
				}
				break;
				
				
			case FILENAME:
				blockcksum += b;
				if (b == ASCII_CR) {
					state = STATE.BLOCKFLAG;
				} else if (blockFileName.length() > 13) {
					System.out.println("    ERROR: Filename too long: " + blockFileName);
					state = STATE.SYNC0;
				} else {
					blockFileName = blockFileName + (char) b;
				}
				break;
			case BLOCKFLAG:
				blockcksum += b;
				blockflag = b;
				state = STATE.BLOCKNUMHI;
				break;
			case BLOCKNUMHI:
				blockcksum += b;
				blocknum += b * 256;
				state = STATE.BLOCKNUMLO;
				break;
			case BLOCKNUMLO:
				blockcksum += b;
				blocknum += b;
				state = STATE.DATALEN;
				break;
			case DATALEN:
				blockcksum += b;
				blocklen = b;
				state = STATE.EXECHI;
				break;
			case EXECHI:
				blockcksum += b;
				blockexecaddr += b * 256;
				state = STATE.EXECLO;
				break;
			case EXECLO:
				blockcksum += b;
				blockexecaddr += b;
				state = STATE.LOADHI;
				break;
			case LOADHI:
				blockcksum += b;
				blockloadaddr += b * 256;
				state = STATE.LOADLO;
				break;
			case LOADLO:
				blockcksum += b;
				blockloadaddr += b;

				System.out.println("### " + blockFileName + " " + toHex2(blockflag) + " " + toHex4(blocknum) + " "
						+ toHex2(blocklen) + " " + toHex4(blockloadaddr) + " " + toHex4(blockexecaddr));

				state = STATE.DATA;
				break;
			case DATA:
				blockcksum += b;
				data.write(b);
				blocklen--;
				if (blocklen < 0) {
					state = STATE.CKSUM;
				}
				break;
			case CKSUM:
				
				boolean cksumGood = b == (blockcksum & 255);

				if (!cksumGood) {
					System.out.println("    ERROR: Bad Checksum; expected " + toHex2(blockcksum & 255) + " actual " + toHex2(b));
					
					// We might have lost sync, so back off a few bytes	
					i -= 16;
	
				}

				if (expectedBlockNum != blocknum) {
					System.out.println("    ERROR: Expected block num: " + expectedBlockNum + "; actual block num: " + blocknum);
					if (cksumGood) {
						for (int j = 0; j < 256 * (blocknum - expectedBlockNum); j++) {
							data.write(0);
						}
						expectedBlockNum = blocknum;
					}
				}

				if (expectedBlockNum == 0) {
					if ((blockflag & 0x60) != 0x40) {
						System.out.println("    ERROR: Inconsistent block flag: " + toHex2(blockflag) + " for block "
								+ expectedBlockNum);
					}
				} else {
					if ((blockflag & 0x60) != 0x60) {
						System.out.println("    ERROR: Inconsistent block flag: " + toHex2(blockflag) + " for block "
								+ expectedBlockNum);
					}
				}

				
				if (!seenGoodBlock && cksumGood) {
					
					loadaddr = blockloadaddr - 256 * blocknum;
					execaddr = blockexecaddr;
					fileName = blockFileName.toString();

					seenGoodBlock = true;
					
				} else if (seenGoodBlock) {
					if (loadaddr + blocknum * 256 != blockloadaddr) {
						System.out.println("    ERROR: Expected load addr: " + toHex4(loadaddr + blocknum * 256)
								+ "; actual load addr: " + toHex4(blockloadaddr));
					}
					if (execaddr != blockexecaddr) {
						System.out.println("    ERROR: Expected exec addr: " + toHex4(execaddr) + "; actual exec addr: "
								+ toHex4(blockexecaddr));
					}
					if (!fileName.equals(blockFileName)) {
						System.out.println("    ERROR: Expected filename: " + fileName + "; actual filename: " + blockFileName);
					}
				}

				if ((blockflag & 128) == 0) {
					save();
					reset();
					
				} else {
					expectedBlockNum++;
				}
				state = STATE.SYNC0;
				break;
			}
			if (DEBUG) {
				System.out.println(b + " " + oldState + "->" + state);
			}
		}
	}
	
	private void save() throws IOException {
		if (fileName != null) {
			byte[] databytes = data.toByteArray();
			System.out.println();
			System.out.println("    Writing " + fileName + " " + toHex4(loadaddr) + " +" + toHex4(databytes.length) + " " + toHex4(execaddr));
			System.out.println();
			fileName = fileName.replace("/", "_");
			// Flush the ATM FIle
			FileOutputStream fos = new FileOutputStream(dstFile + "/" + fileName + ".ATM");
			writeATMFile(fos, dstFile.getName(), loadaddr, execaddr, databytes);
		}
	}

	private void reset() {
		data = new ByteArrayOutputStream();
		expectedBlockNum = 0;
		seenGoodBlock = false;
	}
	
	public static final void main(String[] args) {
		try {
			if (args.length != 2) {
				System.out.println("usage: java -jar atomwavtoatm.jar <Src Dat File> <Dst ATM Dir> ");
				System.exit(1);
			}
			File srcFile = new File(args[0]);
			if (!srcFile.exists()) {
				System.out.println("Source Atom Dat File: " + srcFile + " does not exist");
				System.exit(1);
			}
			if (!srcFile.isFile()) {
				System.out.println("Source Atom Dat File: " + srcFile + " is not a file");
				System.exit(1);
			}
			File dstDir = new File(args[1]);
			dstDir.mkdirs();

			Convert c = new Convert(dstDir);
			c.convertToAtm(srcFile);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
