package uk.co.acornatom.menu;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import au.com.bytecode.opencsv.CSVReader;

public class SpreadsheetParser {

    private static final String STATUS_PRESENT = "present";

    private static final String GENRE = "genre";
    private static final String COLLECTION = "collection";
    private static final String PUBLISHER = "publisher";
    private static final String BOOT = "boot";
    private static final String STATUS = "status";
    private static final String RUN = "run";
    private static final String DIRECTORY = "directory";
    private static final String TITLE = "title";
    private static final String IDENTIFIER = "index";
    private static final String CHUNK = "chunk";
    private static final String FILENAMES = "filenames";
    private static final String UPDATED = "updated";
    private static final String RAM32K = "32k";
    private static final String JOYSTICK = "joystick";
    private static final String FP = "fp";
    private static final String PCHARME = "pcharme";
    private static final String GAGS = "gags";
    private static final String AXR1 = "axr";
    private static final String WEROM = "werom";
    private static final String PPTOOLKIT = "pptoolkit";

    private File file;

    private Set<String> filesPaths = new HashSet<String>();

    private int numTitles = 0;
    private int titleTotalChars = 0;
    private Map<String, Integer> countsByPublisher = new TreeMap<String, Integer>();

    public SpreadsheetParser(File file) {
        this.file = file;
    }

