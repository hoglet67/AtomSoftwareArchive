package uk.co.acornatom.menu;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class SpreadsheetTitle implements AtomTitle {

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
    private List<String> collections;
    private String genre;
    private List<String> filenames;
    private Set<String> runnables = new HashSet<String>();
    private Set<String> loadables = new HashSet<String>();

    // These are part of AtomTitle and and filled in as the indexes are built
    private int absoluteAddress;
    private int publisherId;
    private int genreId;
    private int compatibleId;
    private int versionId;
    private List<Integer> collectionIds;


    // These other computed things
    private boolean compatible12K;
    private int estimatedDiskSectors;
    private Integer diskNo;


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

    @Override
    public void setTitle(String title) {
        this.title = title;
    }

    @Override
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

    @Override
    public void setPublisher(String publisher) {
        if (publisher.isEmpty()) {
            publisher = "???";
        }
        this.publisher = publisher;
    }

    @Override
    public String getPublisher() {
        return publisher;
    }

    public void setCollections(List<String> collections) {
        this.collections = collections;
    }

    @Override
    public List<String> getCollections() {
        return collections;
    }

    @Override
    public void setGenre(String genre) {
        if (genre.isEmpty()) {
            genre = "???";
        }
        this.genre = genre;
    }

    @Override
    public String getGenre() {
        return genre;
    }

    @Override
    public void setVersion(String version) {
        if (version.isEmpty()) {
            version = "???";
        }
        this.version = version;
    }

    @Override
    public String getVersion() {
        return version;
    }

    @Override
    public void setCompatible(String compatible) {
        this.compatible = compatible;
    }

    @Override
    public String getCompatible() {
        return compatible;
    }

    @Override
    public void setShortPublisher(String shortPublisher) {
        this.shortPublisher = shortPublisher;
    }

    @Override
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
        this.compatible = compatible12K ? "12K:YES" : "12K:NO";
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

    @Override
    public int getIndex() {
        if (diskNo != null) {
            return diskNo;     // Use the disk number if it's been set by the generator
        } else {
            return identifier; // Use persistent identifier everywhere else
        }
    }

    @Override
    public void setGenreId(int genreId) {
        this.genreId = genreId;
    }

    @Override
    public int getGenreId() {
        return genreId;
    }

    @Override
    public void setPublisherId(int publisherId) {
        this.publisherId = publisherId;
    }

    @Override
    public int getPublisherId() {
        return publisherId;
    }

    @Override
    public void setCompatibleId(int compatibleId) {
        this.compatibleId = compatibleId;
    }

    @Override
    public int getCompatibleId() {
        return compatibleId;
    }


    @Override
    public void setVersionId(int versionId) {
        this.versionId = versionId;
    }

    @Override
    public int getVersionId() {
        return versionId;
    }

    @Override
    public void setCollectionIds(Map<String, Integer> collectionMap) {
        this.collectionIds = new ArrayList<Integer>();
        for (String collection : collections) {
            this.collectionIds.add(collectionMap.get(collection));
        }
    }

    @Override
    public List<Integer> getCollectionIds() {
        return collectionIds;
    }

    @Override
    public String getCollectionFirst() {
        if (collections.isEmpty()) {
            return null;
        } else {
            return collections.get(0);
        }
    }
    @Override
    public void setAbsoluteAddress(int absoluteAddress) {
        this.absoluteAddress = absoluteAddress;
    }

    @Override
    public int getAbsoluteAddress() {
        return absoluteAddress;
    }


}
