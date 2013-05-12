package uk.co.acornatom.tape;
import java.io.File;
import java.io.IOException;

public class AtomTape extends AtomBase {

	public static final String HDR = "----------------";
	byte[] tape;
	int idx;
	File tapeFile;
	File dest;
	
	public AtomTape(File file, File dest) throws IOException {
		super(dest);
		this.tapeFile = file;
		this.tape = read(file);
		this.idx = 0;
		this.dest = dest;
	}
	
	public String toString() {
		return tapeFile + " -> " + dest;
	}


	@Override
	protected void processArchive() throws IOException {
		while (idx < tape.length) {
			AtomFile file = processATMfile();
			getFiles().add(file);
		}
	}

	private AtomFile processATMfile() throws IOException {
		String title = getString(0x00, 16, true);
		int loadAddr = getWord();
		int execAddr = getWord();
		int len = getWord();
		byte[] data = new byte[len];
		for (int i = 0; i < len; i++) {
			data[i] = (byte) getByte();
		}
		return new AtomFile(dest.getName(), title, loadAddr, execAddr, data);
	}

	class CorruptedException extends IOException {
		private static final long serialVersionUID = 6236778406954962435L;

		public CorruptedException(String m) {
			super(m + " at index 0x" + Integer.toHexString(idx));
		}
	}

	private int getByte() throws IOException {
		if (idx < tape.length) {
			return tape[idx++] & 0xff;
		}
		throw new IOException("Read off end of file");
	}

	private int getWord() throws IOException {
		return getByte() + (getByte() << 8);
	}

	private String getString(int terminator, int maxLength, boolean padded)
			throws IOException {
		StringBuffer sb = new StringBuffer();
		int i = 0;
		do {
			int c = getByte();
			i++;
			if (c == terminator) {
				break;
			} else if (c >= 0x20 && c <= 0x7e || c == 0x09) {
				sb.append((char) c);
			} else {
				sb.append('#');
				// throw new CorruptedException("Non ASCII character " + c);
			}
		} while (i < maxLength);
		if (padded) {
			idx += maxLength - i;
		}
		return sb.toString();
	}

}
