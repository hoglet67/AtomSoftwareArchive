package uk.co.acornatom.menu;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import uk.co.acornatom.menu.IFileGenerator.Target;

public class GenerateAll {

    private File archiveDir;
    private String menuBase;

    public GenerateAll(File archiveDir, String menuBase) {
        this.archiveDir = archiveDir;
        this.menuBase = menuBase;
    }

    private IArchiveGenerator archiveGeneratorFactory(Target target, int numChunks) throws IOException {
        switch (target) {
            case SDDOS2:
                return new GenerateSDDOS2Files(archiveDir, menuBase, numChunks, new File(archiveDir + ".img"));
            case SDDOS3:
                return new GenerateSDDOS3Files(archiveDir, menuBase, numChunks, new File(archiveDir + "_SDDOS3.zip"));
            case  JS:
                return new GenerateJSFiles(archiveDir, menuBase, numChunks, new File(archiveDir + ".js"));
            case ECONET:
                return new GenerateEconetFiles(archiveDir, new File(archiveDir + "_ECONET.zip"), menuBase, numChunks);
            case  GOSDC:
                return new GenerateGoSDCFiles(archiveDir, menuBase, numChunks, new File(archiveDir + ".gosdc"));
            case ATOMMC:
                return new GenerateAtoMMCFiles();
        }
        return null;
    }

    private void banner(String message) {
        GenerateBase.banner(message);
    }

    // list all files from this path
    public static Set<Path> listFiles(Path path) throws IOException {
        Set<Path> result;
        try (Stream<Path> walk = Files.walk(path)) {
            result = walk.filter(Files::isRegularFile)
                    .collect(Collectors.toSet());
        }
        return result;
    }

