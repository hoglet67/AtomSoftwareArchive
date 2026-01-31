package uk.co.acornatom.menu;

import java.io.IOException;
import java.util.List;

public interface IFileGenerator {

    public static final String AGD_CHUNK    = "C";
    public static final String ROMS_CHUNK   = "F";
    public static final String ALL_CHUNK    = "G";

    public static final String SPLASH_NAME  = "SPLASH";

    // The various build targets we support
    public enum Target {
        SDDOS2, SDDOS3, JS, ECONET, GOSDC, ATOMMC
    }

    void generateFiles(List<SpreadsheetTitle> items, Target target) throws IOException;
}