    public List<AtomTitle> parseSpreadSheet() {
        List<AtomTitle> items = new ArrayList<AtomTitle>();
        CSVReader csvReader = null;
        try {
            resetStats();

            csvReader = new CSVReader(new FileReader(file));

            List<String[]> programs = csvReader.readAll();

            String[] headers = programs.remove(0);
            int identifier_column = -1;
            int chunk_column = -1;
            int title_column = -1;
            int status_column = -1;
            int dir_column = -1;
            int run_column = -1;
            int boot_column = -1;
            int publisher_column = -1;
            int collection_column = -1;
            int genre_column = -1;
            int filenames_column = -1;
            int updated_column = -1;
            int ram32k_column = -1;
            int joystick_column = -1;
            int fp_column = -1;
            int pcharme_column = -1;
            int gags_column = -1;
            int axr1_column = -1;
            int werom_column = -1;
            int pptoolkit_column = -1;


            for (int i = 0; i < headers.length; i++) {
                if (headers[i].toLowerCase().contains(IDENTIFIER)) {
                    identifier_column = i;
                }
                if (headers[i].toLowerCase().contains(CHUNK)) {
                    chunk_column = i;
                }
                if (headers[i].toLowerCase().contains(TITLE)) {
                    title_column = i;
                }
                if (headers[i].toLowerCase().contains(DIRECTORY)) {
                    dir_column = i;
                }
                if (headers[i].toLowerCase().contains(RUN)) {
                    run_column = i;
                }
                if (headers[i].toLowerCase().contains(STATUS)) {
                    status_column = i;
                }
                if (headers[i].toLowerCase().contains(BOOT)) {
                    boot_column = i;
                }
                if (headers[i].toLowerCase().contains(PUBLISHER)) {
                    publisher_column = i;
                }
                if (headers[i].toLowerCase().contains(COLLECTION)) {
                    collection_column = i;
                }
                if (headers[i].toLowerCase().contains(GENRE)) {
                    genre_column = i;
                }
                if (headers[i].toLowerCase().contains(FILENAMES)) {
                    filenames_column = i;
                }
                if (headers[i].toLowerCase().contains(UPDATED)) {
                    updated_column = i;
                }
                if (headers[i].toLowerCase().contains(RAM32K)) {
                    ram32k_column = i;
                }
                if (headers[i].toLowerCase().contains(JOYSTICK)) {
                    joystick_column = i;
                }
                if (headers[i].toLowerCase().startsWith(FP)) {
                    fp_column = i;
                }
                if (headers[i].toLowerCase().startsWith(PCHARME)) {
                    pcharme_column = i;
                }
                if (headers[i].toLowerCase().startsWith(GAGS)) {
                    gags_column = i;
                }
                if (headers[i].toLowerCase().startsWith(AXR1)) {
                    axr1_column = i;
                }
                if (headers[i].toLowerCase().startsWith(WEROM)) {
                    werom_column = i;
                }
                if (headers[i].toLowerCase().startsWith(PPTOOLKIT)) {
                    pptoolkit_column = i;
                }
            }

            for (String[] program : programs) {
                AtomTitle item = new AtomTitle();

                // Status
                String status = program[status_column].trim();
                if (!status.equalsIgnoreCase(STATUS_PRESENT)) {
                    continue;
                }

                // Identifier
                String identifier = program[identifier_column].trim();
                item.setIdentifier(Integer.parseInt(identifier));

                // Chunk
                String chunk = program[chunk_column].trim().toUpperCase();
                item.setChunk(chunk);

                // Title
                String title = program[title_column].trim().toUpperCase();
                item.setTitle(title);

                // Directory
                String dir = program[dir_column].trim();
                item.setDir(dir);

                // Run commands
                String run = program[run_column].trim();
                item.setRun(run);

                // Boot address
                String boot = program[boot_column].trim();
                item.setBoot(boot);

                // Publisher
                String publisher = program[publisher_column].trim().toUpperCase();
                item.setPublisher(publisher);

                // Collections
                String[] collections = program[collection_column].trim().toUpperCase().split("\n");
                List<String> collectionsList = new ArrayList<String>();
                for (String collection : collections) {
                    collection = collection.trim();
                    if (collection.length() > 0) {
                        collectionsList.add(collection);
                    }
                }
                item.setCollections(collectionsList);

                // Genre
                String genre = program[genre_column].trim().toUpperCase();
                item.setGenre(genre);

                // Filenames
                String[] filenames = program[filenames_column].trim().toUpperCase().split("\n");
                List<String> filesnamesList = new ArrayList<String>();
                for (String filename : filenames) {
                    filename = filename.trim();
                    filesnamesList.add(filename);
                    String path = dir + "/" + filename;
                    if (!filesPaths.add(path)) {
                        System.out.println("WARNING: File shared between titles: " + path);
                    }
                }
                item.setFilenames(filesnamesList);

                // RamDependency
                String ram32K = program[ram32k_column].trim().toUpperCase();
                item.setCompatible12K(!ram32K.startsWith("YES"));
                if (item.isAGD()) {
                    item.setRamDependency("32K+8K");
                } else if (item.isCompatible12K()) {
                    item.setRamDependency("6K+6K");
                } else if (item.getTitle().contains("16K")) {
                    item.setRamDependency("16K+6K");
                } else {
                    item.setRamDependency("32K+6K");
                }

                // Version
                String version = program[updated_column].trim().toUpperCase();
                // Collapse V8, V8B1, V8B2, etc down to V8
                if (version.length() > 3) {
                    // This is a bit fragile!
                    version = version.substring(0, version.length() - 2);
                }
                item.setVersion(version);

                // Joystick
                String joystick = program[joystick_column].trim().toUpperCase();
                if (joystick.isBlank()) {
                    if (item.getChunk().equals(IFileGenerator.AGD_CHUNK)) {
                        item.setJoystick("BOTH");
                    } else {
                        item.setJoystick("NONE");
                    }
                } else {
                    item.setJoystick(joystick);
                }

                // FP ROM
                String fp = program[fp_column].trim().toUpperCase();
                if (fp.equals("YES")) {
                    item.setFp(true);
                } else if (fp.equals("NO")) {
                    item.setFp(false);
                }

                // PCharme ROM
                String pcharme = program[pcharme_column].trim().toUpperCase();
                if (pcharme.equals("YES")) {
                    item.setPcharme(true);
                } else if (pcharme.equals("NO")) {
                    item.setPcharme(false);
                }

                // GAGS ROM
                String gags = program[gags_column].trim().toUpperCase();
                if (gags.equals("YES")) {
                    item.setGags(true);
                } else if (gags.equals("NO")) {
                    item.setGags(false);
                }

                // AXR1 ROM
                String axr1 = program[axr1_column].trim().toUpperCase();
                if (axr1.equals("YES")) {
                    item.setAxr1(true);
                } else if (axr1.equals("NO")) {
                    item.setAxr1(false);
                }

                // WEROM ROM
                String werom = program[werom_column].trim().toUpperCase();
                if (werom.equals("YES")) {
                    item.setWerom(true);
                } else if (werom.equals("NO")) {
                    item.setWerom(false);
                }

                // PPTOOLKIT ROM
                String pptoolkit = program[pptoolkit_column].trim().toUpperCase();
                if (pptoolkit.equals("YES")) {
                    item.setPPToolkit(true);
                } else if (pptoolkit.equals("NO")) {
                    item.setPPToolkit(false);
                }

                // Save the item
                items.add(item);
                accumulateStats(item);
            }

            dumpStats();

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (csvReader != null) {
                try {
                    csvReader.close();
                } catch (IOException e) {
                }
            }
        }
        return items;
    }

    public void resetStats() {
        numTitles = 0;
        titleTotalChars = 0;
        countsByPublisher = new TreeMap<String, Integer>();
    }

    public void accumulateStats(AtomTitle item) {

        numTitles++;
        titleTotalChars += item.getTitle().length();
        Integer countByPublisher = countsByPublisher.get(item.getPublisher());
        if (countByPublisher == null) {
            countByPublisher = 1;
        }
        countsByPublisher.put(item.getPublisher(), countByPublisher + 1);
    }

    public void dumpStats() {
        System.out.println("Total Titles = " + numTitles);
        System.out.println("Total Titles Chars = " + titleTotalChars);
        System.out.println("Average Titles Chars = " + ((double) titleTotalChars / (double) numTitles));
        for (Map.Entry<String, Integer> entry : countsByPublisher.entrySet()) {
            System.out.println(entry.getKey() + " " + entry.getValue());
        }
    }

}
