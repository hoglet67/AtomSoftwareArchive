package uk.co.acornatom.menu;

import java.io.IOException;
import java.util.List;

public interface IFileGenerator {
    
    // The various build targets we support
    public enum Target {
        ATOMMC, SDDOS, ECONET
    }

    void generateFiles(List<SpreadsheetTitle> items, Target target) throws IOException;
}
