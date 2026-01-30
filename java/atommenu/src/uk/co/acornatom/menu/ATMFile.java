package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

public class ATMFile {

    private byte[] data;
    private int loadAddr;
    private int execAddr;
    private String title;
    private boolean atm;

    public ATMFile(String title, int loadAddr, int execAddr, byte[] data) {
        this.title = title;
        this.loadAddr = loadAddr;
        this.execAddr = execAddr;
        this.data = data;
        this.atm = true;
    }

    public static void copy(File src, File dst) throws IOException {
        Files.copy(src.toPath(), dst.toPath(), StandardCopyOption.REPLACE_EXISTING);
    }

    public ATMFile(File file) throws IOException {
        ByteArrayOutputStream ous = null;
        InputStream ios = null;
        try {
            byte[] buffer = new byte[4096];
            ous = new ByteArrayOutputStream();
            ios = new FileInputStream(file);
            int read = 0;
            while ((read = ios.read(buffer)) != -1) {
                ous.write(buffer, 0, read);
            }
        } finally {
            try {
                if (ous != null) {
                    ous.close();
                }
            } catch (IOException e) {
            }

            try {
                if (ios != null) {
                    ios.close();
                }
            } catch (IOException e) {
            }
        }
        byte[] bytes = ous.toByteArray();
        int length = readShort(bytes, 20);
        if (bytes.length < 0x10000 && length == bytes.length - 22) {
            // Handle as an ATM file
            title = "";
            for (int i = 0; i < 16; i++) {
                if (bytes[i] != 0) {
                    title += (char) bytes[i];
                }
            }
            loadAddr = readShort(bytes, 16);
            execAddr = readShort(bytes, 18);
            // Remove the header
            data = new byte[length];
            System.arraycopy(bytes, 22, data, 0, length);
            // Mark as ATM
            atm = true;
        } else {
            // Handle as a data file
            if (bytes.length < 0x10000) {
                System.out.println("WARNING: Length mismatch possible in ATM file: " + file + " (expected=" + length + "; actual="
                        + (bytes.length - 22) + ")");
            }
            title = file.getName();
            loadAddr = 0;
            execAddr = 0;
            data = bytes;
            // Mark as BINARY DATA
            atm = false;
        }
    }

    public byte[] getData() {
        return data;
    }

    public int getLoadAddr() {
        return loadAddr;
    }

    public int getExecAddr() {
        return execAddr;
    }

    public int getLength() {
        return data.length;
    }

    public void setExec(int exec) {
        this.execAddr = exec;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public boolean isAtm() {
        return atm;
    }

    public void setAtm(boolean atm) {
        this.atm = atm;
    }

    @Override
    public String toString() {
        return title + " " + Integer.toHexString(loadAddr) + " " + Integer.toHexString(execAddr) + " " + Integer.toHexString(data.length);
    }

    public void writeATMFile(OutputStream out) throws IOException {
        if (!atm) {
            throw new IOException("Not an ATM File: " + title);
        }
        writeString(out, title);
        for (int i = 0; i < 16 - title.length(); i++) {
            out.write(0);
        }
        writeShort(out, loadAddr);
        writeShort(out, execAddr);
        writeShort(out, data.length);
        out.write(data);
    }

    public static void writeString(OutputStream out, String value) throws IOException {
        out.write(value.getBytes());
    }

    public static void writeInt(OutputStream out, int value) throws IOException {
        byte[] buffer = new byte[4];
        buffer[0] = (byte) (value & 0xff);
        buffer[1] = (byte) ((value >> 8) & 0xff);
        buffer[2] = (byte) ((value >> 16) & 0xff);
        buffer[3] = (byte) ((value >> 24) & 0xff);
        out.write(buffer);
    }

    public static void writeShort(OutputStream out, int value) throws IOException {
        byte[] buffer = new byte[2];
        buffer[0] = (byte) (value & 0xff);
        buffer[1] = (byte) ((value >> 8) & 0xff);
        out.write(buffer);
    }

    public static int readShort(byte[] buffer, int offset) throws IOException {
        return ((buffer[offset + 1] & 0xFF) << 8) | (buffer[offset] & 0xFF);
    }

    public static void writeByte(OutputStream out, int value) throws IOException {
        byte[] buffer = new byte[1];
        buffer[0] = (byte) (value & 0xff);
        out.write(buffer);
    }

}
