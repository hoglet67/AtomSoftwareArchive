package uk.co.acornatom.quill;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class AtomQuill {

	private static final int[] char1Tab = new int[] { 0x73, 0x63, 0x69, 0x69, 0x65, 0x6C, 0x6F, 0x65, 0x74, 0x65, 0x68, 0x6C, 0x64,
			0x72, 0x6E, 0x63, 0x6F, 0x65, 0x69, 0x74, 0x61, 0x73, 0x65, 0x61, 0x65, 0x6F, 0x64, 0x6C, 0x61, 0x65, 0x61, 0x67 };

	private static final int[] char2Tab = new int[] { 0x74, 0x68, 0x65, 0x6E, 0x64, 0x65, 0x75, 0x65, 0x68, 0x72, 0x65, 0x6C, 0x73,
			0x65, 0x74, 0x6B, 0x72, 0x61, 0x74, 0x6F, 0x6E, 0x73, 0x73, 0x74, 0x6E, 0x6F, 0x6F, 0x79, 0x64, 0x78, 0x6D, 0x68 };

	private static final int OLD_WIDTH = 40;
	
	private int srcAddr;
	private int dstAddr;

	private AtomQuill(int srcAddr, int dstAddr) {
		this.srcAddr = srcAddr;
		this.dstAddr = dstAddr;
	}

	private byte[] read(File file) throws IOException {
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

	private void writeString(OutputStream out, String value) throws IOException {
		out.write(value.getBytes());
	}

	private void writeShort(OutputStream out, int value) throws IOException {
		out.write(value);
		out.write(value >> 8);
	}

	private void writeShortAddr(ByteArrayOutputStream os, int offset) throws IOException {
		int addr = offset + dstAddr;
		writeByte(os, addr);
		writeByte(os, addr >> 8);
	}

	private void writeByte(OutputStream out, int value) throws IOException {
		out.write(value);
	}

	private int readShortAddr(byte[] src, int offset) {
		return (0xff & src[offset]) + 256 * (0xff & src[offset + 1]) - srcAddr;
	}

	private int readByte(byte[] src, int offset) {
		return 0xff & src[offset];
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

	private void migrateDatabase(File srcFile, File dstFile, int newWidth) throws IOException {
		byte[] dst = migrateDatabase(read(srcFile), OLD_WIDTH, newWidth, true);
		FileOutputStream fos = new FileOutputStream(dstFile);
		writeATMFile(fos, dstFile.getName(), srcAddr, srcAddr, dst);
		fos.close();
	}
	
	private byte[] migrateDatabase(byte[] src, int oldWidth, int newWidth, boolean write) throws IOException {

		int numMessages = readByte(src, 18);
		int numLocations = readByte(src, 19);
		int numObjects = readByte(src, 20);
		int numConveyableObjects = readByte(src, 21);

		int vocabularyTable = readShortAddr(src, 0);
		int messageTable = readShortAddr(src, 2);
		int locationTable = readShortAddr(src, 4);
		int objectTable = readShortAddr(src, 6);
		int objectWordTable = readShortAddr(src, 8);
		int objectStartLocationTable = objectWordTable + numObjects;
		int movementTable = readShortAddr(src, 10);
		int eventTable = readShortAddr(src, 12);
		int statusTable = readShortAddr(src, 14);
		int end = readShortAddr(src, 16);


		System.out.println("vocabularyTable = " + vocabularyTable);
		System.out.println("messageTable = " + messageTable);
		System.out.println("locationTable = " + locationTable);
		System.out.println("objectTable = " + objectTable);
		System.out.println("objectWordTable = " + objectWordTable);
		System.out.println("objectStartLocationTable = " + objectStartLocationTable);
		System.out.println("movementTable = " + movementTable);
		System.out.println("eventTable = " + eventTable);

		System.out.println("statusTable = " + statusTable);
		System.out.println("end = " + end);

		System.out.println("numMessages = " + numMessages);
		System.out.println("numLocations = " + numLocations);
		System.out.println("numObjects = " + numObjects);
		System.out.println("numConveyableObjects = " + numConveyableObjects);

		byte[] messages = getTable(src, messageTable, numMessages);
		byte[] newMessages = dumpTable("Message", messages, numMessages, oldWidth, newWidth);

		byte[] locations = getTable(src, locationTable, numLocations);
		byte[] newLocations = dumpTable("Location", locations, numLocations, oldWidth, newWidth);

		byte[] objects = getTable(src, objectTable, numObjects);
		byte[] newObjects = dumpTable("Object", objects, numObjects, oldWidth, newWidth);

		if (write) {
			// Correct the addresses
			int c1 = newMessages.length - messages.length;
			int c2 = c1 + newLocations.length - locations.length;
			int c3 = c2 + newObjects.length - objects.length;
	
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			
			// header
			writeShortAddr(bos, vocabularyTable);
			writeShortAddr(bos, messageTable);
			writeShortAddr(bos, locationTable + c1);
			writeShortAddr(bos, objectTable + c2);
			writeShortAddr(bos, objectWordTable + c3);
			writeShortAddr(bos, movementTable + c3);
			writeShortAddr(bos, eventTable + c3);
			writeShortAddr(bos, statusTable + c3);
			writeShortAddr(bos, end + c3);
			writeByte(bos, numMessages);
			writeByte(bos, numLocations);
			writeByte(bos, numObjects);
			writeByte(bos, numConveyableObjects);	
			// vocabularyTable
			bos.write(src, vocabularyTable, messageTable - vocabularyTable);
			// messageTable
			bos.write(newMessages, 0, newMessages.length);
			// locationTable
			bos.write(newLocations, 0, newLocations.length);
			// objectTable
			bos.write(newObjects, 0, newObjects.length);
			// remaining tables
			bos.write(src, objectWordTable, end - objectWordTable);
	
			byte[] dst = bos.toByteArray();

			// Sanity check database
			migrateDatabase(dst, newWidth, newWidth, false);
			
			return dst;
		} else {
			return  null;
		}
			
		
	}

	private byte[] getTable(byte[] src, int start, int count) {
		int end = start;
		for (int i = 0; i <= count; i++) {
			end += readByte(src, end);
		}
		byte[] table = new byte[end - start];
		System.arraycopy(src, start, table, 0, end - start);
		return table;
	}

	private byte[] dumpTable(String type, byte[] src, int count, int oldWidth, int newWidth) {
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		
		int offset = 0;
		for (int i = 0; i <= count; i++) {
			int len = readByte(src, offset);
			
			String uncompressed1 = uncompress(src, offset + 1, len - 1, oldWidth);
			
			String reJustified = justify(uncompressed1, newWidth, type.equals("Message") && i == 49);
			byte[] compressedBytes = compress(reJustified);
			
			// Sanity Check
			String uncompressed2 = uncompress(compressedBytes, 0, compressedBytes.length, newWidth);

			String raw1 = rawForDebug(src, offset + 1, len - 1);
			String raw2 = rawForDebug(compressedBytes, 0, compressedBytes.length);;

			if (uncompressed1.equals(uncompressed2)) {
				System.out.println(type + " " + i + " passed");
//				System.out.println(raw1);
//				System.out.println(raw2);
			} else {
				System.out.println(type + " " + i + " failed");				
				System.out.println(raw1);
				System.out.println(uncompressed1);
				System.out.println(reJustified);
				System.out.println(uncompressed2);
				System.out.println(raw2);
			}
			if (compressedBytes.length > 255) {
				throw new RuntimeException("Overflow!!");
			}
			bos.write(compressedBytes.length + 1);
			bos.write(compressedBytes, 0, compressedBytes.length);
			offset += len;
		}
		byte[] newBytes = bos.toByteArray();
		System.out.println(type + " length = " + src.length + "; new length = " + newBytes.length);
		return newBytes;
	}

	private String uncompress(byte[] table, int offset, int len, int width) {
		StringBuffer sb = new StringBuffer();

		int pos = 0;
		for (int i = 0; i < len; i++) {
			int b = 0xff & table[offset + i];
			int c = b & 0x7f;
			if (c == '>') {
				pos = append(sb, '\n', pos, width);
			} else if (c == 64) {
				pos = append(sb, ' ', pos, width);
			} else if (c < 32) {
				pos = append(sb, char1Tab[c], pos, width);
				pos = append(sb, char2Tab[c], pos, width);
			} else {
				pos = append(sb, c, pos, width);
			}
			if (b >= 128) {
				pos = append(sb, ' ', pos, width);
			}
		}
		return removeLineBreaks(sb.toString());
	}

	private int append(StringBuffer sb, int c, int pos, int width) {
		sb.append((char) c);
		pos++;
		if (c == '\n') {
			pos = 0;
		} else if (pos == width) {
			sb.append('\n');
			pos = 0;
		}
		return pos;
	}

	private String removeLineBreaks(String s) {
		s = s.replace("\n\n\n", "###");
		s = s.replace("\n\n", "##");
		s = s.replace("\n", " ");
		String f = "                    ";
		for (int i = f.length(); i > 0; i--) {
			String p = f.substring(0, i);
			s = s.replace(p, " ");
		}
		//System.out.println("x1: " + s);
		s = s.replace("#", "\n");
		//System.out.println("x2: " + s);
		//s = s.trim();
		return s;
	}
	
	private byte[] compress(String s) {
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		for (int i = 0; i < s.length(); i++) {
			int b = 0;
			boolean compressed = false;
			int c1 = s.charAt(i);
			if (i + 1 < s.length()) {
				int c2 = s.charAt(i + 1);
				if (Character.isLowerCase(c1) && Character.isLowerCase(c2)) {
					for (int j = 0; j < 32; j++) {
						if (char1Tab[j] == c1 && char2Tab[j] == c2) {
							b = j;
							i += 1;
							compressed = true;
							break;
						}
					}
				}
			}
			if (!compressed) {
				b = c1;
			}
			if (i + 1 < s.length()) {
				if (s.charAt(i + 1) == ' ') {
					b += 128;
					i ++;
				}
			}
			bos.write(b);
		}
		return bos.toByteArray();
		
	}

	private String rawForDebug(byte[] table, int offset, int len) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < len; i++) {
			int b = 0xff & table[offset + i];
			int c = b & 0x7f;
			if (c < 32) {
				sb.append((char) char1Tab[c]);
				sb.append((char) char2Tab[c]);
			} else {
				sb.append((char) c);
			}
			if (b >= 128) {
				sb.append((char) ' ');
			}
		}
		return sb.toString();
	}

	private String justify(String s, int width, boolean debug) {
		if (debug) {
			System.out.println(s);
		}
		StringBuffer sb = new StringBuffer();
		int i = 0;
		boolean insertNewline = false;
		while (i < s.length()) {
			if (insertNewline) {
				sb.append(">");
			}
			insertNewline = true;
			int pos = s.indexOf('\n', i);
			if (pos == -1) {
				pos = s.length();
			}
			String para = s.substring(i, pos);
			if (para.length() > 0) {
				String justifed = justifyPara(para, width);
				sb.append(justifed);
				if (justifed.length() % width == 0) {
					insertNewline = false;
				}
			}
			i += para.length() + 1;
		}
		if (debug) {
			System.out.println(sb.toString());
		}
		return sb.toString();
	}
	private String justifyPara(String s, int width) {
		if (s.contains("\n")) {
			throw new RuntimeException("Contains newlines");
		}
		if (s.contains("  ")) {
			throw new RuntimeException("Contains double spaces");
		}
		StringBuffer sb = new StringBuffer();
		int i = 0;
		while (i < s.length()) {
			if (i + width >= s.length()) {
				sb.append(s.substring(i));
				i = s.length();
			} else {
				int j = i + width;
				while (s.charAt(j) != ' ') {
					j--;
				}
				sb.append(s.substring(i, j));
//				if (j - i < width) {
//					sb.append('>');					
//				}
				for (int f = j - i; f < width; f++) {
					sb.append('@');
				}
				i = j + 1;
			}
		}
		return sb.toString();
	}

	public static final void main(String args[]) {

		try {

			if (args.length < 2 || args.length > 5) {
				System.err.println("usage: java -jar atomquill.jar <Src Quill Database> <Dst Quill Database> [<Width> [<SrcAddr> [<DstAddr>]]]");
				System.exit(1);
			}

			File srcFile = new File(args[0]);
			if (!srcFile.exists()) {
				System.err.println("Source directory or file: " + srcFile + " does not exist");
				System.exit(1);
			}

			File dstFile = new File(args[1]);

			int newWidth = args.length > 2 ? Integer.parseInt(args[2]) : 32;
			
			int srcAddr = args.length > 3 ? Integer.parseInt(args[2]) : 0x3500;

			int dstAddr = args.length > 4 ? Integer.parseInt(args[2]) : srcAddr;

			AtomQuill migrator = new AtomQuill( srcAddr, dstAddr);

			migrator.migrateDatabase(srcFile, dstFile, newWidth);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
