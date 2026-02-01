package uk.co.acornatom.menu;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.apache.commons.codec.binary.Base64;

public class GenerateJSFiles extends GenerateDiskImageFiles {

    private File jsImageFile;
    PrintWriter JSwriter;
    boolean first;

    public GenerateJSFiles(File archiveDir, String menuBase, int numChunks, File jsImageFile)
            throws IOException {
        super(archiveDir, menuBase, numChunks);
        this.jsImageFile = jsImageFile;
        this.first = true;
    }

    private void createJSImage() throws IOException {
        JSwriter = new PrintWriter(jsImageFile);
        JSwriter.println("var");
        JSwriter.println("aDisks =");
        JSwriter.println("[");
    }

    @Override
    protected String getMenuDiskName() {
        return "BOOT";
    }

    @Override
    protected String getChapterDiskName(int chunk) {
        return "MNU" + (char)('A' + chunk);
    }

    @Override
    protected void addDisk(byte[] image, String name) {
        // *** JS IMAGE FILE ***
        if (!first) {
            JSwriter.println(",");
        }
        int len = getImageLen(image);
        byte[] strippedImage = new byte[len];
        System.arraycopy(image, 0, strippedImage, 0, len);
        JSwriter.print("fDiskRead(\"" + name + "\", D64(\"");
        JSwriter.print(Base64.encodeBase64String(strippedImage));
        JSwriter.print("\"))");
        first = false;
    }

    @Override
    public void generateFiles(List<SpreadsheetTitle> items) throws IOException {
        createJSImage();
        for (SpreadsheetTitle item : items) {
            try {
                byte[] image = createBlankDiskImage(item.getTitle());
                addTitle(image, item, "BOOT");
                addDisk(image, "" + item.getIdentifier());
            } catch (Exception e) {
                System.out.println("Problem DiskImage files for title " + item.getTitle());
                e.printStackTrace();
            }
        }
    }

    @Override
    public void writeImage() throws IOException {
        JSwriter.println("]");
    }

    @Override
    public void close() throws IOException {
        JSwriter.close();
    }

    @Override
    public Target getTarget() {
        return Target.JS;
    }

}
