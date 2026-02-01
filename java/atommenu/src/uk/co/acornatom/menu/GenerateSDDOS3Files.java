package uk.co.acornatom.menu;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class GenerateSDDOS3Files extends GenerateDiskImageFiles {

    private ZipOutputStream zipStream;

    public GenerateSDDOS3Files(File archiveDir, String menuBase, int numChunks, File sddos3ZipFile)
            throws IOException {
        super(archiveDir, menuBase, numChunks);
        this.zipStream = new ZipOutputStream(new FileOutputStream(sddos3ZipFile));
    }

    @Override
    protected String getMenuDiskName() {
        return "0.DSK";
    }

    @Override
    protected String getChapterDiskName(int chunk) {
        return "MNU" + (char)('A' + chunk) + ".DSK";
    }


    @Override
    protected void addDisk(byte[] image, String name) throws IOException {
        ZipEntry entry = new ZipEntry(name);
        zipStream.putNextEntry(entry);
        zipStream.write(image);
        zipStream.closeEntry();
    }

    @Override
    public void generateFiles(List<SpreadsheetTitle> items, Target target) throws IOException {
        createMenuDisks(target);
        for (SpreadsheetTitle item : items) {
            try {
                byte[] image = createBlankDiskImage(item.getTitle());
                addTitle(image, item, "BOOT");
                addDisk(image, "" + item.getIdentifier() + ".DSK");
            } catch (Exception e) {
                System.out.println("Problem DiskImage files for title " + item.getTitle());
                e.printStackTrace();
            }
        }
    }

    @Override
    public void close() throws IOException {
        zipStream.close();
    }

}
