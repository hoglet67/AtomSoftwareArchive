package uk.co.acornatom.tape;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class AtomFile {

	private static final int CHANNELS = 1;
	private static final int SAMPLERATE = 44100;
	private static final int BITSPERSAMPLE = 16;

	/*
	 * 
	 * atm2wav By Charlie Robson
	 * 
	 * charlie_robson@hotmail.com arduinonut.blogspot.com
	 * 
	 * Convert an .atm format file to a WAV playable back to a real Atom or
	 * similar.
	 * 
	 * This is not intended to be production quality code, there may well be one
	 * or more of the following: Mistakes, misapprehensions, booboos, blunders
	 * or nasty hard-coding.
	 * 
	 * This is however to the best of my knowledge servicable code and may well
	 * provide one or more of the following: Understanding, amusement,
	 * usefulness.
	 * 
	 * Writes 16 bit 44.1khz mono wav file.
	 * 
	 * Enjoy!
	 * 
	 * 
	 * Information sources:
	 * 
	 * Atom technical manual:
	 * http://acorn.chriswhy.co.uk/docs/Acorn/Manuals/Acorn_AtomTechnicalManual
	 * .pdf
	 * 
	 * Atomic theory and practice: http://www.xs4all.nl/~fjkraan/comp/atom/atap/
	 * 
	 * Atom Rom disassembly:
	 * http://www.stairwaytohell.com/atom/wouterras/romdisas.zip
	 */

	private String title;
	private String collection;
	private int loadAddr;
	private int execAddr;
	private byte[] data;

	public AtomFile(String collection, String title, int loadAddr, int execAddr, byte[] data) {
		this.collection = collection;
		this.title = title;
		this.loadAddr = loadAddr;
		this.execAddr = execAddr;
		this.data = data;
	}

	public String getTitle() {
		return title;
	}

	public String getTitleClean() {

		String name = title;
		name = name.replace("_", "");
		// name = name.replace("-", "");
		name = name.replace("(", "");
		name = name.replace(")", "");
		name = name.replace("\t", "");
		name = name.replace("/", "");
		name = name.replace(" ", "");
		name = name.replace("?", "");
		name = name.replace(".", "");
		if (name.length() > 8) {
			name = name.substring(0, 8);
		}
		name = name.trim();
		if (name.length() == 0) {
			name = "@";
		}
		return name.toUpperCase();
	}

	public int getLoadAddr() {
		return loadAddr;
	}

	public int getExecAddr() {
		return execAddr;
	}

	public byte[] getData() {
		return data;
	}

	public String toString() {
		return "_" + title + " " + toHex4(loadAddr) + " " + toHex4(execAddr) + " " + toHex4(data.length) + " " + digest() + " " + collection;
	}

	public String digest() {
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("MD5");
			md.update(data, 0, data.length);
			byte[] messageDigest = md.digest();
			StringBuffer hexString = new StringBuffer();
			for (int j = 0; j < messageDigest.length; j++) {
				hexString.append(Integer.toHexString((messageDigest[j] & 0xFF) | 0x100).substring(1, 3));
			}
			return hexString.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return null;
	}

	private String toHex4(int i) {
		return Integer.toHexString((i & 0xFFFF) | 0x10000).substring(1, 5);
	}

	public void writeATMFile(OutputStream out) throws IOException {
		writeString(out, title);
		for (int i = 0; i < 16 - title.length(); i++) {
			out.write(0);
		}
		writeShort(out, loadAddr);
		writeShort(out, execAddr);
		writeShort(out, data.length);
		out.write(data);
	}

	public void writeBasicFile(OutputStream out) throws IOException {
		int state = 0;
		int lineno = 0;
		
		// Deal with the case where the load address is not page aligned
		// (the start of a basic program must be page aligned)
		int i = (0x100 - (loadAddr & 0xFF)) & 0xFF;

		// Look for a page that starts with 13 (0x0d)
		while (i < data.length) {
			int c = data[i] & 0xff;
			if (c == 13) {
				break;
			} else {
				i += 256;
			}
		}
		
		// Now run the state machine
		while (i < data.length) {
			int c = data[i] & 0xff;
			if (state == 0) {
				if (c == 13) {
					state = 1;
				    out.write(10);
				} else {
				    out.write(c);						
				}
			} else if (state == 1) {
				lineno = c;
				state = 2;
			} else if (state == 2) {
				lineno = (lineno << 8) + c;
				if (lineno < 32768) {
					out.write(Integer.toString(lineno).getBytes());
					state = 0;
				} else {
					break;
				}
			}
			i++;
		}
	}
	
	public void writeWavFile(OutputStream out) throws IOException {
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		FreqOut freqout = new FreqOut(this, bos);
		freqout.write(false);
		int bytesWrit = freqout.m_writtenSampleCount * BITSPERSAMPLE / 8;
		writeString(out, "RIFF"); // 0
		writeInt(out, bytesWrit + 36); // 4
		writeString(out, "WAVE"); // 8
		writeString(out, "fmt "); // 12
		writeInt(out, BITSPERSAMPLE); // 16
		writeShort(out, 1); // 20
		writeShort(out, CHANNELS); // 22
		writeInt(out, SAMPLERATE); // 24
		writeInt(out, SAMPLERATE * (BITSPERSAMPLE / 8 * CHANNELS)); // 28
		writeShort(out, BITSPERSAMPLE / 8 * CHANNELS); // 32
		writeShort(out, BITSPERSAMPLE); // 34
		writeString(out, "data"); // 36
		writeInt(out, bytesWrit); // 40
		out.write(bos.toByteArray());

		// output << "RIFF";
		// *(int*)chars = 16;
		// output << chars[0] << chars[1] << chars[2] << chars[3];
		//
		// output << "WAVE";
		// output << "fmt ";
		//
		// *(int*)chars = 16;
		// output << chars[ENDIAN0] << chars[ENDIAN1] << chars[ENDIAN2] <<
		// chars[ENDIAN3];
		//
		// *(short*)chars = 1;
		// output << chars[ENDIAN0_S] << chars[ENDIAN1_S];
		//
		// *(short*)chars = CHANNELS;
		// output << chars[ENDIAN0_S] << chars[ENDIAN1_S];
		//
		// *(int*)chars = SAMPLERATE;
		// output << chars[ENDIAN0] << chars[ENDIAN1] << chars[ENDIAN2] <<
		// chars[ENDIAN3];
		//
		// *(int*)chars = (int)(SAMPLERATE*(BITSPERSAMPLE/8*CHANNELS));
		// output << chars[ENDIAN0] << chars[ENDIAN1] << chars[ENDIAN2] <<
		// chars[ENDIAN3];
		//
		// *(short*)chars = (short)(BITSPERSAMPLE/8*CHANNELS);
		// output << chars[ENDIAN0_S] << chars[ENDIAN1_S];
		//
		// *(short*)chars = (short)BITSPERSAMPLE;
		// output << chars[ENDIAN0_S] << chars[ENDIAN1_S];
		//
		// output << "data";
		// *(int*)chars = 0;
		// output << chars[0] << chars[1] << chars[2] << chars[3];
	}

	private void writeString(OutputStream out, String value) throws IOException {
		out.write(value.getBytes());
	}

	private void writeInt(OutputStream out, int value) throws IOException {
		byte[] buffer = new byte[4];
		buffer[0] = (byte) (value & 0xff);
		buffer[1] = (byte) ((value >> 8) & 0xff);
		buffer[2] = (byte) ((value >> 16) & 0xff);
		buffer[3] = (byte) ((value >> 24) & 0xff);
		out.write(buffer);
	}

	private void writeShort(OutputStream out, int value) throws IOException {
		byte[] buffer = new byte[2];
		buffer[0] = (byte) (value & 0xff);
		buffer[1] = (byte) ((value >> 8) & 0xff);
		out.write(buffer);
	}
}
