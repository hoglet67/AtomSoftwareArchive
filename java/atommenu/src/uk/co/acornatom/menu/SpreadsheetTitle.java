package uk.co.acornatom.menu;

public class SpreadsheetTitle {

	private static final String STATUS_PRESENT = "present";
	private static final String STATUS_UPDATED = "updated";
	
	private int index;
	private String chunk;
	private String title;
	private String dir;
	private String run;
	private String status;
	private String boot;
	private String publisher;
	private String shortPublisher;
	private String collection;
	private String genre;
	
	public void setIndex(int index) {
		this.index = index;
	}
	public int getIndex() {
		return index;
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
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStatus() {
		return status;
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
	public void setCollection(String collection) {
		if (collection.isEmpty()) {
			collection = "???";
		}
		this.collection = collection;
	}
	public String getCollection() {
		return collection;
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
	public boolean isPresent() {
		return STATUS_PRESENT.equalsIgnoreCase(status) || STATUS_UPDATED.equalsIgnoreCase(status);
	}
	public void setShortPublisher(String shortPublisher) {
		this.shortPublisher = shortPublisher;
	}
	public String getShortPublisher() {
		return shortPublisher;
	}
	
}
