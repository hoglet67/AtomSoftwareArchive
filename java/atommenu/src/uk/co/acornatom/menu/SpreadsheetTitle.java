package uk.co.acornatom.menu;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class SpreadsheetTitle {

    private int identifier;
    private Integer diskNo;
    private String chunk;
    private String title;
    private String dir;
    private String run;
    private String boot;
    private String publisher;
    private String shortPublisher;
    private boolean compatible12K;
    private List<String> collections;
    private String genre;
    private List<String> filenames;
    private long estimatedDiskSectors;
    private Set<String> runnables = new HashSet<String>();
    private Set<String> loadables = new HashSet<String>();

    public SpreadsheetTitle() {
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

    public long getEstimatedDiskSectors() {
        return estimatedDiskSectors;
    }

    public void setEstimatedDiskSectors(long estimatedDiskSectors) {
        this.estimatedDiskSectors = estimatedDiskSectors;
    }

}
