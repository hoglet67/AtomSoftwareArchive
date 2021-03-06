package uk.co.acornatom.menu;

import java.io.IOException;
import java.io.OutputStream;


abstract public class GenerateBase implements IFileGenerator {

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
