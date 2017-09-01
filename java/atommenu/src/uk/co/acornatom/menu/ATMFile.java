package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class ATMFile {
	
	private byte[] data;
	private int loadAddr;
	private int execAddr;
	private String title;
	
	public ATMFile(String title, int loadAddr, int execAddr, byte[] data) {
		this.title = title;
		this.loadAddr = loadAddr;
		this.execAddr = execAddr;
		this.data = data;
	}
	
	public ATMFile(File file) throws IOException {
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
	    byte[] fileWithAtmHeader = ous.toByteArray();
	    title = "";
	    for (int i = 0; i < 16; i++) {
	    	if (fileWithAtmHeader[i] != 0) {
	    		title += (char) fileWithAtmHeader[i];
	    	}
	    }
	    loadAddr = readShort(fileWithAtmHeader, 16);
	    execAddr = readShort(fileWithAtmHeader, 18);
	    int length = readShort(fileWithAtmHeader, 20);;
	    if (length != fileWithAtmHeader.length - 22) {
          System.out.printf("WARNING: Length mismatch in ATM file: expected = " + length + "; actual = " + (fileWithAtmHeader.length - 22));
          length = fileWithAtmHeader.length - 22; 
	    }
	    data = new byte[length];
	    System.arraycopy(fileWithAtmHeader, 22, data, 0, length);
	    System.out.println(title + " " + Integer.toHexString(loadAddr) + " " + Integer.toHexString(execAddr) + " " + Integer.toHexString(length));
	}
	
	public byte[] getData() {
		return data;
	}
	public int getLoadAddr() {
		return loadAddr;
	}
	public int getExecAddr() {
		return execAddr;
	}
	public int getLength() {
		return data.length;
	}
	public void setExec(int exec) {
		this.execAddr = exec;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
			
	public static void writeString(OutputStream out, String value) throws IOException {
		out.write(value.getBytes());
	}

	public static  void writeInt(OutputStream out, int value) throws IOException {
		byte[] buffer = new byte[4];
		buffer[0] = (byte) (value & 0xff);
		buffer[1] = (byte) ((value >> 8) & 0xff);
		buffer[2] = (byte) ((value >> 16) & 0xff);
		buffer[3] = (byte) ((value >> 24) & 0xff);
		out.write(buffer);
	}

	public static  void writeShort(OutputStream out, int value) throws IOException {
		byte[] buffer = new byte[2];
		buffer[0] = (byte) (value & 0xff);
		buffer[1] = (byte) ((value >> 8) & 0xff);
		out.write(buffer);
	}

	public static int readShort(byte[] buffer, int offset) throws IOException {
		return ((buffer[offset + 1] & 0xFF) << 8) | (buffer[offset] & 0xFF);
	}

	
	public static  void writeByte(OutputStream out, int value) throws IOException {
		byte[] buffer = new byte[1];
		buffer[0] = (byte) (value & 0xff);
		out.write(buffer);
	}
	


}
