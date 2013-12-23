package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

public class GenerateBootstrapFiles extends GenerateBase {

	public static final int CMD_UPDATE_TOP_AND_RUN = 0;
	public static final int CMD_RUN_ONLY = 1;
	public static final int CMD_RETURN = 2;
	public static final int CMD_PAGE = 3;
	public static final int CMD_DIRECT = 4;
	public static final int CMD_PRINT = 5;
		
	private File menuDir;
	private File bootLoaderBinary;
	private File romBootLoaderBinary;
	private boolean sddos;
	
	
	public GenerateBootstrapFiles(File menuDir, File bootLoaderBinary, File romBootLoaderBinary, boolean sddos) {
		this.menuDir = menuDir;
		this.bootLoaderBinary = bootLoaderBinary;
		this.romBootLoaderBinary = romBootLoaderBinary;
		this.sddos = sddos;
	}
	
	private void generateMachineCodeBootstrap(int index, String directory, String run, String boot, boolean rom)
			throws IOException {

		int loadAddr = Integer.parseInt(boot, 16);
		int execAddr = loadAddr;

		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		FileInputStream fis = new FileInputStream(rom ? romBootLoaderBinary : bootLoaderBinary);
		int b;
		while((b = fis.read()) != -1) {
		    bos.write(b);
		}
		fis.close();
		if (!sddos) {
			// Break long directory paths into separate CWD commands to avoid hitting the 13 char limit to *CWD
			if (directory.length() > 13) {
				for (String d : directory.split("/")) {
					bos.write(("CWD " + d).getBytes());
					bos.write((byte) 13);								
				}
			} else {
				bos.write(("CWD " + directory).getBytes());
				bos.write((byte) 13);			
			}
		}
		String[] cmds = run.split("\n");
		for (int i = 0; i < cmds.length; i++) {
			String cmd = cmds[i].trim();
			System.out.println(">>" + cmd + "<<");
			if (cmd.equals("RUN")) {
				bos.write((byte) CMD_UPDATE_TOP_AND_RUN);
			} else if (cmd.startsWith("CH.")) {
				String filename = trunc(cmd.split("\"")[1]);
				bos.write(("LOAD " + filename).getBytes());
				bos.write((byte) 13);
				bos.write((byte) CMD_UPDATE_TOP_AND_RUN);
			} else if (cmd.startsWith("?18=")) {
				int page = Integer.parseInt(cmd.split("=")[1]);
				bos.write(CMD_PAGE);
				bos.write(page);
			} else if (cmd.startsWith("PRINT ")) {
				cmd = cmd.substring(6) + "\n\r";
				bos.write((byte) CMD_PRINT);
				bos.write(cmd.getBytes());
				bos.write((byte) 0);
			} else if (cmd.startsWith("*LOAD") || cmd.startsWith("*RUN")) {
				String[] parts = cmd.split(" ");
				if (parts.length != 2) {
					throw new RuntimeException("Expected two parts: " + cmd);
				}
				cmd = parts[0] + " " + trunc(parts[1]);
				if (i == cmds.length - 1) {
					bos.write((byte) CMD_DIRECT);
					bos.write(cmd.getBytes());
					bos.write((byte) 13);
				} else {
					cmd = cmd.substring(1);
					bos.write(cmd.getBytes());
					bos.write((byte) 13);
				}
			} else {
				throw new RuntimeException("Illegal command " + cmd + " in title " + index);
			}
		}

		FileOutputStream fos = new FileOutputStream(new File(menuDir, "" + index));
		writeATMFile(fos, "" + index, loadAddr, execAddr, bos.toByteArray());
		fos.close();

	}

	private String trunc(String filename) {
		if (sddos && filename.length() > 7) {
			return filename.substring(0, 7);
		} else {
			return filename;
		}
	}
	
	public void generateFiles(List<SpreadsheetTitle> items) throws IOException {
		for (SpreadsheetTitle item : items) {
			if (item.isPresent()) {
				boolean rom = item.getChunk().contains("ROM");
				generateMachineCodeBootstrap(item.getIndex(), item.getDir(), item.getRun(), item.getBoot(), rom);
			}
		}
	}
}
