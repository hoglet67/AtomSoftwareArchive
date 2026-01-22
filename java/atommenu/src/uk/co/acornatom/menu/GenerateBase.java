package uk.co.acornatom.menu;

import java.io.IOException;
import java.io.OutputStream;

abstract public class GenerateBase implements IFileGenerator {

    protected void patch_atommc_joystick(ATMFile atmFile, SpreadsheetTitle item) {
        byte[] bytes = atmFile.getData();
        for (int i = 0; i < bytes.length - 6; i++) {
            // .loop LDA &B400
            //       BMI loop   // Patch replaces this with NOP
            //       RTS
           if (bytes[i  ] == (byte) 0xAD &&
               bytes[i+1] == (byte) 0x00 &&
               bytes[i+2] == (byte) 0xB4 &&
               bytes[i+3] == (byte) 0x30 &&
               bytes[i+4] == (byte) 0xFB &&
               bytes[i+5] == (byte) 0x60) {
                   System.out.println(String.format("Patching AtoMMC joystick code in %s %s file %s offset %d",
                                                    item.getPublisher(),
                                                    item.getTitle(),
                                                    atmFile.getTitle(),
                                                    i));
                   bytes[i + 3] = (byte) 0xEA;
                   bytes[i + 4] = (byte) 0xEA;
            }
        }
    }

    // Files to copy into each MNU folder
    public static String[] ATOMMC_MENU_FILES = { "MENU1", "MENU2", "SORT0", "SORT1", "SORT2", "SORT3", "HELP"};

    protected void writeATMFile(OutputStream out, String title, int loadAddr, int execAddr, byte[] data) throws IOException {
        ATMFile atm = new ATMFile(title, loadAddr, execAddr, data);
        atm.writeATMFile(out);
    }

    protected void writeString(OutputStream out, String value) throws IOException {
        ATMFile.writeString(out, value);
    }

    protected void writeInt(OutputStream out, int value) throws IOException {
        ATMFile.writeInt(out, value);
    }

    protected void writeShort(OutputStream out, int value) throws IOException {
        ATMFile.writeShort(out, value);
    }

    protected void writeByte(OutputStream out, int value) throws IOException {
        ATMFile.writeByte(out, value);
    }

}
