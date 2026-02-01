package uk.co.acornatom.menu;

import java.io.IOException;
import java.io.OutputStream;

abstract public class GenerateBase implements IFileGenerator {

    protected boolean debug = false;

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

    @Override
    public void setDebug(boolean debug) {
        this.debug = debug;
    }

    protected static void banner(String message) {
        System.out.println();
        System.out.println("**********************************************************************");
        System.out.println(message);
        System.out.println("**********************************************************************");
        System.out.println();
    }


}
