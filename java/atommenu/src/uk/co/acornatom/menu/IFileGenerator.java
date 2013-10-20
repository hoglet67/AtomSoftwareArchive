package uk.co.acornatom.menu;

import java.io.IOException;
import java.util.List;

public interface IFileGenerator {
	void generateFiles(List<SpreadsheetTitle> items) throws IOException;
}
