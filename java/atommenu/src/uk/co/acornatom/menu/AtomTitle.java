package uk.co.acornatom.menu;

import java.util.List;
import java.util.Map;

public interface AtomTitle {

    void setTitle(String title);

    String getTitle();

    int getIndex();

    void setGenreId(int genreId);

    int getGenreId();

    void setGenre(String genre);

    String getGenre();

    void setPublisherId(int publisherId);

    int getPublisherId();

    void setPublisher(String publisher);

    String getPublisher();

    void setCompatibleId(int compatibleId);

    int getCompatibleId();

    void setCompatible(String compatible);

    String getCompatible();

    void setVersionId(int versionId);

    int getVersionId();

    void setVersion(String version);

    String getVersion();

    void setCollectionIds(Map<String, Integer> collectionMap);

    List<String> getCollections();

    List<Integer> getCollectionIds();

    String getCollectionFirst();

    void setAbsoluteAddress(int absoluteAddress);

    int getAbsoluteAddress();

    void setShortPublisher(String shortPublisher);

    String getShortPublisher();

}