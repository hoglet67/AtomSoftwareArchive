package uk.co.acornatom.menu;

import java.io.IOException;
import java.util.List;

public class GenerateAtoMMCFiles extends ArchiveGeneratorBase {

    public GenerateAtoMMCFiles() throws IOException {
        super();
    }

    @Override
    public void filterTitles(List<AtomTitle> items) throws IOException {
    }

    @Override
    public Target getTarget() {
        return Target.ATOMMC;
    }

}
