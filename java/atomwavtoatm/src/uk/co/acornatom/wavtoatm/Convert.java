package uk.co.acornatom.wavtoatm;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import uk.co.acornatom.wavtoatm.WavToBits.Mode;

public class Convert {

	public static boolean DEBUG = false;

	private static final int ASCII_STAR = '*';
	private static final int ASCII_CR = 13;

	public static final String NUM_GOOD_BLOCKS = "numGoodBlocks";
	public static final String NUM_BAD_BLOCKS = "numBadBlocks";
	public static final String NUM_MISSING_BLOCKS = "numMissingBlocks";
	public static final String NUM_EXPECTED_BLOCKS = "numExpectedBlocks";
	public static final String NUM_GOOD_FILES = "numGoodFiles";
	public static final String NUM_BAD_FILES = "numBadFiles";
	public static final String NUM_EXPECTED_FILES = "numExpectedFiles";
	
	private enum STATE {
		SYNC0, SYNC1, SYNC2, SYNC3, FILENAME, BLOCKFLAG, BLOCKNUMLO, BLOCKNUMHI, DATALEN, EXECHI, EXECLO, LOADHI, LOADLO, DATA, CKSUM
	}

	private enum MODE {
		SCAN, PROCESS
	}

	File dstFile;

	
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

	public Map<String, Integer> convertToAtm(File srcFile) throws IOException {

		int b;
		FileInputStream fis = new FileInputStream(srcFile);
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		while ((b = fis.read()) >= 0) {
			bos.write(b);
		}
		fis.close();
		byte bytes[] = bos.toByteArray();

		return convertToAtm(bytes);
	}

	public Map<String, Integer> convertToAtm(byte[] bytes) throws IOException {

		Map<String, Integer> fileBlockMap = new HashMap<String, Integer>();

		
		// Scan for filenames and numbers of blocks
		process(MODE.SCAN, bytes, fileBlockMap);

		int expectedBlocks = 0;
		for (Map.Entry<String, Integer> entry : fileBlockMap.entrySet()) {
			expectedBlocks += entry.getValue() + 1;
		}

		// Process
		Map<String, Integer> stats = process(MODE.PROCESS, bytes, fileBlockMap);

		stats.put(NUM_EXPECTED_BLOCKS, expectedBlocks);
		stats.put(NUM_EXPECTED_FILES, fileBlockMap.size());
		
		return stats;
	}

	private Map<String, Integer> process(MODE mode, byte[] bytes, Map<String, Integer> fileBlockMap) throws IOException {

		int numGoodBlocks = 0;
		int numBadBlocks = 0;
		int numMissingBlocks = 0;
		int numGoodFiles = 0;
		int numBadFiles = 0;

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
		boolean seenBadBlock = false;

		if (mode == MODE.SCAN) {
			fileBlockMap.clear();
		}

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
					log(mode, "    WARNING: Block Sync truncated to **");

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
					log(mode, "    WARNING: Block Sync truncated to ***");

					state = STATE.FILENAME;
				}
				break;

