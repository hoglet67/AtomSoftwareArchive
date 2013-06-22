package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

abstract public class GenerateBase implements IFileGenerator {

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
	
	public byte[] readATMFile(File file) throws IOException {
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
	    byte[] fileWithoutAtmHeader = new byte[fileWithAtmHeader.length - 22];
	    System.arraycopy(fileWithAtmHeader, 22, fileWithoutAtmHeader, 0, fileWithoutAtmHeader.length);
	    return fileWithoutAtmHeader;
	}
	
			
	protected void writeString(OutputStream out, String value) throws IOException {
		out.write(value.getBytes());
	}

	protected void writeInt(OutputStream out, int value) throws IOException {
		byte[] buffer = new byte[4];
		buffer[0] = (byte) (value & 0xff);
		buffer[1] = (byte) ((value >> 8) & 0xff);
		buffer[2] = (byte) ((value >> 16) & 0xff);
		buffer[3] = (byte) ((value >> 24) & 0xff);
		out.write(buffer);
	}

	protected void writeShort(OutputStream out, int value) throws IOException {
		byte[] buffer = new byte[2];
		buffer[0] = (byte) (value & 0xff);
		buffer[1] = (byte) ((value >> 8) & 0xff);
		out.write(buffer);
	}
	
	protected void writeByte(OutputStream out, int value) throws IOException {
		byte[] buffer = new byte[1];
		buffer[0] = (byte) (value & 0xff);
		out.write(buffer);
	}

}
