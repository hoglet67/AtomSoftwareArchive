package uk.co.acornatom.menu;

import java.io.IOException;
import java.util.List;

abstract public class ArchiveGeneratorBase extends GenerateBase implements IArchiveGenerator {

    // Files to copy into each MNU folder
    public static String[] ATOMMC_MENU_FILES = { "MENU1", "MENU2", "SORT0", "SORT1", "SORT2", "SORT3", "HELP"};

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

    public void allocateDisks(List<SpreadsheetTitle> items) throws IOException {
        // Items are shared between targets, so reset any allocation from earlier targets
        for (SpreadsheetTitle item : items) {
            item.setDiskNo(null);
        }
    }

    public void generateFiles(List<SpreadsheetTitle> items, Target target) throws IOException {
    }

    public void writeImage() throws IOException {
    }

    public void close() throws IOException {
    }

}
