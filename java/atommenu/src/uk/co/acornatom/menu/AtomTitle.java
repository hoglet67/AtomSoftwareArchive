package uk.co.acornatom.menu;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class AtomTitle {

    // These all come from the spreadsheet
    private int identifier;
    private String chunk;
    private String title;
    private String dir;
    private String run;
    private String boot;
    private String publisher;
    private String shortPublisher;
    private String version;
    private String ramDependency;
    private String romDependency;
    private String joystick;
    private List<String> collections;
    private String genre;
    private Boolean fp;
    private Boolean pcharme;
    private Boolean gags;
    private Boolean axr1;
    private Boolean werom;
    private Boolean pptoolkit;
    private Boolean pages98to8F;

    private List<String> filenames;
    private Set<String> runnables = new HashSet<String>();
    private Set<String> loadables = new HashSet<String>();

    // A flag to indicate the title should not be included in the menu
    private Boolean disabled;

    // These are part of AtomTitle and and filled in as the indexes are built
    private int absoluteAddress;

    private int estimatedDiskSectors;
    private Integer diskNo;

    private static Map<String, String> chunkChapterMap = new HashMap<String, String>();

    static {
        chunkChapterMap.put(IFileGenerator.COMM_CHUNK, 		"A");
        chunkChapterMap.put(IFileGenerator.MODERN_CHUNK, 	"B");
        chunkChapterMap.put(IFileGenerator.AGD_CHUNK, 		"C");
        chunkChapterMap.put(IFileGenerator.NON_COMM_CHUNK, 	"D");
        chunkChapterMap.put(IFileGenerator.BOOKS_CHUNK, 	"E");
        chunkChapterMap.put(IFileGenerator.MAGAZINES_CHUNK, "E");
        chunkChapterMap.put(IFileGenerator.ROMS_CHUNK, 		"F");
    }

    public static Map<String, String> longShortPubMap = new HashMap<String, String>();

    static {
        longShortPubMap.put("???", "???");
        longShortPubMap.put("AARDVARK", "AA");
        longShortPubMap.put("ACORNSOFT", "AS");
        longShortPubMap.put("ACORN USER", "AU");
        longShortPubMap.put("A&F S/W", "A&F");
        longShortPubMap.put("AGD", "AGD");
        longShortPubMap.put("A&R S/W", "AR");
        longShortPubMap.put("ASP S/W", "ASP");
        longShortPubMap.put("ATOMIC S/W", "AT");
        longShortPubMap.put("ATOMIC THEORY", "ATAP");
        longShortPubMap.put("ATOM MAGIC BOOK", "AMB");
        longShortPubMap.put("BEARSOFT", "BS");
        longShortPubMap.put("BUG BYTE", "BB");
        longShortPubMap.put("COMP TODAY", "CT");
        longShortPubMap.put("COMPUTER CONCEPTS", "CC");
        longShortPubMap.put("COMPUTERSMITH", "CS");
        longShortPubMap.put("C&VG", "C&VG");
        longShortPubMap.put("DP SAVILLE", "DPS");
        longShortPubMap.put("ECCE PRODS", "ECCE");
        longShortPubMap.put("ECD", "ECD");
        longShortPubMap.put("ELECTROCOMP SUPS", "ES");
        longShortPubMap.put("GETTING ACQUAINTED", "GA");
        longShortPubMap.put("HOBBIT", "HB");
        longShortPubMap.put("HOBBYSCOOP", "HBSC");
        longShortPubMap.put("HOPESOFT", "HS");
        longShortPubMap.put("INFOCOM", "INF");
        longShortPubMap.put("INTERFACE", "TBOI");
        longShortPubMap.put("INUFUTO", "INU");
        longShortPubMap.put("JIM BAGLEY", "JB");
        longShortPubMap.put("JOHN KORTINK", "JK");
        longShortPubMap.put("LARSOFT", "LS");
        longShortPubMap.put("LEE S/W", "LEE");
        longShortPubMap.put("LEVEL 9", "L9");
        longShortPubMap.put("MAGNUS OLSSON", "MO");
        longShortPubMap.put("MICRO MANIA", "MM");
        longShortPubMap.put("NON COMM", "NC");
        longShortPubMap.put("OAK LEAVES", "OL");
        longShortPubMap.put("PCT", "PCT");
        longShortPubMap.put("PCW", "PCW");
        longShortPubMap.put("PEARCE", "PES");
        longShortPubMap.put("PE", "PE");
        longShortPubMap.put("PRACTICAL PROGRAMS", "PPBA");
        longShortPubMap.put("PROCYON", "PROC");
        longShortPubMap.put("PROG POWER", "PP");
        longShortPubMap.put("PRO SOFTWARE", "PS");
        longShortPubMap.put("PSION", "PSI");
        longShortPubMap.put("PUBLISHER", "SHORTPUB");
        longShortPubMap.put("QUODLIBET", "QUO");
        longShortPubMap.put("RAMTRONICS", "RAM");
        longShortPubMap.put("RETRO S/W", "RS");
        longShortPubMap.put("ROSS S/W", "ROSS");
        longShortPubMap.put("SUPERLEX", "SUP");
        longShortPubMap.put("THE ATOM", "TA");
        longShortPubMap.put("TIMEDATA", "TD");
        longShortPubMap.put("WAKE UP YOUR ATOM", "WUYA");
        longShortPubMap.put("WATFORD ELEC", "WE");
        longShortPubMap.put("WILLOW S/W", "WS");
        longShortPubMap.put("YOUR COMPUTER", "YC");
    }

    public AtomTitle() {
        diskNo = null;
        disabled = false;
    }

    public void setIdentifier(int identifier) {
        this.identifier = identifier;
    }

    /* Identifier is a persistent ID, taken from the first column of the spreadsheet */
    public int getIdentifier() {
        return identifier;
    }

    public void setDiskNo(Integer diskNo) {
        this.diskNo = diskNo;
    }

    /* DiskNo can be used by a generate to indicate the disk number on which the title has been mapped */
    public Integer getDiskNo() {
        return diskNo;
    }

    public void setChunk(String chunk) {
        this.chunk = chunk;
        if (!chunkChapterMap.containsKey(chunk)) {
            throw new RuntimeException("Unmapped chunk present in spreadsheet: " + chunk + "; add it to chunkChapterMap!");
        }
    }

    public String getChunk() {
        return chunk;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public void setDir(String dir) {
        this.dir = dir;
    }

    public String getDir() {
        return dir;
    }

    public void setRun(String run) {
        this.run = run;
    }

    public String getRun() {
        return run;
    }

    public void setBoot(String boot) {
        this.boot = boot;
    }

    public String getBoot() {
        return boot;
    }

    public void setPublisher(String publisher) {
        if (publisher.isEmpty()) {
            publisher = "???";
        }
        this.publisher = publisher;
        if (AtomTitle.longShortPubMap.containsKey(publisher)) {
            this.shortPublisher = longShortPubMap.get(publisher);
        } else {
            this.shortPublisher = "???";
            System.out.println("WARNING: Short Published missing for " + publisher);
        }
    }

    public String getPublisher() {
        return publisher;
    }

    public void setCollections(List<String> collections) {
        this.collections = collections;
    }

    public List<String> getCollections() {
        return collections;
    }

    public void setGenre(String genre) {
        if (genre.isEmpty()) {
            genre = "???";
        }
        this.genre = genre;
    }

    public String getGenre() {
        return genre;
    }

    public void setVersion(String version) {
        if (version.isEmpty()) {
            version = "???";
        }
        this.version = version;
    }

    public String getVersion() {
        return version;
    }

    public void setRamDependency(String ramDependency) {
        this.ramDependency = ramDependency;
    }

    public String getRamDependency() {
        return ramDependency;
    }

    public void setRomDependency(String romDependency) {
        this.romDependency = romDependency;
    }

    public String getRomDepencency() {
        return romDependency;
    }

    public String getShortPublisher() {
        return shortPublisher;
    }

    public List<String> getFilenames() {
        return filenames;
    }

    public void setFilenames(List<String> filenames) {
        this.filenames = filenames;
    }

    public Set<String> getRunnables() {
        return runnables;
    }

    public Set<String> getLoadables() {
        return loadables;
    }

    public boolean isCompatible12K() {
        return "6K+6K".equals(ramDependency);
    }

    @Override
    public String toString() {
        return this.getChapter() + " " + this.publisher + " " + this.title + " (" + this.identifier + ") " + this.ramDependency;
    }

    public int getEstimatedDiskSectors() {
        return estimatedDiskSectors;
    }

    public void setEstimatedDiskSectors(int estimatedDiskSectors) {
        this.estimatedDiskSectors = estimatedDiskSectors;
    }

    public int getIndex() {
        if (diskNo != null) {
            return diskNo;     // Use the disk number if it's been set by the generator
        } else {
            return identifier; // Use persistent identifier everywhere else
        }
    }

    public String getCollectionFirst() {
        if (collections.isEmpty()) {
            return null;
        } else {
            return collections.get(0);
        }
    }

    public void setAbsoluteAddress(int absoluteAddress) {
        this.absoluteAddress = absoluteAddress;
    }

    public int getAbsoluteAddress() {
        return absoluteAddress;
    }

    public String getJoystick() {
        return joystick;
    }

    public void setJoystick(String joystick) {
        this.joystick = joystick;
    }

    public Boolean usesFp() {
        return fp;
    }

    public void setFp(Boolean fp) {
        this.fp = fp;
    }

    public Boolean usesPcharme() {
        return pcharme;
    }

    public void setPcharme(Boolean pcharme) {
        this.pcharme = pcharme;
    }

    public Boolean usesGags() {
        return gags;
    }

    public void setGags(Boolean gags) {
        this.gags = gags;
    }

    public Boolean usesAxr1() {
        return axr1;
    }

    public void setAxr1(Boolean axr1) {
        this.axr1 = axr1;
    }

    public Boolean usesWerom() {
        return werom;
    }

    public void setWerom(Boolean werom) {
        this.werom = werom;
    }

    public Boolean usesPPToolkit() {
        return pptoolkit;
    }

    public void setPPToolkit(Boolean pptoolkit) {
        this.pptoolkit = pptoolkit;
    }

    public String getChapter() {
        return chunkChapterMap.get(chunk);
    }

    public boolean isROM() {
        return chunk.equals(IFileGenerator.ROMS_CHUNK);
    }

    public boolean isAGD() {
        return chunk.equals(IFileGenerator.AGD_CHUNK);
    }

    public Boolean usesPages98to8F() {
        return pages98to8F;
    }

    public void setPages98to8F(Boolean ramPages98to8F) {
        this.pages98to8F = ramPages98to8F;
    }

    public boolean isDisabled() {
        return this.disabled;
    }

    public void setDisabled(Boolean disabled) {
        this.disabled = disabled;
    }

}
