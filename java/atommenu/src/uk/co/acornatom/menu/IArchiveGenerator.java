package uk.co.acornatom.menu;

import java.io.IOException;
import java.util.List;

public interface IArchiveGenerator extends IFileGenerator {

    public void filterTitles(List<AtomTitle> items) throws IOException;

    public void allocateDisks(List<AtomTitle> items) throws IOException;

    public void writeImage() throws IOException;

    public void close() throws IOException;

}
