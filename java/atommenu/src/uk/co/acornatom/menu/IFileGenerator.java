package uk.co.acornatom.menu;

import java.io.IOException;
import java.util.List;

public interface IFileGenerator {

    // The various build targets we support
    public enum Target {
        SDDOS2, SDDOS3, JS, ECONET, GOSDC, ATOMMC
    }

    void generateFiles(List<SpreadsheetTitle> items, Target target) throws IOException;
}
