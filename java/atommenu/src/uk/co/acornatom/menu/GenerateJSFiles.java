package uk.co.acornatom.menu;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.apache.commons.codec.binary.Base64;

public class GenerateJSFiles extends GenerateDiskImageFiles {

    private File jsImageFile;
    PrintWriter JSwriter;

    public GenerateJSFiles(File archiveDir, String menuBase, int numChunks, File jsImageFile)
            throws IOException {
        super(archiveDir, menuBase, numChunks);
        this.jsImageFile = jsImageFile;
    }

    private void createJSImage() throws IOException {
        JSwriter = new PrintWriter(jsImageFile);
        JSwriter.println("var");
        JSwriter.println("aDisks =");
        JSwriter.println("[");
    }

    protected void addDisk(byte[] image, SpreadsheetTitle item) {
        // In Javascript image we use the stable persistent identifier
        addDisk(image, item.getIdentifier());
    }

    @Override
    protected void addDisk(byte[] image, int diskNum) {
        // *** JS IMAGE FILE ***
        if (diskNum > 0) {
            JSwriter.println(",");
        }
        int len = getImageLen(image);
        byte[] strippedImage = new byte[len];
        System.arraycopy(image, 0, strippedImage, 0, len);
        JSwriter.print("fDiskRead(\"" + diskNum + "\", D64(\"");
        JSwriter.print(Base64.encodeBase64String(strippedImage));
        JSwriter.print("\"))");
    }

    @Override
    public void generateFiles(List<SpreadsheetTitle> items, Target target) throws IOException {
        createJSImage();
        for (SpreadsheetTitle item : items) {
            try {
                if (item.isPresent()) {
                   byte[] image = createBlankDiskImage(item.getTitle());
                   addTitle(image, item, "BOOT");
                   addDisk(image, item);
                }
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

}