    // Check all files needed for each title are present
    private void checkFiles(List<AtomTitle> items) {
        try {
            banner("Checking the files of each title exist");
            Set<Path> paths = new TreeSet<Path>();
            paths.addAll(listFiles(archiveDir.toPath()));
            Iterator<AtomTitle> itemIterator = items.iterator();
            while (itemIterator.hasNext()) {
                AtomTitle item  = itemIterator.next();
                int numSectors = 1; // For boot file
                boolean ok = true;
                for (String filename : item.getFilenames()) {
                    File file = new File(new File(archiveDir, item.getDir()), filename);
                    if (!file.exists()) {
                        System.out.println("WARNING: Missing file: " + file);
                        ok = false;
                    } else if (!file.isFile()) {
                        System.out.println("WARNING: Not a file: " + file);
                        ok = false;
                    } else if (!file.canRead()) {
                        System.out.println("WARNING: Unreadable file: " + file);
                        ok = false;
                    } else {
                        // Assume the file is an ATM file, so subtract the 22 byte header,
                        // then round up to sectors
                        numSectors += ((file.length() - 22) + 0xFF) >> 8;
                        paths.remove(file.toPath());
                    }
                }
                if (ok) {
                    item.setEstimatedDiskSectors(numSectors);
                } else {
                    System.out.println("WARNING: Dropping title from all builds because it's incomplete: " + item);
                    itemIterator.remove();
                }
            }
            banner("Checking the for unreferenced files");
            for (Path path : paths) {
                System.out.println(path.toString().substring(archiveDir.getPath().toString().length() + 1));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    // Check 12K compatibility
    private void check12KCompatibility(List<AtomTitle> items) {
        banner("Checking 12K Compatibility");
        for (AtomTitle item : items) {
            boolean ok = true;
            boolean warn = true;
            for (String filename : item.getFilenames()) {
                File file = new File(new File(archiveDir, item.getDir()), filename);
                try {
                    ATMFile atm = new ATMFile(file);
                    if (atm.isAtm()) {
                        int start = atm.getLoadAddr();
                        int end = atm.getLoadAddr() + atm.getLength();
                        if (!((start >= 0x0000 && end <= 0x0400) ||
                              (start >= 0x2800 && end <= 0x3C00) ||
                              (start >= 0x8000 && end <= 0x9800) ||
                              (start >= 0xa000 && end <= 0xb000 && item.getChunk().equals(IFileGenerator.ROMS_CHUNK)))) {
                            if (item.isCompatible12K() && !atm.isGarbageSignature()) {
                                if (warn) {
                                    System.out.println();
                                    System.out.println("WARNING: Compatibility: Title probably should be marked as 32K: "
                                            + item.getChunk() + ": " + item.getPublisher() + " " + item.getTitle() + " "
                                            + item.getIdentifier());
                                }
                                System.out.println("    " + atm.toStringDetailed());
                                warn = false; // don't output further warnings about ths title
                            }
                            ok = false; // title is not OK for 12K Atom
                        }
                    }
                } catch (IOException e) {
                    System.out.println("WARNING: Missing file: " + file);
                }
            }
            // There are a very small number of these
            if (!item.isCompatible12K() && ok) {
                System.out.println();
                System.out.println("WARNING: Compatibility: Title probably wrongly marked as 32K: " + item.getIdentifier() + " " + item.getTitle());
            }
        }
    }

    // Check for garbage signature
    private void checkGarbageSignature(List<AtomTitle> items) {
        banner("Checking files for trailing garbage");
        for (AtomTitle item : items) {
            for (String filename : item.getFilenames()) {
                File file = new File(new File(archiveDir, item.getDir()), filename);
                try {
                    ATMFile atm = new ATMFile(file);
                    if (atm.isGarbageSignature()) {
                        System.out.println("WARNING: Garbage signature detected: " + atm.toStringDetailed() + " "
                                + item.getChunk() + ": " + item.getPublisher() + " " + item.getTitle());
                    }
                } catch (IOException e) {
                    System.out.println("WARNING: Missing file: " + file);
                }
            }
        }
    }

    // Count the number of titles remaining in each chunk
    // (and also create the All chunk)
    private Map<String, Integer> calculateChunkStats(List<AtomTitle> items, String message) {
        Map<String, Integer> chunks = new TreeMap<String, Integer>();
        int total = 0;
        for (AtomTitle item : items) {
            // Count the number of titles in each chunk
            String chunk = item.getChunk();
            Integer count = chunks.get(chunk);
            if (count == null) {
                count = 0;
            }
            chunks.put(chunk, count + 1);
            total++;
        }
        chunks.put(IFileGenerator.ALL_CHUNK, total);
        banner(message);
        for (String chunk : chunks.keySet()) {
            System.out.println(    "Chunk " + chunk + " has " + chunks.get(chunk) + " titles");
        }
        System.out.println(    "Total " + total + " titles");
        return chunks;
    }

    public void generateAll(File catalogCSV, Set<Target> userTargets, String version) {

        banner("Building Atom Software Menus " + version);

        banner("Parsing catalog CSV file");
        SpreadsheetParser parser = new SpreadsheetParser(catalogCSV);
        List<AtomTitle> items = parser.parseSpreadSheet();

        // Drop incomplete titles (where files are missing)
        checkFiles(items);

        Comparator<AtomTitle> customComparator = new Comparator<AtomTitle>() {
            @Override
            public int compare(AtomTitle o1, AtomTitle o2) {
                if (!o1.getChunk().equals(o2.getChunk())) {
                    return o1.getChunk().compareTo(o2.getChunk());
                } else if (!o1.getPublisher().equals(o2.getPublisher())) {
                    return o1.getPublisher().compareTo(o2.getPublisher());
                } else {
                    return o1.getTitle().compareTo(o2.getTitle());
                }
            };
        };

        List<AtomTitle> sortedItems = new ArrayList<AtomTitle>(items);
        sortedItems.sort(customComparator);

        // Produce WARNINGs for titles are missing 32K Ram = YES tags in the spreadsheet
        check12KCompatibility(sortedItems); // Use SortedItems so WARNINGs in sensible order

        // Produce WARNINGs for titles that might have garbage on the end
        checkGarbageSignature(sortedItems); // Use SortedItems so WARNINGs in sensible order

        // Compute initial stats of sizes of each chunks
        Map<String, Integer> initialChunkStats = calculateChunkStats(items, "Master stats");

        // Names of the chunks A, B, C, D, ....
        Collection<String> chunkNames = initialChunkStats.keySet();

        // Number of chunks
        int numChunks = chunkNames.size();

        // Iterate through the targets
        for (Target target : Target.values()) {

            // Build the user specified targets
            if (!userTargets.isEmpty() && !userTargets.contains(target)) {
                continue;
            }

            try {

                // Copy the master list, as the target may drop items
                List<AtomTitle> targetItems = new ArrayList<AtomTitle>(items);

                banner("Generating " + target.name());

                IArchiveGenerator generator = archiveGeneratorFactory(target, numChunks);

                File bootLoaderBinary = new File(archiveDir, "BOOT.bin");

                // GOSDC uses a different ROM boot loader
                File romBootLoaderBinary;
                if (target == Target.GOSDC) {
                    romBootLoaderBinary = new File(archiveDir, "BOOTROMGOSDC.bin");
                } else {
                    romBootLoaderBinary = new File(archiveDir, "BOOTROM.bin");
                }

                // Give the generator the opportunity to drop titles it deems are unsupported
                generator.filterTitles(targetItems);

                // Give the generator the opportunity to map titles to disk images
                generator.allocateDisks(targetItems);

                // Recalculate sizes of each chunks
                Map<String, Integer> chunkStats = calculateChunkStats(targetItems, target.name() + " stats");

                IFileGenerator splashGen = new GenerateSplashFiles(archiveDir, version, chunkStats, target);
                splashGen.generateFiles(null);

                // Each menu chapter will be a separate disk
                for (String chunk : chunkNames) {
                    File menuDir = new File(archiveDir, menuBase + chunk);
                    menuDir.mkdirs();
                    List<AtomTitle> chunkItems = new ArrayList<AtomTitle>();
                    for (AtomTitle item : targetItems) {
                        if (item.getChunk().equals(chunk) || chunk.equals(IFileGenerator.ALL_CHUNK)) {
                            chunkItems.add(item);
                        }
                    }
                    IFileGenerator bootstrapGen = new GenerateBootstrapFiles(menuDir, bootLoaderBinary, romBootLoaderBinary, target);
                    bootstrapGen.generateFiles(chunkItems);
                    IFileGenerator menuGen = new GenerateMenuFiles(archiveDir, menuDir, chunk, target);
                    menuGen.setDebug(true);
                    menuGen.generateFiles(chunkItems);
                }

                banner("Generating Files for " + target.name());

                generator.generateFiles(targetItems);
                generator.writeImage();
                generator.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        banner("Building Atom Software Menus Complete");
    }

    public static final void main(String[] args) {
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

        Set<Target> userTargets = new HashSet<Target>();
        if (args.length == 4) {
            for (String target : args[3].split(",")) {
                // Throws a IllegalArgumentException exception if not found which is fine
                userTargets.add(Target.valueOf(target.strip().toUpperCase()));
            }
        }

        GenerateAll top = new GenerateAll(archiveDir, menuBase);

        top.generateAll(catalogCSV, userTargets, version);

    }

}
