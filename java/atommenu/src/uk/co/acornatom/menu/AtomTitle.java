package uk.co.acornatom.menu;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class AtomTitle {

    public static int TYPE_NORMAL = 0;
    public static int TYPE_GROUP = 1;
    public static int TYPE_CHILD = 2; // Not sure this is necessary

    private String title;
    private int index;
    private int publisherId;
    private int genreId;
    private int compatibleId;
    private int versionId;
    private List<Integer> collectionIds;
    private String publisher;
    private String shortPublisher;
    private String genre;
    private String compatible;
    private String version;
    private List<String> collections;
    private int absoluteAddress;

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public void setIndex(int index) {
        this.index = index;
    }

    public int getIndex() {
        return index;
    }

    public void setGenreId(int genreId) {
        this.genreId = genreId;
    }

    public int getGenreId() {
        return genreId;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getGenre() {
        return genre;
    }

    public void setPublisherId(int publisherId) {
        this.publisherId = publisherId;
    }

    public int getPublisherId() {
        return publisherId;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setCompatibleId(int compatibleId) {
        this.compatibleId = compatibleId;
    }

    public int getCompatibleId() {
        return compatibleId;
    }

    public void setCompatible(String compatible) {
        this.compatible = compatible;
    }

    public String getCompatible() {
        return compatible;
    }

    public void setVersionId(int versionId) {
        this.versionId = versionId;
    }

    public int getVersionId() {
        return versionId;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getVersion() {
        return version;
    }

    public void setCollections(List<String> collections, Map<String, Integer> collectionMap) {
        this.collections = collections;
        this.collectionIds = new ArrayList<Integer>();
        for (String collection : collections) {
            this.collectionIds.add(collectionMap.get(collection));
        }
    }

    public List<String> getCollections() {
        return collections;
    }

    public List<Integer> getCollectionIds() {
        return collectionIds;
    }

    public void setAbsoluteAddress(int absoluteAddress) {
        this.absoluteAddress = absoluteAddress;
    }

    public int getAbsoluteAddress() {
        return absoluteAddress;
    }

    public void setShortPublisher(String shortPublisher) {
        this.shortPublisher = shortPublisher;
    }

    public String getShortPublisher() {
        return shortPublisher;
    }
}
