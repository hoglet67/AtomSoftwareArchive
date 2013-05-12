package uk.co.acornatom.menu;

import java.io.File;
import java.io.IOException;
import java.util.List;

public interface IFileGenerator {
	void generateFiles(File menuDir, List<SpreadsheetTitle> items) throws IOException;
}
