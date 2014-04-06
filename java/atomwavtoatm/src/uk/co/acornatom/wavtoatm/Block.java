package uk.co.acornatom.wavtoatm;

import java.util.Arrays;
import java.util.Collection;

public class Block {

	public static final int BLOCK_NUM_MAX = 0x1f;

	public enum Field {
		FLAG,
		LOADADDR,
		EXECADDR,
		LEN,
		CHECKSUM
	}
	
	private String fileName;
	private int flag;
	private int num;
	private int loadAddr;
	private int execAddr;
	private int len;
	private byte[] bytes;
	private int checksum;

	private boolean checkSumValid;
	
	public int getField(Field field) {
		switch (field) {
		case FLAG:
			return flag;
		case LOADADDR:
			return loadAddr;
		case EXECADDR:
			return execAddr;
		case LEN:
			return len;
		case CHECKSUM:
			return checksum;
		default:
			return -1;
		}
	}

	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (!(obj instanceof Block)) {
			return false;
		}
		Block that = (Block) obj;
		if (checksum != that.checksum) {
			return false;
		}
		if (flag != that.flag) {
			return false;
		}
		if (num != that.num) {
			return false;
		}
		if (len != that.len) {
			return false;
		}
		if (loadAddr != that.loadAddr) {
			return false;
		}
		if (execAddr != that.execAddr) {
			return false;
		}
		if (!(fileName == that.fileName || (fileName != null && fileName.equals(that.fileName)))) {
			return false;
		}
		return Arrays.equals(bytes, that.bytes);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 1;
		hash = prime * (fileName != null ? fileName.hashCode() : 1);
		hash = prime * hash + checksum;
		hash = prime * hash + flag;
		hash = prime * hash + num;
		hash = prime * hash + len;
		hash = prime * hash + loadAddr;
		hash = prime * hash + execAddr;
		if (bytes != null) {
			for (byte b : bytes) {
				hash = prime * hash + b;
			}
		}
		return hash;
	}

	public String toString() {
		return cleanFilename(fileName) + " "  + toHex4(num) + " " + toHex2(flag) + " " + toHex4(len) + " " + toHex4(loadAddr)
				+ " " + toHex4(execAddr) + " " + toHex2(checksum) + " " + checkSumValid;
	}

	public static String cleanFilenames(Collection<FileSelector> fileNames) {
		boolean first = true;
		StringBuffer sb = new StringBuffer();
		sb.append('[');
		for (FileSelector fileName : fileNames) {
			if (!first) {
				sb.append(", ");
			}
			sb.append(fileName.toString());
			first = false;
		}
		sb.append(']');
		return sb.toString();
	}
	
	public static String cleanFilename(String fileName) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < fileName.length(); i++) {
			int c = fileName.charAt(i);
			if (c < 32 || c > 126) {
				sb.append('?');
			} else {
				sb.append((char) c);
			}
		}
		return sb.toString();
	}

	public static String toHex2(int i) {
		String pad = "";
		if (i < 16) {
			pad = "0";
		}
		return pad + Integer.toString(i, 16);
	}

	public static String toHex4(int i) {
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

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public boolean isFileNameValid() {
		for (int i = 0; i < fileName.length(); i++) {
			if (fileName.charAt(i) > 126) {
				return false;
			}
		}
		return true;
	}


	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getLoadAddr() {
		return loadAddr;
	}

	public void setLoadAddr(int loadAddr) {
		this.loadAddr = loadAddr;
	}

	public int getExecAddr() {
		return execAddr;
	}

	public void setExecAddr(int execAddr) {
		this.execAddr = execAddr;
	}

	public byte[] getBytes() {
		return bytes;
	}

	public void setBytes(byte[] bytes) {
		this.bytes = bytes;
	}

	public int getChecksum() {
		return checksum;
	}

	public void setChecksum(int checksum) {
		this.checksum = checksum;
	}

	public boolean isCheckSumValid() {
		return checkSumValid;
	}

	public void setChecksumValid(boolean checkSumValid) {
		this.checkSumValid = checkSumValid;
	}

	public int getLen() {
		return len;
	}

	public void setLen(int len) {
		this.len = len;
	}
	
	public void updateChecksumValid() {
		if (bytes.length != len) {
			System.out.println("@@@ " + cleanFilename(fileName) + " " + toHex4(num) + " invalid number of bytes: expected " + len + " actual " + bytes.length);
			checkSumValid = false;
		} else {
			int csum = 0xa8; // Sum of ****
			for (int i = 0; i < fileName.length(); i++) {
				csum += fileName.charAt(i);
			}
			csum += 13;
			csum += flag;
			csum += loadAddr & 0xff;
			csum += (loadAddr >> 8) & 0xff;
			csum += execAddr & 0xff;
			csum += (execAddr >> 8) & 0xff;
			csum += num & 0xff;
			csum += (num >> 8) & 0xff;
			csum += len - 1;
			for (byte b : bytes) {
				csum += (int) b;
			}
			csum &= 0xff;
			checkSumValid = checksum == csum;
			if (!checkSumValid) {
				System.out.println("@@@ " + cleanFilename(fileName) + " " + toHex4(num) + " checksum mis-match: old cksum = " + toHex2(checksum) + "; new checksum = " + toHex2(csum));}
			
		}
	}
	
	public FileSelector getSelector() {
		return new FileSelector(this);
	}
	

}
