package uk.co.acornatom.afsutils;

import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;

public class Volume extends DiskObject {

    RandomAccessFile file;

    protected Volume(File f, String mode) throws IOException {
        this.file = new RandomAccessFile(f, mode);
    }

    public byte[] readSector(int sector) throws IOException {
        byte[] buffer = new byte[SECT_SIZE];
        file.seek(sector * SECT_SIZE);
        file.read(buffer);
        return buffer;
    }

    public void readSector(int sector, byte[] buffer, int offset, int length) throws IOException {
        file.seek(sector * SECT_SIZE);
        file.read(buffer, offset, length);
    }

    public void writeSector(int sector, byte[] buffer, int offset, int length) throws IOException {
        file.seek(sector * SECT_SIZE);
        file.write(buffer, offset, length);
    }

    public long getSizeInBytes() throws IOException {
        return file.length();
    }

    public long getSizeInSectors() throws IOException {
        return file.length() / SECT_SIZE;
    }

}
