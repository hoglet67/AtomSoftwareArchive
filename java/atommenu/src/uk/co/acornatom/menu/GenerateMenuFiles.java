package uk.co.acornatom.menu;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class GenerateMenuFiles extends GenerateBase {

	Comparator<String> intuitiveStringComparator = new IntuitiveStringComparator<String>();

	Map<String, Integer> shortPublishers = new LinkedHashMap<String, Integer>();

	Map<String, Integer> publishers = new TreeMap<String, Integer>();
	Map<String, Integer> genres = new TreeMap<String, Integer>(); 
	Map<String, Integer> collections = new TreeMap<String, Integer>(intuitiveStringComparator); 
	int maxTitleLen;
	int maxGenreLen;
	int maxShortPublisherLen;
	int maxPublisherLen;
	int maxCollectionLen;

	private void dumpIndexes(String type, Map<String, Integer> map) {
		System.out.println("==========================================================");
		System.out.println(type);
		System.out.println("==========================================================");
		for (Map.Entry<String, Integer> entry : map.entrySet()) {
			System.out.println(entry.getValue() + "\t" + entry.getKey());
		}
	}
	
	private void addToIndex(String value, Map<String, Integer> map) {
		map.put(value, -1);		
	}
	private void assignIndexes(Map<String, Integer> map) {
		int index = 0;
		for (String key : map.keySet()) {
			map.put(key, index++);
		}
	}

	public void generateFiles(File menuDir, File bootLoaderBinary, List<SpreadsheetTitle> items) throws IOException {

		// ------------------------------------------------------------------------------------
		// Process the spreadsheet items to generate IDs for Publishers, Genres and Collections
		// ------------------------------------------------------------------------------------

		HashMap<String, String> longPubShortPub = new HashMap<String, String>();
		
		publishers.clear();
		// addToIndex("", publishers);
		genres.clear(); 
		// addToIndex("", genres);
		collections.clear(); 
		// addToIndex("", collections);
		
		maxCollectionLen = 0;
		maxGenreLen = 0;
		maxPublisherLen = 0;
		maxShortPublisherLen = 0;
		maxTitleLen = 0;
		
		for (SpreadsheetTitle item : items) {
			if (item.isPresent()) {
				if (item.getTitle().length() > maxTitleLen) {
					maxTitleLen = item.getTitle().length();
				}
				if (item.getPublisher().length() > maxPublisherLen) {
					maxPublisherLen = item.getPublisher().length();
				}
				if (item.getShortPublisher().length() > maxShortPublisherLen) {
					maxShortPublisherLen = item.getShortPublisher().length();
				}
				if (item.getGenre().length() > maxGenreLen) {
					maxGenreLen = item.getGenre().length();
				}
				if (item.getCollection().length() > maxCollectionLen) {
					maxCollectionLen = item.getCollection().length();
				}
				
				addToIndex(item.getPublisher(), publishers);
				addToIndex(item.getGenre(), genres);
				addToIndex(item.getCollection(), collections);
				longPubShortPub.put(item.getPublisher(), item.getShortPublisher());
			}
		}
		assignIndexes(publishers);			
		assignIndexes(genres);
		assignIndexes(collections);

		// Build the short publisher map so the key order is the same as the long publisher
		shortPublishers.clear();
		for (String key : publishers.keySet()) {
			if (longPubShortPub.containsKey(key)) {
				shortPublishers.put(longPubShortPub.get(key), publishers.get(key));
			}
		}
		
		dumpIndexes("ShortPublishers", shortPublishers);			
		dumpIndexes("Publishers", publishers);			
		dumpIndexes("Genres", genres);
		dumpIndexes("Collections", collections);

		List<AtomTitle> atomTitles = new ArrayList<AtomTitle>();
		for (SpreadsheetTitle item : items) {			
			if (item.isPresent()) {
				AtomTitle atomTitle = new AtomTitle();
				atomTitle.setTitle(item.getTitle());
				atomTitle.setIndex(item.getIndex());
				atomTitle.setShortPublisher(item.getShortPublisher());
				atomTitle.setPublisher(item.getPublisher());
				atomTitle.setPublisherId(publishers.get(item.getPublisher()));
				atomTitle.setGenre(item.getGenre());
				atomTitle.setGenreId(genres.get(item.getGenre()));
				atomTitle.setCollection(item.getCollection());
				atomTitle.setCollectionId(collections.get(item.getCollection()));
				if (atomTitle.getCollectionId() != 0) {
					atomTitle.setType(AtomTitle.TYPE_CHILD);					
				} else {
					atomTitle.setType(AtomTitle.TYPE_NORMAL);										
				}
				atomTitles.add(atomTitle);
			}
		}


		// ------------------------------------------------------------------------------------
		// Sort by title for the main table
		// ------------------------------------------------------------------------------------

		Collections.sort(atomTitles, new TitleOrderSort());
		dumpTitles("TitleOrderSort", atomTitles);

		
		// ------------------------------------------------------------------------------------
		// Set the locations for the tables
		// ------------------------------------------------------------------------------------

		// Place the main, publisher, genre and collection tables in the Atom's upper text space
		int menuAddrBase = 0x8200;

		// Allow space for pointers to 5 tables
		int menuAddr = menuAddrBase + 10;

		// Place the sort tables in the Atom's lower text space
		// The size of these tables is predictable: 2x (number of titles + 2)
		int sortAddrBase = (0x3B - (((atomTitles.size() + 2) * 8) / 256)) * 256;		

		int sortAddr = sortAddrBase + 8;

		// ------------------------------------------------------------------------------------
		// Generate the data for the main table
		// ------------------------------------------------------------------------------------
			
		byte[] mainTable = createMainTable(menuAddr, atomTitles);
		menuAddr += mainTable.length;

		// ------------------------------------------------------------------------------------
		// Generate the data for the sort tables
		//
		// these reside in the Atom lower text space
		//
		// a side effect of generating these is that the publisher/genres/collections maps are
		// updated with the address in the sort table of the first occurrence of the each
		// publisher/genre/collection
		// ------------------------------------------------------------------------------------

		byte[] titleSortTable = createSortTable("Title Sort", sortAddr, atomTitles, new TitleOrderSort(), null);		
		sortAddr += titleSortTable.length;
		
		List<AtomTitle> publisherSortList = new ArrayList<AtomTitle>(atomTitles);
		byte[] publisherSortTable = createSortTable("Publisher Sort", sortAddr, publisherSortList, new PublisherOrderSort(), publishers);
		sortAddr += publisherSortTable.length;
		
		List<AtomTitle> genreSortList = new ArrayList<AtomTitle>(atomTitles);
		byte[] genreSortTable = createSortTable("Genre Sort", sortAddr, genreSortList, new GenreOrderSort(), genres);		
		sortAddr += genreSortTable.length;

		List<AtomTitle> collectionSortList = new ArrayList<AtomTitle>(atomTitles);
		byte[] collectionSortTable = createSortTable("Collection Sort", sortAddr, collectionSortList, new CollectionOrderSort(), collections);
		sortAddr += collectionSortTable.length;

		// ------------------------------------------------------------------------------------
		// Generate the Secondary Tables (Publisher, Genre, Collections)
		//
		// these reside in the Atom higher text space
		// ------------------------------------------------------------------------------------

		byte[] shortPublisherTable = createSecondaryTable("ShortPublisher", menuAddr, shortPublishers, null, null);
		menuAddr += shortPublisherTable.length;

		byte[] publisherTable = createSecondaryTable("Publisher", menuAddr, publishers, publisherSortList, new IFieldSelector() {
			@Override
			public String getField(AtomTitle title) {
				return title.getPublisher();
			}
		});
		menuAddr += publisherTable.length;

		byte[] genreTable = createSecondaryTable("Genre", menuAddr, genres, genreSortList, new IFieldSelector() {
			@Override
			public String getField(AtomTitle title) {
				return title.getGenre();
			}
		});		
		menuAddr += genreTable.length;
		
		byte[] collectionsTable = createSecondaryTable("Collection", menuAddr, collections, collectionSortList, new IFieldSelector() {
			@Override
			public String getField(AtomTitle title) {
				return title.getCollection();
			}
		});
		menuAddr += collectionsTable.length;

		// ------------------------------------------------------------------------------------
		// Sanity check the end addresses
		// ------------------------------------------------------------------------------------

		if (menuAddr > 0x9800) {
			throw new RuntimeException("Menu data overflow");			
		}

		if (sortAddr > 0x3C00) {
			throw new RuntimeException("Sort data overflow");			
		}

		if (sortAddr < 0x3B00) {
			throw new RuntimeException("Sort data underflow");			
		}

		// ------------------------------------------------------------------------------------
		// Write the tables as Atom Files
		// ------------------------------------------------------------------------------------

		writeTables(menuDir, "MENUDAT", menuAddrBase, new byte[][] { mainTable, shortPublisherTable, publisherTable, genreTable, collectionsTable});
		writeTables(menuDir, "SORTDAT", sortAddrBase, new byte[][] { titleSortTable, publisherSortTable, genreSortTable, collectionSortTable});
		
		// ------------------------------------------------------------------------------------
		// Write out the sort tables individually
		// ------------------------------------------------------------------------------------
		
		sortAddrBase = (0x3B - (((atomTitles.size() + 2) * 2) / 256)) * 256;		
		writeTable(menuDir, "SORTDAT0", sortAddrBase, titleSortTable);
		writeTable(menuDir, "SORTDAT1", sortAddrBase, publisherSortTable);
		writeTable(menuDir, "SORTDAT2", sortAddrBase, genreSortTable);
		writeTable(menuDir, "SORTDAT3", sortAddrBase, collectionSortTable);
		
	}
	
	private void writeTables(File menuDir, String name, int loadAddr, byte[][] tables) throws IOException {
		System.out.println("----------------------------------------");
		System.out.println("Atom file: " + name);
		System.out.println("----------------------------------------");
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		int addr =  loadAddr + 2 * tables.length;
		for (byte[] table : tables) {
			writeShort(bos, addr);
			addr += table.length;
		}
		for (byte[] table : tables) {
			bos.write(table);			
		}
		FileOutputStream fosSort = new FileOutputStream(new File(menuDir, name));
		writeATMFile(fosSort, name, loadAddr, loadAddr, bos.toByteArray());
		fosSort.close();
		System.out.println("start address " + Integer.toHexString(loadAddr));
		System.out.println("  end address " + Integer.toHexString(loadAddr + bos.size()));
		System.out.println("       length " + bos.size() + " bytes");
	}

	private void writeTable(File menuDir, String name, int loadAddr, byte[] table) throws IOException {
		System.out.println("----------------------------------------");
		System.out.println("Atom file: " + name);
		System.out.println("----------------------------------------");
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		bos.write(table);			
		FileOutputStream fosSort = new FileOutputStream(new File(menuDir, name));
		writeATMFile(fosSort, name, loadAddr, loadAddr, bos.toByteArray());
		fosSort.close();
		System.out.println("start address " + Integer.toHexString(loadAddr));
		System.out.println("  end address " + Integer.toHexString(loadAddr + bos.size()));
		System.out.println("       length " + bos.size() + " bytes");
	}
	
	private byte[] createMainTable(int absoluteAddress, List<AtomTitle> items) throws IOException {
		System.out.println("----------------------------------------");
		System.out.println("Main Table");
		System.out.println("----------------------------------------");
		System.out.println("address " + Integer.toHexString(absoluteAddress));
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		for (AtomTitle item : items) {
			item.setAbsoluteAddress(absoluteAddress + bos.size());
			writeShort(bos, item.getIndex() + (item.getGenreId() << 10));
			writeByte(bos, item.getPublisherId());
			writeByte(bos, item.getCollectionId());
			writeString(bos, item.getTitle());
			writeByte(bos, 13);
		}
		System.out.println("length " + bos.size() + " bytes");
		return bos.toByteArray();
	}
	
	
	private byte[] createSecondaryTable(String tableName, int absoluteAddress, Map<String, Integer> map, List<AtomTitle> sort, IFieldSelector fieldSelector) throws IOException {
		System.out.println("----------------------------------------");
		System.out.println("Secondary Table: " + tableName);
		System.out.println("----------------------------------------");
		System.out.println("address " + Integer.toHexString(absoluteAddress));
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		absoluteAddress += map.size() * 2 + 4; // Skip over the pointers plus the length and terminator			
		writeShort(bos, map.size());
		for (Map.Entry<String, Integer> entry : map.entrySet()) {
			writeShort(bos, absoluteAddress);
			absoluteAddress += (sort != null ? 4 : 0) + entry.getKey().length() + 1;
		}
		writeShort(bos, 0xFFFF);
		for (Map.Entry<String, Integer> entry : map.entrySet()) {
			if (sort != null) {
				// Find the first index of this secondary key in the specifed sort table
				int firstIndex = -1;
				int lastContigIndex = -1;
				int lastIndex = -1;
				for (int i = 0; i < sort.size(); i++) {
					boolean match = fieldSelector.getField(sort.get(i)).equals(entry.getKey());
					if (firstIndex == -1) {
						if (match) {
							firstIndex = i;
						}
					} else if (lastContigIndex == -1) {
						if (!match) {
							lastContigIndex = i - 1;
						}
					}
					if (match) {
						lastIndex = i;
					}
				}
				if (lastContigIndex == -1) {
					lastContigIndex = lastIndex;
				}
				if (firstIndex != -1 && lastIndex != lastContigIndex) {
					dumpTitles(tableName, sort);
					throw new RuntimeException("Entries for " + tableName + " " + entry.getKey() + " are not contiguous");
				}
				System.out.println(entry.getKey() + " spans indexes " + firstIndex + "..." + lastIndex);
				writeShort(bos, lastIndex + 1 - firstIndex);
				writeShort(bos, firstIndex);
			}
			writeString(bos, entry.getKey());
			writeByte(bos, 13);
		}
		System.out.println("length " + bos.size() + " bytes");
		return bos.toByteArray();
	}

	private byte[] createSortTable(String tableName, int absoluteAddress, List<AtomTitle> items, Comparator<AtomTitle> comparator, Map<String, Integer> map) throws IOException {
		System.out.println("----------------------------------------");
		System.out.println("Sort Table: " + tableName);
		System.out.println("----------------------------------------");
		System.out.println("address " + Integer.toHexString(absoluteAddress));
		// Sort items using the supplier comparator
		Collections.sort(items, comparator);
		// Build the data for the table
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		writeShort(bos, items.size());
		for (AtomTitle item : items) {
			writeShort(bos, item.getAbsoluteAddress());
		}
		writeShort(bos, 0xFFFF);
		System.out.println("length " + bos.size() + " bytes");
		return bos.toByteArray();
	}
	
	private String getKey(int value, Map<String, Integer> map) {
		for (Map.Entry<String, Integer> entry : map.entrySet()) {
			if (entry.getValue().equals(value)) {
				return entry.getKey();
			}
		}
		return null;
	}
	
	private String pad(String s, int width) {
		if (s == null) {
			s = "*NULL*";
		}
		if (s.length() > width) {
			return s.substring(0, width);
		} else {
			StringBuffer sb = new StringBuffer(width);
			sb.append(s);
			for (int i = s.length(); i < width; i++) {
				sb.append(" ");
			}
			return sb.toString();
		}
	}
	
	public void dumpTitles(String type, List<AtomTitle> items) {
		System.out.println("==========================================================");
		System.out.println(type);
		System.out.println("==========================================================");
		for (AtomTitle item : items) {
			System.out.println(item.getType() + " " 
					+ pad(item.getTitle(), maxTitleLen + 4) + " " 
					+ pad(getKey(item.getPublisherId(), shortPublishers), maxShortPublisherLen + 4) + " "
					+ pad(getKey(item.getPublisherId(), publishers), maxPublisherLen + 4) + " "
					+ pad(getKey(item.getGenreId(), genres), maxGenreLen + 4) + " " 
					+ pad(getKey(item.getCollectionId(), collections), maxCollectionLen + 4));
		}
	}
	
	public class TitleOrderSort implements Comparator<AtomTitle> {
		@Override
		public int compare(AtomTitle o1, AtomTitle o2) {
			return o1.getTitle().compareTo(o2.getTitle());
		}
	}
	
	public abstract class ComparatorBase implements Comparator<AtomTitle> {
		public int compareWithZeroLast(int o1, int o2) {
			if (o1 == 0) {
				o1 = Integer.MAX_VALUE;
			}
			if (o2 == 0) {
				o2 = Integer.MAX_VALUE;
			}
			return o1 - o2;
		}
	}

	public class CollectionOrderSort extends ComparatorBase  {
		@Override
		public int compare(AtomTitle o1, AtomTitle o2) {
			int ret = compareWithZeroLast(o1.getCollectionId(), o2.getCollectionId());
			return ret != 0 ? ret : o1.getTitle().compareTo(o2.getTitle());
		}
	}

	public class GenreOrderSort extends ComparatorBase implements Comparator<AtomTitle> {
		@Override
		public int compare(AtomTitle o1, AtomTitle o2) {
			int ret = o1.getGenreId() - o2.getGenreId();
			return ret != 0 ? ret : o1.getTitle().compareTo(o2.getTitle());
		}
	}

	public class PublisherOrderSort extends ComparatorBase  {
		@Override
		public int compare(AtomTitle o1, AtomTitle o2) {
			int ret = o1.getPublisherId() - o2.getPublisherId();
			return ret != 0 ? ret : o1.getTitle().compareTo(o2.getTitle());
		}
	}
}
