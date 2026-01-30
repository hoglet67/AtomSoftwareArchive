package uk.co.acornatom.menu;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import uk.co.acornatom.menu.IFileGenerator.Target;

public class GenerateAll {

    public static final void main(String[] args) {
        try {
            if (args.length < 3 || args.length > 4) {
                System.err.println(
                        "usage: java -jar atommenu.jar <AtomSoftwareCatalog.csv file> <Archive Dir> <Version String> [ <Target>,... ]");
                System.exit(1);
            }

            // No real reason to change this
            String menuBase = "MNU";

            File catalogCSV = new File(args[0]);
            File archiveDir = new File(args[1]);
            String version = args[2];

            if (!catalogCSV.exists() || !catalogCSV.isFile()) {
                System.err.println("CatalogCSV: " + catalogCSV + " does not exist");
                System.exit(1);
            }

            if (!archiveDir.exists() || !archiveDir.isDirectory()) {
                System.err.println("Archive Directory: " + archiveDir + " does not exist");
                System.exit(1);
            }

            if (version.isEmpty()) {
                throw new RuntimeException("Missing version");
            }

            List<Target> targets = new ArrayList<Target>();
            if (args.length == 4) {
                for (String target : args[3].split(",")) {
                    // Throws a IllegalArgumentException exception if not found which is fine
                    targets.add(Target.valueOf(target.strip().toUpperCase()));
                }
            } else {
                targets = Arrays.asList(Target.values());
            }

            SpreadsheetParser parser = new SpreadsheetParser(catalogCSV);
            List<SpreadsheetTitle> items = parser.parseSpreadSheet();

            // Gather some additional metadata on the titles
            Map<String, Integer> chunks = new TreeMap<String, Integer>();
            int total = 0;
            for (SpreadsheetTitle item : items) {
                if (!item.isPresent()) {
                    continue;
                }
                // Count the number of titles in each chunk
                String chunk = item.getChunk();
                Integer count = chunks.get(chunk);
                if (count == null) {
                    count = 0;
                }
                chunks.put(chunk, count + 1);
                total++;
                // Decide if the title will fit in 32KB
                boolean ok = true;
                for (String filename : item.getFilenames()) {
                    File file = new File(new File(archiveDir, item.getDir()), filename);
                    try {
                        ATMFile atm = new ATMFile(file);
                        int start = atm.getLoadAddr();
                        int end = atm.getLoadAddr() + atm.getLength();
                        if (!((start >= 0x2800 && end <= 0x3C00) ||
                              (start >= 0x8000 && end <= 0x9800) ||
                              (start >= 0xa000 && end <= 0xb000 && item.getChunk().equals("E")))) {
                            if (item.isCompatible12K()) {
                                if (ok) {
                                    System.out.println("Compatibility warning: should be marked at 32K: " + item.getIdentifier()
                                            + " " + item.getChunk() + ": " + item.getPublisher() + " " + item.getTitle());
                                }
                                System.out.println("    " + atm);
                            }
                            ok = false;
                        }
                    } catch (IOException e) {
                        System.out.print("Missing:" + file);
                    }
                }
                // There are a very small number of these
                if (!item.isCompatible12K() && ok) {
                    System.out.println("Compatibility warning: wrongly marked as 32K " + item.getIdentifier() + " " + item.getTitle());
                }
            }
            char startChunkId = 'A';
            String chunkAll = "" + (char)(startChunkId + chunks.size());
            String chunkAGD = "" + (char)(startChunkId + chunks.size() - 1);
            chunks.put(chunkAll, total);

            System.out.println("Found " + chunks.size() + " chunks");

            // Each menu chapter will be a separate disk
            for (Target target : targets) {

                System.out.println("*******************************");
                System.out.println("Generating " + target.name());
                System.out.println("*******************************");

                IArchiveGenerator generator = null;

                File bootLoaderBinary = new File(archiveDir, "BOOT.bin");
                File romBootLoaderBinary = new File(archiveDir, "BOOTROM.bin");

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
                    // GoSDC needs a different ROM bootloader
                    romBootLoaderBinary = new File(archiveDir, "BOOTROMGOSDC.bin");
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
