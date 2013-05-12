package uk.co.acornatom.menu;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class GenerateAll {

	public static final void main(String[] args) {
		try {
			SpreadsheetParser parser = new SpreadsheetParser(new File("AtomSoftwareCatalog.csv"));
			List<SpreadsheetTitle> items = parser.parseSpreadSheet();
			File menuDir = new File("MNU");
			menuDir.mkdirs();
			List<IFileGenerator> generators = new ArrayList<IFileGenerator>();
			generators.add(new GenerateBootstrapFiles());
			generators.add(new GenerateMenuFiles());
			for (IFileGenerator generator : generators) {
				generator.generateFiles(menuDir, items);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
