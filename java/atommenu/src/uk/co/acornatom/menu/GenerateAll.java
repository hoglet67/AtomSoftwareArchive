package uk.co.acornatom.menu;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.SortedSet;
import java.util.TreeSet;

public class GenerateAll {

	public static final void main(String[] args) {
		try {
			if (args.length != 3) {
				System.err.println("usage: java -jar atommenu.jar <AtomSoftwareCatalog.csv file> <Menu Base Dir> <Boot Loader Binary>");
				System.exit(1);
			}			
			SpreadsheetParser parser = new SpreadsheetParser(new File(args[0]));
			List<SpreadsheetTitle> items = parser.parseSpreadSheet();
			
			SortedSet<String> chunks = new TreeSet<String>();
			for (SpreadsheetTitle item : items) {
				chunks.add(item.getChunk());
			}
			
			char chunkId = 'A';
			
			for (String chunk : chunks) {
				
				File menuDir = new File(args[1] + chunkId);
				menuDir.mkdirs();
				File bootLoaderBinary = new File(args[2]);
				if (!bootLoaderBinary.exists() || !bootLoaderBinary.isFile()) {
					System.err.println("Boot Loader Binary: " + bootLoaderBinary+ " does not exist");
					System.exit(1);
				}				
				List<SpreadsheetTitle> chunkItems = new ArrayList<SpreadsheetTitle>();
				for (SpreadsheetTitle item : items) {
					if (item.getChunk().equals(chunk)) {
						chunkItems.add(item);
					}
				}
				List<IFileGenerator> generators = new ArrayList<IFileGenerator>();
				generators.add(new GenerateBootstrapFiles());
				generators.add(new GenerateMenuFiles());
				generators.add(new GenerateSplashFiles(chunks));
				for (IFileGenerator generator : generators) {
					generator.generateFiles(menuDir, bootLoaderBinary, chunkItems);
				}
				
				chunkId++;
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
