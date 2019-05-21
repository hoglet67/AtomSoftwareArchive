package uk.co.acornatom.menu;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import uk.co.acornatom.menu.GenerateBootstrapFiles.Target;

public class GenerateAll {

    private static final String ALL_TITLES = "All Titles (32K)";

    public static final void main(String[] args) {
        try {
            if (args.length != 5) {
                System.err.println(
                        "usage: java -jar atommenu.jar <AtomSoftwareCatalog.csv file> <Archive Dir> <Boot Loader Binary>  <ROM Boot Loader Binary> <Version>");
                System.exit(1);
            }

            // No real reason to change this
            String menuBase = "MNU";

            File catalogCSV = new File(args[0]);
            File archiveDir = new File(args[1]);
            File bootLoaderBinary = new File(args[2]);
            File romBootLoaderBinary = new File(args[3]);
            String version = args[4];

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

            if (!romBootLoaderBinary.exists() || !romBootLoaderBinary.isFile()) {
                System.err.println("ROM Boot Loader Binary: " + romBootLoaderBinary + " does not exist");
                System.exit(1);
            }

            if (version.isEmpty()) {
                throw new RuntimeException("Missing version");
            }

            SpreadsheetParser parser = new SpreadsheetParser(catalogCSV);
            List<SpreadsheetTitle> items = parser.parseSpreadSheet();

            // Temporarily disabled sddos until we figure out how to avoid SDDOS
            // overflow
            // Each menu chapter will be a seperate disk

            for (int pass = 0; pass < 3; pass++) {
                Target target;

                if (pass == 1) {
                    System.out.print("Generating SDDOS");
                    target = Target.SDDOS;
                } else if (pass == 2) {
                    System.out.print("Generating Econet");
                    target = Target.ECONET;
                } else {
                    System.out.print("Generating AtoMMC");
                    target = Target.ATOMMC;
                }
                System.out.println(" menu files version " + version);

                Map<String, Integer> chunks = new TreeMap<String, Integer>();
                int total = 0;
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
                    total++;
                }

                char chunkId = 'A';
                String chunkAll = (char) (chunkId + chunks.size()) + "." + ALL_TITLES;
                chunks.put(chunkAll, total);

                for (String chunk : chunks.keySet()) {

                    // true if this is the last chunk containing all titles
                    boolean allChunk = chunk.equals(chunkAll);

                    File menuDir = new File(archiveDir, menuBase + chunkId);
                    menuDir.mkdirs();

                    List<SpreadsheetTitle> chunkItems = new ArrayList<SpreadsheetTitle>();
                    for (SpreadsheetTitle item : items) {
                        if (item.getChunk().equals(chunk) | allChunk) {
                            chunkItems.add(item);
                        }
                    }
                    List<IFileGenerator> generators = new ArrayList<IFileGenerator>();
                    generators.add(new GenerateBootstrapFiles(menuDir, bootLoaderBinary, romBootLoaderBinary, target));
                    generators.add(new GenerateMenuFiles(menuDir, allChunk));
                    generators.add(new GenerateSplashFiles(menuDir, version, chunks));
                    for (IFileGenerator generator : generators) {
                        generator.generateFiles(chunkItems);
                    }

                    chunkId++;
                }

                if (target == Target.SDDOS) {
                    GenerateSDDOSFiles SDCardGenerator = new GenerateSDDOSFiles(archiveDir, new File(archiveDir + ".img"),
                            new File(archiveDir + ".js"), menuBase, chunks.size());
                    SDCardGenerator.generateFiles(items);
                    SDCardGenerator.writeSDImage();
                    new File(archiveDir, "MENUSD").delete();
                }
                if (target == Target.ECONET) {
                    GenerateEconetFiles econetGenerator = new GenerateEconetFiles(archiveDir, new File(archiveDir + "_ECONET.zip"),
                            menuBase, chunks.size());
                    econetGenerator.generateFiles(items);
                    econetGenerator.close();
                    new File(archiveDir, "MENUSD").delete();
                }

            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
