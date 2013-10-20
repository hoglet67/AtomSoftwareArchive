package uk.co.acornatom.menu;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class GenerateAll {

	public static final void main(String[] args) {
		try {
			if (args.length != 4) {
				System.err
						.println("usage: java -jar atommenu.jar <AtomSoftwareCatalog.csv file> <Archive Dir> <Boot Loader Binary> <Version>");
				System.exit(1);
			}

			// No real reason to change this
			String menuBase = "MNU";

			File catalogCSV = new File(args[0]);
			File archiveDir = new File(args[1]);
			File bootLoaderBinary = new File(args[2]);
			String version = args[3];

			if (!catalogCSV.exists() || !catalogCSV.isFile()) {
				System.err.println("CatalogCSV: " + catalogCSV + " does not exist");
				System.exit(1);
			}

			if (!archiveDir.exists() || !archiveDir.isDirectory()) {
				System.err.println("Archive Directory: " + archiveDir + " does not exist");
				System.exit(1);
			}

			if (!bootLoaderBinary.exists() || !bootLoaderBinary.isFile()) {
				System.err.println("Boot Loader Binary: " + bootLoaderBinary + " does not exist");
				System.exit(1);
			}

			if (version.isEmpty()) {
				throw new RuntimeException("Missing version");
			}

			SpreadsheetParser parser = new SpreadsheetParser(catalogCSV);
			List<SpreadsheetTitle> items = parser.parseSpreadSheet();

			Map<String, Integer> chunks = new TreeMap<String, Integer>();
			for (SpreadsheetTitle item : items) {
				if (!item.isPresent()) {
					continue;
				}
				String chunk = item.getChunk();
				Integer count = chunks.get(chunk);
				if (count == null) {
					count = 0;
				}
				chunks.put(chunk, count + 1);
			}

			for (int pass = 0; pass < 2; pass++) {

				boolean sddos = (pass == 0);
				
				System.out.println("Generating " + (sddos ? "SDDOS" : "ATOMMC") + "menu files version " + version);

				char chunkId = 'A';

				for (String chunk : chunks.keySet()) {

					File menuDir = new File(archiveDir, menuBase + chunkId);
					menuDir.mkdirs();

					List<SpreadsheetTitle> chunkItems = new ArrayList<SpreadsheetTitle>();
					for (SpreadsheetTitle item : items) {
						if (item.getChunk().equals(chunk)) {
							chunkItems.add(item);
						}
					}
					List<IFileGenerator> generators = new ArrayList<IFileGenerator>();
					generators.add(new GenerateBootstrapFiles(menuDir, bootLoaderBinary, sddos));
					generators.add(new GenerateMenuFiles(menuDir));
					generators.add(new GenerateSplashFiles(menuDir, version, chunks));
					for (IFileGenerator generator : generators) {
						generator.generateFiles(chunkItems);
					}

					chunkId++;
				}

				if (sddos) {
					GenerateSDDOSFiles SDCardGenerator = new GenerateSDDOSFiles(archiveDir, new File(archiveDir + ".img"),	menuBase, chunks.size());
					SDCardGenerator.generateFiles(items);
					SDCardGenerator.writeSDImage();
					new File(archiveDir, "MENUSD").delete();
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
