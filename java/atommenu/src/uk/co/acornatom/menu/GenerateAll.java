package uk.co.acornatom.menu;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class GenerateAll {

	public static final void main(String[] args) {
		try {
			if (args.length != 2) {
				System.err.println("usage: java -jar atommenu.jar <AtomSoftwareCatalog.csv file> <Menu Base Dir>");
				System.exit(1);
			}			
			SpreadsheetParser parser = new SpreadsheetParser(new File(args[0]));
			List<SpreadsheetTitle> items = parser.parseSpreadSheet();
			File menuDir = new File(args[1]);
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
