package uk.co.acornatom.menu;

import java.io.IOException;

public class GenerateAtoMMCFiles extends ArchiveGeneratorBase {

    public GenerateAtoMMCFiles() throws IOException {
        super();
    }

    @Override
    public Target getTarget() {
        return Target.ATOMMC;
    }

}
