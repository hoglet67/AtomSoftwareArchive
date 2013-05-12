import java.io.File;
import java.io.IOException;

public class AtomAtom1 extends AtomBase {

	File atom1File;
	File dest;
	
	public String toString() {
		return atom1File + " -> " + dest;
	}

	public AtomAtom1(File atom1File, File dest) throws IOException {
		super(dest);
		this.atom1File = atom1File;
		this.dest = dest;
		if (!atom1File.exists()) {
			throw new IOException("Missing " + atom1File);
		}
	}

	@Override
	protected void processArchive() throws IOException {

		if (atom1File.length() < 16) {
			throw new IOException("Short file: " + atom1File);
		}

		String title = atom1File.getName();
		title = title.substring(0, title.lastIndexOf('.'));
		title = title.toUpperCase();
		
		byte[] atom1 = read(atom1File);
				
		int loadAddr = (atom1[0] & 0xff) + ((atom1[1] & 0xff) << 8); 

		int execAddr = (atom1[2] & 0xff) + ((atom1[3] & 0xff) << 8); 

		byte[] data = new byte[atom1.length - 16];
		for (int i = 0; i < data.length; i++) {
			data[i] = atom1[16 + i];
		}
		
		AtomFile file = new AtomFile(dest.getName(), title, loadAddr, execAddr, data);
		
		getFiles().add(file);
	}


}