			case FILENAME:
				blockcksum += b;
				if (b == ASCII_CR) {
					state = STATE.BLOCKFLAG;
				} else if (blockFileName.length() > 13) {
					log(mode, "    ERROR: Filename too long: " + blockFileName);
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

				log(mode, "### " + blockFileName + " " + toHex2(blockflag) + " " + toHex4(blocknum) + " " + toHex2(blocklen) + " "
						+ toHex4(blockloadaddr) + " " + toHex4(blockexecaddr));

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

				if (cksumGood) {
					numGoodBlocks++;
				} else {
					numBadBlocks++;
				}

				if (!cksumGood) {
					log(mode, "    ERROR: Bad Checksum; expected " + toHex2(blockcksum & 255) + " actual " + toHex2(b));

					// We might have lost sync, so back off a few bytes
					i -= 8;

				}

				if (expectedBlockNum != blocknum) {
					log(mode, "    ERROR: Expected block num: " + expectedBlockNum + "; actual block num: " + blocknum);
					if (cksumGood) {
						for (int j = 0; j < 256 * (blocknum - expectedBlockNum); j++) {
							data.write(0);
						}
						numMissingBlocks += (blocknum - expectedBlockNum);
						expectedBlockNum = blocknum;
						seenBadBlock = true;
					}
				}

				if (expectedBlockNum == 0) {
					if ((blockflag & 0x60) != 0x40) {
						log(mode, "    ERROR: Inconsistent block flag: " + toHex2(blockflag) + " for block " + expectedBlockNum);
					}
				} else {
					if ((blockflag & 0x60) != 0x60) {
						log(mode, "    ERROR: Inconsistent block flag: " + toHex2(blockflag) + " for block " + expectedBlockNum);
					}
				}
				
				if (!seenBadBlock && !cksumGood) {
					seenBadBlock = true;
				}

				if (!seenGoodBlock && cksumGood) {

					loadaddr = blockloadaddr - 256 * blocknum;
					execaddr = blockexecaddr;
					fileName = blockFileName.toString();

					seenGoodBlock = true;

				} else if (seenGoodBlock) {
					if (loadaddr + blocknum * 256 != blockloadaddr) {
						log(mode, "    ERROR: Expected load addr: " + toHex4(loadaddr + blocknum * 256) + "; actual load addr: "
								+ toHex4(blockloadaddr));
					}
					if (execaddr != blockexecaddr) {
						log(mode, "    ERROR: Expected exec addr: " + toHex4(execaddr) + "; actual exec addr: "
								+ toHex4(blockexecaddr));
					}
					if (!fileName.equals(blockFileName)) {
						log(mode, "    ERROR: Expected filename: " + fileName + "; actual filename: " + blockFileName);
					}
				}

				if (mode == MODE.SCAN) {
					if (cksumGood || fileBlockMap.containsKey(blockFileName)) {
						fileBlockMap.put(blockFileName, expectedBlockNum);
					}

					// When scanning, we have to rely on the block flag to
					// indicate the last block
					if ((blockflag & 128) == 0) {
						data = new ByteArrayOutputStream();
						expectedBlockNum = 0;
						seenGoodBlock = false;
					} else {
						expectedBlockNum++;

					}

				} else {

					// When processing, we can do better

					if (fileName != null && fileBlockMap.containsKey(fileName) && expectedBlockNum == fileBlockMap.get(fileName)) {

						fileName = fileName.replace("/", "_");
						if (seenBadBlock) {
							fileName = "e" + fileName;
						}

						byte[] databytes = data.toByteArray();
						log(mode, "");
						log(mode, "    Writing " + fileName + " " + toHex4(loadaddr) + " +" + toHex4(databytes.length) + " "
								+ toHex4(execaddr));
						log(mode, "");

						// Flush the ATM FIle
						FileOutputStream fos = new FileOutputStream(dstFile + "/" + fileName);
						writeATMFile(fos, fileName, loadaddr, execaddr, databytes);
	
						if (!seenBadBlock) {
							numGoodFiles++;
						} else {
							numBadFiles++;
						}
						
						data = new ByteArrayOutputStream();
						expectedBlockNum = 0;
						seenGoodBlock = false;
						seenBadBlock = false;

					} else {
						expectedBlockNum++;

					}
				}
				state = STATE.SYNC0;
				break;
			}
			if (DEBUG) {
				System.out.println(b + " " + oldState + "->" + state);
			}
		}
		Map<String, Integer> stats = new HashMap<String, Integer>();
		stats.put(NUM_GOOD_BLOCKS, numGoodBlocks);
		stats.put(NUM_BAD_BLOCKS, numBadBlocks);
		stats.put(NUM_MISSING_BLOCKS, numMissingBlocks);
		stats.put(NUM_GOOD_FILES, numGoodFiles);
		stats.put(NUM_BAD_FILES, numBadFiles);
		return stats;
	}

	private void log(MODE mode, String message) {
		if (mode == MODE.PROCESS) {
			System.out.println(message);
		}
	}

	public static Map<String, Integer> processSource(File dstDir, File srcFile, Mode mode, int channel) throws IOException {

		boolean bothEdges = mode == Mode.NEW;
		
		int window1 = 8; // smooth wav by averaging over window1 samples
		int window2 = 5; // smooth number of cycles in the next bit by averaging over bitlength / windows2 samples

		System.out.println("============================================");
		System.out.println("@@@ " + srcFile.getName());
		System.out.println("============================================");
		System.out.println("@@@ windows1 = " + window1);
		System.out.println("@@@ windows2 = " + window2);

		byte[] bytes;

		if (srcFile.getName().toLowerCase().endsWith(".wav")) { 

			if (mode == Mode.SIMPLE) {

				return doItSimple(dstDir, srcFile, mode, channel, window1, window2, bothEdges);
			} else {
				return doIt(dstDir, srcFile, mode, channel, window1, window2, bothEdges);
			} 
		} else if (srcFile.getName().toLowerCase().endsWith(".dat")) {

			Convert c = new Convert(dstDir);
			return c.convertToAtm(srcFile);

		} else {
			throw new RuntimeException("Unsupported file suffix: " + srcFile);
		}
		
	}

	private static Map<String, Integer>  doItSimple(File dstDir, File srcFile, Mode mode, int channel, int window1, int window2, boolean bothEdges) throws IOException {
		byte[] bytes;
			WavToBits wavToBits = new WavToBits(srcFile, window1, window2);

			double bitLength = wavToBits.processNew(channel);
			System.out.println("@@@ bitLength = " + bitLength);
			
			Map<String, Integer> fileBlockMap = new HashMap<String, Integer>();
			
			int best = -1;
			int bestThreshold1 = 0;
			int bestThreshold2 = 0;

			for (int threshold = 12000; threshold < 13500; threshold += 50) {

				Convert c = new Convert(dstDir);				
				bytes = wavToBits.sampleNew(threshold);
				Map<String, Integer>  stats = c.process(MODE.SCAN, bytes, fileBlockMap);
				
				int numGoodBlocks = stats.get(NUM_GOOD_BLOCKS);
				int numBadBlocks = stats.get(NUM_BAD_BLOCKS);
				System.out.println("@@@ Threshold = " + threshold + "\t numGoodBlocks = " + numGoodBlocks + "\t numBadBlocks =" + numBadBlocks);
				if (numGoodBlocks > best) {
					best = numGoodBlocks;
					bestThreshold1 = threshold;
					bestThreshold2 = threshold;
				} else if (numGoodBlocks == best) {
					bestThreshold2 = threshold;
				}
			}
			int threshold = (bestThreshold1 + bestThreshold2) / 2;
			System.out.println("@@@ Optimal sampling threshold range: " + bestThreshold1 + " to " + bestThreshold2 + "; using " + threshold);
 			Convert c = new Convert(dstDir);
			bytes = wavToBits.sampleNew(threshold);
			return c.convertToAtm(bytes);
	}


	private static Map<String, Integer>  doIt(File dstDir, File srcFile, Mode mode, int channel, int window1, int window2, boolean bothEdges) throws IOException {
		byte[] bytes;
			WavToBits wavToBits = new WavToBits(srcFile, window1, window2);

			double bitLength = wavToBits.process(channel, mode, bothEdges);
			System.out.println("@@@ bitLength = " + bitLength);
			
			Map<String, Integer> fileBlockMap = new HashMap<String, Integer>();
			
			int best = -1;
			int bestThreshold1 = 0;
			int bestThreshold2 = 0;
			
			int loThreshold = (int) (5 * bitLength / window2);  // 180 when window2=4
			int hiThreshold = (int) (8 * bitLength / window2); // 288 when window2=4
			
			int step = 4 / window2;
			if (step < 1) {
				step = 1;
			}

			if (bothEdges) {
				loThreshold *= 2;
				hiThreshold *= 2;
				step *= 2;
			}

			for (int threshold = loThreshold; threshold < hiThreshold; threshold += step) {
				Convert c = new Convert(dstDir);
				
				bytes = wavToBits.sampleBytes(0, threshold, bitLength, bothEdges);
				Map<String, Integer>  stats = c.process(MODE.SCAN, bytes, fileBlockMap);
				
				int numGoodBlocks = stats.get(NUM_GOOD_BLOCKS);
				// System.out.println("@@@ Threshold = " + threshold + " numGoodBlocks = " + numGoodBlocks);
				if (numGoodBlocks > best) {
					best = numGoodBlocks;
					bestThreshold1 = threshold;
					bestThreshold2 = threshold;
				} else if (numGoodBlocks == best) {
					bestThreshold2 = threshold;
				}
			}
			int threshold = (bestThreshold1 + bestThreshold2) / 2;
			System.out.println("@@@ Optimal sampling threshold range: " + bestThreshold1 + " to " + bestThreshold2 + "; using " + threshold);
 			Convert c = new Convert(dstDir);
			bytes = wavToBits.sampleBytes(0, threshold, bitLength, bothEdges);
			return c.convertToAtm(bytes);
	}


	public static final void main(String[] args) {
		try {
			if (args.length < 2 || args.length > 4) {
				System.out.println("usage: java -jar atomwavtoatm.jar <Src Wav/Dat File or Diurectory> <Dst ATM Dir> [channel] [OLD | NEW]");
				System.exit(1);
			}
			File src = new File(args[0]);
			if (!src.exists()) {
				System.out.println("Source: " + src + " does not exist");
				System.exit(1);
			}

			List<File> srcFiles = new ArrayList<File>();
			
			File dstDir = new File(args[1]);
			dstDir.mkdirs();

			if (src.isDirectory()) {
				for (String file : src.list(new FilenameFilter() {
					@Override
					public boolean accept(File dir, String name) {
						return name.toLowerCase().endsWith(".wav") || name.toLowerCase().endsWith(".dat");
					}
				})) {
					srcFiles.add(new File(src, file));
				}
			} else {
				srcFiles.add(src);
			}

			Collections.sort(srcFiles);
			
			int channel;
			if (args.length > 2) {
				channel = Integer.valueOf(args[2]);
			} else {
				channel = 0;
			}
			
			Mode mode;
			if (args.length > 3) {
				mode = Mode.valueOf(args[3].toUpperCase());
			} else {
				mode = Mode.NEW;
			}
			
			Map<String, Integer> totalStats = null;
			int i = 0;
			for (File srcFile : srcFiles) {
				File dir = new File(dstDir, "" + (i/10) + (i%10));
				dir.mkdirs();
				Map<String, Integer>  stats = processSource(dir, srcFile, mode, channel);
				if (totalStats == null) {
					totalStats = stats;
				} else {
					for (Map.Entry<String, Integer> entry : stats.entrySet()) {
						totalStats.put(entry.getKey(), totalStats.get(entry.getKey()) + entry.getValue());
					}
				}
				i++;
			}

			for (Map.Entry<String, Integer> entry : totalStats.entrySet()) {
				System.out.println("@@@ " + entry.getKey() + " = " + entry.getValue());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
