package uk.co.acornatom.menu;

import java.io.IOException;
import java.util.List;

public interface IArchiveGenerator extends IFileGenerator {

    public void allocateDisks(List<SpreadsheetTitle> items) throws IOException;

    public void writeImage() throws IOException;

    public void close() throws IOException;

}
