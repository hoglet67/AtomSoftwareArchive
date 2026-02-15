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

    private IArchiveGenerator archiveGeneratorFactory(Target target, int numChapters) throws IOException {
        switch (target) {
            case SDDOS2:
                return new GenerateSDDOS2Files(archiveDir, menuBase, numChapters, new File(archiveDir + ".img"));
            case SDDOS3:
                return new GenerateSDDOS3Files(archiveDir, menuBase, numChapters, new File(archiveDir + "_SDDOS3.zip"));
            case  JS:
                return new GenerateJSFiles(archiveDir, menuBase, numChapters, new File(archiveDir + ".js"));
            case ECONET:
                return new GenerateEconetFiles(archiveDir, new File(archiveDir + "_ECONET.zip"), menuBase, numChapters);
            case  GOSDC:
                return new GenerateGoSDCFiles(archiveDir, menuBase, numChapters, new File(archiveDir + ".gosdc"));
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

    // Check Ram compatibility
    private void checkRamCompatibility(List<AtomTitle> items) {
        banner("Checking Ram Compatibility");
        for (AtomTitle item : items) {
            int lower_need = item.getCollections().contains("OZMOO") ? 32 : 6;
            int upper_need = item.isAGD() ? 8 : 6;
            for (String filename : item.getFilenames()) {
                File file = new File(new File(archiveDir, item.getDir()), filename);
                try {
                    ATMFile atm = new ATMFile(file);
                    if (atm.isAtm()) {
                        System.out.println("INFO: RAM Compatibility: Title: " + item + " " + atm);
                        int start = atm.getLoadAddr();
                        int end = atm.getLoadAddr() + atm.getLength();
                        boolean garbage = atm.isGarbageSignature();
                        // Determine whether the title needs more that 6K of upper RAM
                        if (start < 0xA000 && (end > 0x9900 || (end > 0x9800 && !garbage))) {
                            if (upper_need < 8) {
                                upper_need = 8;
                            }
                        }
                        // Determine whether the title needs more that 6K of lower RAM
                        if (start >= 0x0000 && (end <= 0x0400 || (end <= 0x0500 && garbage))) {
                            // File fits in first 1KB which all atoms have so do nothing
                        } else if (start < 0x2800 || (start < 0x8000 && (end > 0x3d00 || (end > 0x3c00 && !garbage)))) {
                            // File uses the region outside the 5KB lower text space
                            if (lower_need < 32) {
                                lower_need = 32;
                            }
                        }
                    }
                } catch (IOException e) {
                    System.out.println("WARNING: Missing file: " + file);
                }
            }
            String need = lower_need + "K+" + upper_need + "K";
            System.out.println("INFO: RAM Compatibility: Title needs " + need + ": " + item);
            if (!need.equals(item.getRamDependency())) {
                System.out.println("WARNING: RAM Compatibility: Title probably should be marked as " + need + ": " + item);
                // TODO: For testing, make it so!
                // item.setRamDependency(need);
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
                                + item);
                    }
                } catch (IOException e) {
                    System.out.println("WARNING: Missing file: " + file);
                }
            }
        }
    }

    // Check for ROM signatures
    private void checkUtilityRomSignatures(List<AtomTitle> items) {
        banner("Checking files for Utility ROMs");
        RomScanner scanner = new RomScanner(archiveDir);
        for (AtomTitle item : items) {
            scanner.scan(item);
        }
    }

    // Count the number of titles remaining in each chapter
    // (and also create the All chapter)
    private Map<String, Integer> calculateChapterStats(List<AtomTitle> items, String message) {
        Map<String, Integer> chapters = new TreeMap<String, Integer>();
        int total = 0;
        for (AtomTitle item : items) {
            // Count the number of titles in each chapter
            String chapter = item.getChapter();
            Integer count = chapters.get(chapter);
            if (count == null) {
                count = 0;
            }
            chapters.put(chapter, count + 1);
            total++;
        }
        chapters.put(IFileGenerator.ALL_CHAPTER, total);
        banner(message);
        for (String chapter : chapters.keySet()) {
            System.out.println(    "Chapter " + chapter + " has " + chapters.get(chapter) + " titles");
        }
        System.out.println(    "Total " + total + " titles");
        return chapters;
    }

    public void generateAll(File catalogCSV, Set<Target> userTargets, String version) {

        banner("Building Atom Software Menus " + version);

        banner("Parsing catalog CSV file");
        SpreadsheetParser parser = new SpreadsheetParser(catalogCSV);
        List<AtomTitle> items = parser.parseSpreadSheet();

        // Drop incomplete titles (where files are missing)
        checkFiles(items);

//        Comparator<AtomTitle> customComparator = Comparator
//                .comparing(AtomTitle::getChunk)
//                .thenComparing(AtomTitle::getPublisher)
//                .thenComparing(AtomTitle::getTitle);

        Comparator<AtomTitle> customComparator = Comparator
                .comparing(AtomTitle::getIdentifier);

        List<AtomTitle> sortedItems = new ArrayList<AtomTitle>(items);
        sortedItems.sort(customComparator);

        // Produce WARNINGs for titles that have incorrect RAM dependency
        checkRamCompatibility(sortedItems); // Use SortedItems so WARNINGs in sensible order

        // Produce WARNINGs for titles that might have garbage on the end
        checkGarbageSignature(sortedItems); // Use SortedItems so WARNINGs in sensible order

        // Test for various Utility ROM signatures
        checkUtilityRomSignatures(sortedItems);

        // Compute initial stats of sizes of each chapters
        Map<String, Integer> initialChapterStats = calculateChapterStats(items, "Master stats");

        // Names of the chapters A, B, C, D, ....
        Collection<String> chapterNames = initialChapterStats.keySet();

        // Number of chapters
        int numChapters = chapterNames.size();

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

                IArchiveGenerator generator = archiveGeneratorFactory(target, numChapters);

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

                // Recalculate sizes of each chapters
                Map<String, Integer> chapterStats = calculateChapterStats(targetItems, target.name() + " stats");

                IFileGenerator splashGen = new GenerateSplashFiles(archiveDir, version, chapterStats, target);
                splashGen.generateFiles(null);

                // Each menu chapter will be a separate disk
                for (String chapter : chapterNames) {
                    File menuDir = new File(archiveDir, menuBase + chapter);
                    menuDir.mkdirs();
                    List<AtomTitle> chapterItems = new ArrayList<AtomTitle>();
                    for (AtomTitle item : targetItems) {
                        if (item.getChapter().equals(chapter) || chapter.equals(IFileGenerator.ALL_CHAPTER)) {
                            chapterItems.add(item);
                        }
                    }
                    IFileGenerator bootstrapGen = new GenerateBootstrapFiles(menuDir, bootLoaderBinary, romBootLoaderBinary, target);
                    bootstrapGen.generateFiles(chapterItems);
                    IFileGenerator menuGen = new GenerateMenuFiles(archiveDir, menuDir, chapter, target);
                    menuGen.setDebug(true);
                    menuGen.generateFiles(chapterItems);
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
