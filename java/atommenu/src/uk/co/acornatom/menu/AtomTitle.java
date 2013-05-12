package uk.co.acornatom.menu;

public class AtomTitle {

	public static int TYPE_NORMAL = 0;
	public static int TYPE_GROUP = 1;
	public static int TYPE_CHILD = 2; // Not sure this is necessary

	private int type;
	private String title;
	private int index;
	private int genreId;
	private int publisherId;
	private int collectionId;
	private String genre;
	private String publisher;
	private String shortPublisher;
	private String collection;
	private int absoluteAddress;
	
	public void setType(int type) {
		this.type = type;
	}
	public int getType() {
		return type;
	}
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
	public void setPublisherId(int publisherId) {
		this.publisherId = publisherId;
	}
	public int getPublisherId() {
		return publisherId;
	}
	public void setCollectionId(int collectionId) {
		this.collectionId = collectionId;
	}
	public int getCollectionId() {
		return collectionId;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getGenre() {
		return genre;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setCollection(String collection) {
		this.collection = collection;
	}
	public String getCollection() {
		return collection;
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
