package uk.co.acornatom.partition;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class ArcPartition {



	public ArcPartition() {
	}

	private void writeString(byte[] bootSector, int offset, String value) {
		byte[] bytes = value.getBytes();
		for (int i = 0; i < bytes.length; i++) {
			bootSector[offset + i] = bytes[i];
		}
	}
	private void write32(byte[] bootSector, int offset, int value) {
		bootSector[offset] =(byte) (value & 0xff); 
		bootSector[offset + 1 ] = (byte) ((value >> 8) & 0xff);
		bootSector[offset + 2 ] = (byte) ((value >> 16) & 0xff);
		bootSector[offset + 3 ] = (byte) ((value >> 24) & 0xff);
	}
	private void createPartition(byte[] bootSector, int i, int startSecs, int lengthSecs, String type) {
		int offset = 8 + i * 28;
		write32(bootSector, offset, startSecs);
		write32(bootSector, offset + 4, lengthSecs);
		writeString(bootSector, offset + 12, type);
	}
	private void createPowerIDEPartitionTable(File partitionTableFile, int[] partitionSizeSecs) throws IOException {
		byte[] bootSector = new byte[512];
		// Zero the boot Sector
		for (int i = 0; i < 512; i++) {
			bootSector[i] = 0;
		}
		// Compute the boot block checksum
		int sec = 0;
		for (int i = 0; i < partitionSizeSecs.length; i++) {
			createPartition(bootSector, i, sec, partitionSizeSecs[i], "RiscOs:");
			sec += partitionSizeSecs[i];
		}
		// Compute the boot block checksum
		int csum = 42;
		for (int i = 0; i < 0x1ff; i++) {
			csum = (csum + bootSector[i]) & 255;
		}
		bootSector[0x1ff] = (byte) csum;

		FileOutputStream fos = new FileOutputStream(partitionTableFile);
		fos.write(bootSector);
		fos.close();
	}

	public static final void main(String[] args) {
		try {
			if (args.length < 2) {
				System.err.println("usage: java -jar arcpartition.jar <partition table> <p0 size> <p1 size> ...");
				System.err.println("usage: partition sizes in 512b sectors");
				System.exit(1);
			}
			if (args.length > 9) {
				System.err.println("usage: maxiumum of 8 partitions is supported by PowerIDE");
				System.exit(1);
			}
			
			File partitionTableFile = new File(args[0]);
			int[] partitionSizes = new int[args.length - 1];
			for (int i = 1; i < args.length - 1; i++) {
				partitionSizes[i - 1] = Integer.parseInt(args[i]);
			}
			ArcPartition c = new ArcPartition();
			c.createPowerIDEPartitionTable(partitionTableFile, partitionSizes);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
