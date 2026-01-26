package uk.co.acornatom.menu;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.HashSet;

import uk.co.acornatom.menu.IFileGenerator.Target;

public class GenerateAll {

    private static int calcFileSpace(File archiveDir, SpreadsheetTitle item) {
        int total = 0;
        for (String filename : item.getFilenames()) {
            File file = new File(new File(archiveDir, item.getDir()), filename);
            total += (file.length() + 0xFF) & 0xFFFF00;
        }
        // Account for boot file
        total += 0x100;
        return total;
    }

    private static boolean areItemsCombinable(File archiveDir, SpreadsheetTitle item1, SpreadsheetTitle item2) {

        int item1_numFiles = item1.getFilenames().size();
        int item2_numFiles = item2.getFilenames().size();

        // 29 allows two free catalog entries for the boot files
        if (item1_numFiles + item2_numFiles > 29) {
            System.out.println("Not combinable due to number of files:" + item1.getTitle() + " and " + item2.getTitle());
            return false;
        }

        int cat_space = 0x200;
        int item1_space = calcFileSpace(archiveDir, item1) + 0x100; // + 0x100 to allow for boot file
        int item2_space = calcFileSpace(archiveDir, item2) + 0x100;

        if (cat_space + item1_space + item2_space > 40 * 10 * 0x100) {
            System.out.println("Not combinable due to space:" + item1.getTitle() + " and " + item2.getTitle());
            return false;
        }

        HashSet<String> filenames = new HashSet<String>();
        filenames.addAll(item1.getFilenames());
        filenames.addAll(item2.getFilenames());
        if (filenames.size() != item1_numFiles + item2_numFiles) {
            System.out.println("Not combinable due to name conflicts:" + item1.getTitle() + " and " + item2.getTitle());
            return false;
        }

        return true;
    }

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

            // Generate disk numbers up front, combining pairs of titles if possible
            // (this is just used by SDDOS)
            int diskNo = 0;
            SpreadsheetTitle lastItem = null;
            for (SpreadsheetTitle item : items) {
                if (!item.isPresent()) {
                    continue;
                }
                // Test if two items are combinable
                if (lastItem != null && areItemsCombinable(archiveDir, item, lastItem)) {
                    // Append the item to the current disk
                    item.setIndex(diskNo * 2 + 1);
                    lastItem = null;
                } else {
                    // Start a new disk for this item
                    diskNo++;
                    item.setIndex(diskNo * 2);
                    lastItem = item;
                }
            }

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
                    for (IFileGenerator generator : generators) {
                        generator.generateFiles(chunkItems, target);
                    }

                    chunkId++;
                }

                if (target == Target.SDDOS) {
                    GenerateSDDOSFiles sdGenerator = new GenerateSDDOSFiles(archiveDir, menuBase, chunks.size(),
                            new File(archiveDir + ".img"));
                    sdGenerator.generateFiles(items, target);
                    sdGenerator.writeImage();
                    new File(archiveDir, "MENUSD").delete();
                }

                if (target == Target.JS) {
                    GenerateJSFiles jsGenerator = new GenerateJSFiles(archiveDir, menuBase, chunks.size(),
                            new File(archiveDir + ".js"));
                    jsGenerator.generateFiles(items, target);
                    jsGenerator.writeImage();
                    new File(archiveDir, "MENUSD").delete();
                }

                if (target == Target.ECONET) {
                    GenerateEconetFiles econetGenerator = new GenerateEconetFiles(archiveDir, new File(archiveDir + "_ECONET.zip"),
                            menuBase, chunks.size());
                    econetGenerator.generateFiles(items, target);
                    econetGenerator.close();
                    new File(archiveDir, "MENUSD").delete();
                }

                if (target == Target.GOSDC) {
                    GenerateGoSDCFiles gosdcGenerator = new GenerateGoSDCFiles(archiveDir, menuBase, chunks.size(),
                            new File(archiveDir + ".gosdc"));
                    gosdcGenerator.generateFiles(items, target);
                    gosdcGenerator.close();
                    new File(archiveDir, "MENUSD").delete();
                }

            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
