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
    public static final int CMD_ROMCOPY = 6;

    public enum Target {
        ATOMMC, SDDOS, ECONET
    }

    private File menuDir;
    private File bootLoaderBinary;
    private File romBootLoaderBinary;
    private Target target;

    public GenerateBootstrapFiles(File menuDir, File bootLoaderBinary, File romBootLoaderBinary, Target target) {
        this.menuDir = menuDir;
        this.bootLoaderBinary = bootLoaderBinary;
        this.romBootLoaderBinary = romBootLoaderBinary;
        this.target = target;
    }

    private void generateMachineCodeBootstrap(SpreadsheetTitle item, boolean rom) throws IOException {

        int index = item.getIndex();
        String directory = item.getDir();
        String run = item.getRun();
        String boot = item.getBoot();

        int loadAddr = Integer.parseInt(boot, 16);
        int execAddr = loadAddr;

        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        FileInputStream fis = new FileInputStream(rom ? romBootLoaderBinary : bootLoaderBinary);
        int b;
        while ((b = fis.read()) != -1) {
            bos.write(b);
        }
        fis.close();
        if (target == Target.ATOMMC) {
            // Break long directory paths into separate CWD commands to avoid
            // hitting the 13 char limit to *CWD
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
                if (target == Target.SDDOS) {
                    item.getLoadables().add(filename);
                }
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
                String filename = trunc(parts[1]);
                if (target == Target.ECONET && cmd.startsWith("*RUN")) {
                    // L3 Econet doesn't have a *RUN or */ command
                    cmd = "*" + filename;
                } else {
                    cmd = parts[0] + " " + filename;
                }
                if (target == Target.SDDOS || target == Target.ECONET) {
                    item.getLoadables().add(filename);
                    if (cmd.startsWith("*RUN")) {
                        // Add to list of runnables, so we can later check the
                        // exec address is valid
                        item.getRunnables().add(filename);
                    }
                }
                for (int j = 2; j < parts.length; j++) {
                    cmd += " " + parts[j];
                }
                if (!rom && i == cmds.length - 1) {
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

        // For the ROM Boot Loader, make sure we execute the ROMCOPY command
        // Currently this is hard coded to copy 4K from 8800 to A000
        if (rom) {
            bos.write((byte) CMD_ROMCOPY);
        }

        FileOutputStream fos = new FileOutputStream(new File(menuDir, "" + index));
        writeATMFile(fos, "" + index, loadAddr, execAddr, bos.toByteArray());
        fos.close();

    }

    private String trunc(String filename) {
        if (target == Target.SDDOS && filename.length() > 7) {
            return filename.substring(0, 7);
        } else {
            return filename;
        }
    }

    public void generateFiles(List<SpreadsheetTitle> items) throws IOException {
        for (SpreadsheetTitle item : items) {
            if (item.isPresent()) {
                boolean rom = item.getChunk().contains("ROM");
                generateMachineCodeBootstrap(item, rom);
            }
        }
    }
}
