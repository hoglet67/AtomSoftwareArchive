package uk.co.acornatom.menu;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import org.apache.commons.codec.binary.Base64;

public class GenerateSDDOSFiles extends GenerateBase {

	public static final int NUM_TRACKS = 40;
	public static final int NUM_SECS_PER_TRACK = 10;
	public static final int NUM_SECS = NUM_TRACKS * NUM_SECS_PER_TRACK;
	public static final int SEC_SIZE = 256;

	public static final int SD_SEC_SIZE = 512;
	public static final int SD_NUM_SECS = 204632;

	public static final int SDCARD_SIZE = SD_NUM_SECS * SD_SEC_SIZE;

	private int sectorNum;

	private File sdImageFile;
	private File jsImageFile;
	private PrintWriter JSwriter;
	private byte[] SDimage;
	private File archiveDir;
	private String menuBase;
	private int numChunks;
	
	public GenerateSDDOSFiles(File archiveDir, File sdImageFile, File jsImageFile, String menuBase, int numChunks) throws IOException {
		this.archiveDir = archiveDir;
		this.sdImageFile = sdImageFile;
		this.jsImageFile = jsImageFile;
		this.menuBase = menuBase;
		this.numChunks = numChunks;
		createJSImage();
		createSDImage();
	}

	// ;=================================================================
	// ; SD-CARD:
	// ;=================================================================
	// ; The format of the SD-card is:
	// ;
	// ; sector Description
	// ;------------------------------------------------------
	// ; 0 - 31 DISKTABLE + DISK INFORMATION TABLE
	// ; 32 - 231 DISK IMAGE 0000
	// ; 232 - 463 DISK IMAGE 0001
	// ; .. .. ..
	// ; .. .. ..
	// ; 104432 - 204631 DISK IMAGE 1022
	// ;
	// ;------------------------------------------------------
	// ; DISKTABLE (16 bytes)
	// ;------------------------------------------------------
	// ; 0,1 - Current diskette number in drive 0
	// ; 2,3 - Current diskette number in drive 1
	// ; 4,5 - Current diskette number in drive 2
	// ; 6,7 - Current diskette number in drive 3
	// ; 8-F - Unused
	// ;------------------------------------------------------
	// ;
	// ;------------------------------------------------------
	// ; DISKINFO TABLE (1023 * 16 bytes)
	// ;------------------------------------------------------
	// ; 0-C - Diskname
	// ; D,E - Unused
	// ; F - Diskette Status 00 = Read Only
	// ; 0F = R/W
	// ; F0 = Unformatted
	// ; FF = No valid diskno.
	// ;------------------------------------------------------

	int[] diskTable = {
			0, 0, 1, 0, 2, 0, 3, 0, 'S', 'D', 'D', 'O', 'S', ' ', ' ', ' '
	};
	
	private void createSDImage() throws IOException {
		byte[] SDimage = new byte[SDCARD_SIZE];
		Arrays.fill(SDimage, (byte) 0xFF);
		for (int i = 0; i < diskTable.length; i++) {
			SDimage[i] = (byte) diskTable[i];
		}
		this.SDimage = SDimage;
		createMenuDisk();
	}
	
	private void createJSImage() throws IOException {
		JSwriter = new PrintWriter(jsImageFile);
		JSwriter.println("var");
		JSwriter.println("aDisks =");
		JSwriter.println("[");
	}

	private int getImageLen(byte[] image) {
		int lastUsedSector = -1;
		for (int i = 0; i < 31; i++) {
			int dir = 256 + (i << 3) + 8;
			int file_start_sec = (image[7 + dir] & 0xff) + ((image[6 + dir] & 0x03) << 8);
			int file_len = (image[4 + dir] & 0xff) + ((image[5 + dir] & 0xff) << 8) + ((image[6 + dir] & 0x30) << 12);
			int file_end_sec = file_start_sec + (file_len >> 8);
			System.out.println(i + " = " + file_start_sec + " " + file_len + " " + file_end_sec);
			if (file_end_sec > lastUsedSector)
				lastUsedSector = file_end_sec;
			
		}
		return (lastUsedSector + 1) << 8;
	}
	
