package uk.co.acornatom.menu;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import uk.co.acornatom.menu.IFileGenerator.Target;

public class GenerateAll {

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

            // Count the number of titles in each chunk
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
            char startChunkId = 'A';
            String chunkAll = "" + (char)(startChunkId + chunks.size());
            String chunkAGD = "" + (char)(startChunkId + chunks.size() - 1);
            chunks.put(chunkAll, total);

            System.out.println("Found " + chunks.size() + " chunks");

            // Each menu chapter will be a separate disk
            for (Target target : Target.values()) {

                System.out.println("*******************************");
                System.out.println("Generating " + target.name());
                System.out.println("*******************************");

                IArchiveGenerator generator = null;

                if (target == Target.SDDOS2) {
                    generator = new GenerateSDDOS2Files(archiveDir, menuBase, chunks.size(), new File(archiveDir + ".img"));
                }

                if (target == Target.SDDOS3) {
                    generator = new GenerateSDDOS3Files(archiveDir, menuBase, chunks.size(), new File(archiveDir + "_SDDOS3.zip"));
                }

                if (target == Target.JS) {
                    generator = new GenerateJSFiles(archiveDir, menuBase, chunks.size(), new File(archiveDir + ".js"));
                }

                if (target == Target.ECONET) {
                    generator = new GenerateEconetFiles(archiveDir, new File(archiveDir + "_ECONET.zip"), menuBase, chunks.size());
                }

                if (target == Target.GOSDC) {
                    generator = new GenerateGoSDCFiles(archiveDir, menuBase, chunks.size(), new File(archiveDir + ".gosdc"));
                }

                if (target == Target.ATOMMC) {
                    generator = new GenerateAtoMMCFiles();
                }

                // Give the generator the opportunity to map titles to disk images
                generator.allocateDisks(items);

                System.out.println(" menu files version " + version);

                IFileGenerator splashGen = new GenerateSplashFiles(archiveDir, version, chunks);
                splashGen.generateFiles(null, target);

                char chunkId = startChunkId;

                for (String chunk : chunks.keySet()) {

                    // true if this is the last chunk containing all titles
                    boolean allChunk = chunk.equals(chunkAll);

                    // true if this is the last but one chunk containing the AGD titles
                    boolean agdChunk = chunk.equals(chunkAGD);

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
                    generators.add(new GenerateMenuFiles(archiveDir, menuDir, agdChunk, allChunk));
                    for (IFileGenerator g : generators) {
                        g.generateFiles(chunkItems, target);
                    }

                    chunkId++;
                }

                generator.generateFiles(items, target);
                generator.writeImage();
                generator.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
