package uk.co.acornatom.menu;

import java.util.HashSet;
import java.util.List;
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
    private String compatible;
    private String joystick;
    private List<String> collections;
    private String genre;

    private List<String> filenames;
    private Set<String> runnables = new HashSet<String>();
    private Set<String> loadables = new HashSet<String>();

    // These are part of AtomTitle and and filled in as the indexes are built
    private int absoluteAddress;


    // These other computed things
    private boolean compatible12K;
    private boolean fpROM;
    private int estimatedDiskSectors;
    private Integer diskNo;


    public AtomTitle() {
        diskNo = null;
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

    public void setCompatible(String compatible) {
        this.compatible = compatible;
    }

    public String getCompatible() {
        return compatible;
    }

    public void setShortPublisher(String shortPublisher) {
        this.shortPublisher = shortPublisher;
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
        return compatible12K;
    }

    public void setCompatible12K(boolean compatible12K) {
        this.compatible12K = compatible12K;
    }

    @Override
    public String toString() {
        return this.chunk + " " + this.publisher + " " + this.title + " (" + this.identifier + ")";
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

    public boolean isFpROM() {
        return fpROM;
    }

    public void setFpROM(boolean fpROM) {
        this.fpROM = fpROM;
    }


}
