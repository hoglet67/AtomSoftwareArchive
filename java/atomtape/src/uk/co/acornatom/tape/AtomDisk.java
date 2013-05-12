package uk.co.acornatom.tape;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class AtomDisk extends AtomBase {

	public static final String HDR = "----------------";
	byte[] disk;
	int idx;
	File diskFile;
	File dest;
	
	public AtomDisk(File file, File dest) throws IOException {
		super(dest);
		this.diskFile = file;
		this.disk = read(file);
		this.idx = 0;
		this.dest = dest;
	}
	
	public String toString() {
		return diskFile + " -> " + dest;
	}


	@Override
	protected void processArchive() throws IOException {
		
//		000000 43 48 45 53 53 20 20 20 43 48 45 53 53 31 20 a0
//		000010 43 48 45 53 53 32 20 a0 06 0a 50 41 52 54 20 20
//		000020 43 48 45 53 53 20 20 a0 43 4f 53 20 49 49 20 20
//		000030 43 4f 53 20 49 49 20 20 43 4f 53 20 49 49 20 20
//		*
//		0000b0 43 4f 53 20 49 49 20 20 43 4f 50 59 20 20 20 20
//		0000c0 42 4f 4f 54 59 20 20 20 42 4e 59 45 44 49 54 20
//		0000d0 42 41 53 49 4c 20 20 20 41 44 45 20 20 20 20 20
//		0000e0 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04
//		*
//		000100 20 20 20 20 20 20 01 90 00 28 8a 37 ff 13 00 1a
//		000110 00 90 00 90 00 08 00 12 00 29 ba 93 ff 0e 00 03
//		000120 00 29 b2 c2 2c 00 00 02 00 28 3b 2f 00 08 00 35
//		000130 00 28 3b 2f 00 08 00 35 00 28 3b 2f 00 08 00 35
//		*
//		0001b0 00 28 3b 2f 00 08 00 35 00 28 00 28 45 01 00 33
//		0001c0 00 29 b2 c2 45 00 00 32 00 d0 00 d0 00 10 00 22
//		0001d0 00 c0 b2 c2 00 10 00 12 00 c0 00 c0 00 10 00 02
//		0001e0 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04
//		*
//		000200 0d 00 0a 20 2a 4c 4f 41 44 22 43 48 45 53 53 32
//		000210 22 39 30 30 30 0d 00 14 20 2a 52 55 4e 22 43 48
//		000220 45 53 53 31 22 0d 00 1e 45 2e 0d ff d0 4f 56 45
//		000230 32 32 2c 39 33 3b 44 52 41 57 31 30 35 2c 39 33
//		000240 3b 44 52 41 57 31 30 35 2c 31 30 3b 44 52 41 57
//		000250 32 32 2c 31 30 0d 00 14 44 52 41 57 32 32 2c 39
//		000260 33 3b 4c 49 2e 23 33 37 37 30 0d 00 1e 2a 53 2e
//		000270 20 20 22 44 41 54 41 22 38 32 30 30 20 39 38 30
		
		
		
		
		
		int numFiles = getByte(1, 5) >> 3;
		
		for (int i = 1; i <= numFiles; i++) {

			char dirch = (char) (disk[i * 8 + 7] & 0x7f);
			String dir = dirch == ' ' ? "" : dirch + ".";
			
			String title = dir + new String(disk, i * 8, 7).trim();
			
			int loadAddr = getByte(1, i * 8) + (getByte(1, i * 8 + 1) << 8) + (((getByte(1, i * 8 + 6) >> 2) & 3) << 16);
			int execAddr = getByte(1, i * 8 + 2) + (getByte(1, i * 8 + 3) << 8) + (((getByte(1, i * 8 + 6) >> 6) & 3) << 16);
			int len = getByte(1, i * 8 + 4) + (getByte(1, i * 8 + 5) << 8) + (((getByte(1, i * 8 + 6) >> 4) & 3) << 16);
			int startSector = getByte(1, i * 8 + 7) + ((getByte(1, i * 8 + 6) & 3) << 8); 

			byte[] data = new byte[len];
//			System.out.println(title);
//			System.out.println(Integer.toHexString(loadAddr));
//			System.out.println(Integer.toHexString(execAddr));
//			System.out.println(Integer.toHexString(len));
//			System.out.println(startSector);

			if ((startSector << 8) + len > disk.length) {
				throw new IOException("Truncated disk");
			}
			
			for (int j = 0; j < len; j++) {
				data[j] = disk[(startSector << 8) + j];
			}
			AtomFile file = new AtomFile(dest.getName(), title, loadAddr, execAddr, data);
//			System.out.println(file.toString());
			getFiles().add(file);
		}
			
			
	}

	private int getByte(int sector, int i) throws IOException {
		return disk[sector * 256 + i] & 0xff;
	}

	
	


}
