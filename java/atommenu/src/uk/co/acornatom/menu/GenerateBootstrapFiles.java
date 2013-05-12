package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import au.com.bytecode.opencsv.CSVReader;

public class GenerateBootstrapFiles extends GenerateBase {

	private static final int CMD_UPDATE_TOP_AND_RUN = 0;
	private static final int CMD_RUN_ONLY = 1;
	private static final int CMD_RETURN = 2;
	private static final int CMD_PAGE = 3;

	private static final int[] bootLoader = { 0x78, 0x20, 0x37, 0xff, 0xba, 0xca, 0x18, 0xbd, 0x00, 0x01, 0x69, 0x7c, 0x85, 0x80,
			0xbd, 0x01, 0x01, 0x69, 0x00, 0x85, 0x81, 0x58, 0xa0, 0x00, 0xb1, 0x80, 0xf0, 0x2e, 0xc9, 0x01, 0xf0, 0x48, 0xc9, 0x02,
			0xf0, 0x25, 0xc9, 0x03, 0xf0, 0x19, 0xa2, 0x00, 0xb1, 0x80, 0x9d, 0x00, 0x01, 0xc8, 0xe8, 0xc9, 0x0d, 0xd0, 0xf5, 0x9d,
			0x00, 0x01, 0x98, 0x48, 0x20, 0xf7, 0xff, 0x68, 0xa8, 0xd0, 0xd7, 0xc8, 0xb1, 0x80, 0x85, 0x12, 0xc8, 0xd0, 0xcf, 0x60,
			0xa5, 0x12, 0x85, 0x0e, 0xa0, 0x00, 0x84, 0x0d, 0x88, 0xc8, 0xb1, 0x0d, 0xc9, 0x0d, 0xd0, 0xf9, 0x20, 0xbc, 0xcd, 0xb1,
			0x0d, 0x30, 0x03, 0xc8, 0xd0, 0xef, 0xc8, 0x20, 0xbc, 0xcd, 0xa9, 0x52, 0x8d, 0x00, 0x01, 0xa9, 0x55, 0x8d, 0x01, 0x01,
			0xa9, 0x4e, 0x8d, 0x02, 0x01, 0xa9, 0x0d, 0x8d, 0x03, 0x01, 0x4c, 0xd5, 0xc2 };

	private void writeBasicLine(OutputStream bos, int lineNum, String cmd) throws IOException {
		bos.write(13);
		bos.write(lineNum % 256);
		bos.write(lineNum / 256);
		bos.write(32);
		bos.write(cmd.getBytes());
	}

	private void generateBasicBootstrap(File menuDir, String index, String directory, String run) throws IOException {

		ByteArrayOutputStream bos = new ByteArrayOutputStream();

		String[] cmds = run.split("\n");
		int lineNum = 10;
		writeBasicLine(bos, lineNum, "*CWD " + directory);
		for (String cmd : cmds) {
			cmd = cmd.trim();
			System.out.println(">>" + cmd + "<<");
			writeBasicLine(bos, lineNum, cmd);
			lineNum += 10;
		}
		bos.write(255);
	}

	private void generateMachineCodeBootstrap(File menuDir, int index, String directory, String run, String boot)
			throws IOException {

		int loadAddr = Integer.parseInt(boot, 16);
		int execAddr = loadAddr;

		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		for (int b : bootLoader) {
			bos.write((byte) (b & 0xff));
		}
		bos.write(("CWD " + directory).getBytes());
		bos.write((byte) 13);
		String[] cmds = run.split("\n");
		for (String cmd : cmds) {
			cmd = cmd.trim();
			System.out.println(">>" + cmd + "<<");
			if (cmd.equals("RUN")) {
				bos.write((byte) 0);
			} else if (cmd.startsWith("CH.")) {
				bos.write(("LOAD " + cmd.split("\"")[1]).getBytes());
				bos.write((byte) 13);
				bos.write((byte) 0);
			} else if (cmd.startsWith("?18=")) {
				int page = Integer.parseInt(cmd.split("=")[1]);
				bos.write(CMD_PAGE);
				bos.write(page);
			} else if (cmd.startsWith("*LOAD") || cmd.startsWith("*RUN")) {
				cmd = cmd.substring(1);
				bos.write(cmd.getBytes());
				bos.write((byte) 13);
			} else {
				throw new RuntimeException("Illegal command " + cmd + " in title " + index);
			}
		}

		FileOutputStream fos = new FileOutputStream(new File(menuDir, "" + index));
		writeATMFile(fos, "" + index, loadAddr, execAddr, bos.toByteArray());
		fos.close();

	}

	public void generateFiles(File menuDir, List<SpreadsheetTitle> items) throws IOException {
		for (SpreadsheetTitle item : items) {
			if (item.isPresent()) {
				generateMachineCodeBootstrap(menuDir, item.getIndex(), item.getDir(), item.getRun(), item.getBoot());
			}
		}
	}
}