	private void addDisk(byte[] image, int diskNum) {
		// *** RAW SD IMAGE FILE ***
		// Copy the disk title
		for (int i = 0; i < 13; i++) {
			SDimage[16 + diskNum * 16 + i] = image[i < 8 ? i : i + 248];
		}
		// Unused
		SDimage[16 + diskNum * 16 + 13] = (byte) 0x88;
		SDimage[16 + diskNum * 16 + 14] = (byte) 0x88;
		// Set the Diskette Status to R/W
		SDimage[16 + diskNum * 16 + 15] = 15;
		// Copy the disk data
		System.arraycopy(image, 0, SDimage, SD_SEC_SIZE * (32 + diskNum * 200), image.length);
		// *** JS IMAGE FILE ***
		if (diskNum > 0) {			
			JSwriter.println(",");				
		}
		int len = getImageLen(image);
		byte[] strippedImage = new byte[len];
		System.arraycopy(image, 0, strippedImage, 0, len);
		JSwriter.print("fDiskRead(\"" + diskNum + "\", D64(\"");
		JSwriter.print(Base64.encodeBase64String(strippedImage));
		JSwriter.print("\"))");		
	}
	
	public void writeSDImage() throws IOException {
		System.out.println("Writing SDDOS SD Card Image: " + sdImageFile);
		FileOutputStream fos = new FileOutputStream(sdImageFile);
		fos.write(SDimage);
		fos.close();		
		JSwriter.println("]");
		JSwriter.close();
	}
	
	public byte[] createBlankDiskImage(String title) {
		byte[] image = new byte[SEC_SIZE * NUM_SECS];
		Arrays.fill(image, (byte) 0);
		// Prepare a 13 character title (padded with spaces)
		if (title.length() > 13) {
			title = title.substring(0, 13);
		}
		for (int i = title.length(); i < 13; i++) {
			title += " ";
		}
		for (int i = 0; i < 13; i++) {
			image[i < 8 ? i : i - 8 + 256] = (byte) title.charAt(i);
		}
		// Write the number of sectors
		image[0x106] = (byte) ((NUM_SECS >> 8) & 0xff);
		image[0x107] = (byte) (NUM_SECS & 0xff);
		// Point to the first free sector
		sectorNum = 2;
		return image;
	}

	public void addFile(byte[] image, ATMFile atmFile) {
		int filePtr = image[0x105] & 0xFF;

		filePtr += 8;
		if (filePtr > 255) {
			throw new RuntimeException("Too many files in title: " + atmFile.getTitle());
		}
		image[0x105] = (byte) filePtr;

		// Move all the files down to make room
		for (int i = filePtr + 7; i >= 16; i--) {
			image[i] = image[i - 8];
			image[i + 0x100] = image[i + 0x100 - 8];
		}
		
		// Always the new file in the first position
		filePtr = 8;
		
		String filename = atmFile.getTitle();
		if (filename.length() > 7) {
			throw new RuntimeException("Filename too long: " + filename);
		}
		for (int i = filename.length(); i < 7; i++) {
			filename += " ";
		}
		for (int i = 0; i < 7; i++) {
			image[filePtr + i] = (byte) filename.charAt(i);
		}

		// This is the file qualifier (a one character directory)
		// Bit 7 set if the file is locked
		image[filePtr + 7] = 32;

		image[filePtr + 0x100] = (byte) (atmFile.getLoadAddr() & 0xff);
		image[filePtr + 0x101] = (byte) ((atmFile.getLoadAddr() >> 8) & 0xff);
		image[filePtr + 0x102] = (byte) (atmFile.getExecAddr() & 0xff);
		image[filePtr + 0x103] = (byte) ((atmFile.getExecAddr() >> 8) & 0xff);
		image[filePtr + 0x104] = (byte) (atmFile.getLength() & 0xff);
		image[filePtr + 0x105] = (byte) ((atmFile.getLength() >> 8) & 0xff);
		image[filePtr + 0x106] = (byte) (((atmFile.getLength() >> 12) & 0xf0) | ((sectorNum >> 8) & 0x0f));
		image[filePtr + 0x107] = (byte) (sectorNum & 0xff);

		int lengthInSecs = (atmFile.getLength() + 255) / SEC_SIZE;

		if (sectorNum + lengthInSecs >= NUM_SECS) {
			throw new RuntimeException("Disk full is title: " + atmFile.getTitle());
		}
		System.arraycopy(atmFile.getData(), 0, image, sectorNum * SEC_SIZE, atmFile.getLength());
		sectorNum += lengthInSecs;

	}
	
