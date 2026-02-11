package uk.co.acornatom.menu;

import java.io.IOException;
import java.util.List;

public interface IFileGenerator {

    public static final String COMM_CHUNK      = "COMM";
    public static final String MODERN_CHUNK    = "MODERN";
    public static final String AGD_CHUNK       = "AGD";
    public static final String NON_COMM_CHUNK  = "NON COMM";
    public static final String BOOKS_CHUNK     = "BOOKS";
    public static final String MAGAZINES_CHUNK = "MAGAZINES";
    public static final String ROMS_CHUNK      = "ROMS";

    public static final String AGD_CHAPTER     = "C";
    public static final String ALL_CHAPTER     = "G";

    public static final String SPLASH_NAME  = "SPLASH";

    // The various build targets we support
    public enum Target {
        SDDOS2, SDDOS3, JS, ECONET, GOSDC, ATOMMC
    }

    void generateFiles(List<AtomTitle> items) throws IOException;

    abstract public Target getTarget();

    public void setDebug(boolean debug);
}