	// Original AtomMMC Names
	public static String[] ATOMMC_MENU_FILES = { "MENUDAT1", "MENUDAT2", "SORTDAT0", "SORTDAT1", "SORTDAT2", "SORTDAT3" };
	
	// Shorter SDDOS names
	public static String[] SDDOS_MENU_FILES = { "MENU1", "MENU2", "SORT0", "SORT1", "SORT2", "SORT3" };
	
	public void createMenuDisk() throws IOException {
	    //Disk 0 is just the menu disk
		byte[] image = createBlankDiskImage("MENU");
		ATMFile menuFile = new ATMFile(new File(archiveDir, "MENUSD"));
		ATMFile helpFile = new ATMFile(new File(archiveDir, "HELP"));
		ATMFile splashFile = new ATMFile(new File(archiveDir, "MNUA" + File.separator + "SPLASH"));
		menuFile.setTitle("MENU");
		addFile(image, menuFile);
		addFile(image, splashFile);
		writeImage(new File("disks/0"), image);
		addDisk(image, 0);
		// Disk 1016-1023 are the chapters
		if (numChunks > 8) {
			throw new RuntimeException("Too many menu chunks");
		}
		for (int chunk = 0; chunk < numChunks; chunk++) {
			char chunkLetter = (char) ('A' + chunk);
			byte[] chunkImage = createBlankDiskImage("MENU" + chunkLetter);
			for (int i = 0; i < ATOMMC_MENU_FILES.length; i++) {
				ATMFile atmFile = new ATMFile(new File(new File(archiveDir, menuBase + chunkLetter), ATOMMC_MENU_FILES[i]));
				atmFile.setTitle(SDDOS_MENU_FILES[i]);
				addFile(chunkImage, atmFile);
 	 		}
			addFile(chunkImage, helpFile);
			int num = 1016 + chunk;
			writeImage(new File("disks/" + num), chunkImage);
			addDisk(chunkImage, num);
 		}
	}

	public void generateFiles(List<SpreadsheetTitle> items)
			throws IOException {
		

		for (SpreadsheetTitle item : items) {
			try {
				if (item.isPresent()) {
					System.out.println(item.getTitle());
					byte[] image = createBlankDiskImage(item.getTitle());
	
					File bootfile = new File(new File(archiveDir, menuBase + item.getChunk().substring(0, 1)), "" + item.getIndex());
					ATMFile bootAtmFile = new ATMFile(bootfile);
					bootAtmFile.setTitle("MENU");
					addFile(image, bootAtmFile);
					
					for (String filename : item.getFilenames()) {
						System.out.println("    >" + filename + "<");
						File file = new File(new File(archiveDir, item.getDir()), filename);
						ATMFile atmFile = new ATMFile(file);
						// Some of the ATM files still contain the original long tape titles
						if (filename.length() > 7) {
							filename = filename.substring(0, 7);
						}
						atmFile.setTitle(filename);
						addFile(image, atmFile);
					}
					System.out.println("Writing disk " + item.getIndex());
					writeImage(new File("disks/" + item.getIndex()), image);
					addDisk(image, item.getIndex());				
				}
			} catch (Exception e) {
				System.out.println("Problem SDDOS files for title " + item.getTitle());
				e.printStackTrace();
			}
		}
	}
	
	public void writeImage(File file, byte[] image) throws IOException {
		System.out.println("Writing DSK Image: " + file);
		FileOutputStream fos = new FileOutputStream(file);
		fos.write(image);
		fos.close();		
	}
	

}
