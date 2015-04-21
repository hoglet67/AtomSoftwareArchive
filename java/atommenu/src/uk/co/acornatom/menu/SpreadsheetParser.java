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

	private static final String GENRE = "genre";
	private static final String COLLECTION = "collection";
	private static final String PUBLISHER = "publisher";
	private static final String SHORTPUB = "shortpub";
	private static final String BOOT = "boot";
	private static final String STATUS = "status";
	private static final String RUN = "run";
	private static final String DIRECTORY = "directory";
	private static final String TITLE = "title";
	private static final String INDEX = "index";
	private static final String CHUNK = "chunk";
	private static final String FILENAMES = "filenames";

	private File file;

	private Set<String> filesPaths = new HashSet<String>();
	
	private int numTitles = 0;
	private int titleTotalChars = 0;
	private Map<String, Integer> countsByPublisher = new TreeMap<String, Integer>();

	public SpreadsheetParser(File file) {
		this.file = file;
	}

	public List<SpreadsheetTitle> parseSpreadSheet() {
		List<SpreadsheetTitle> items = new ArrayList<SpreadsheetTitle>();
		CSVReader csvReader = null;
		try {
			resetStats();
			
			csvReader = new CSVReader(new FileReader(file));

			List<String[]> programs = csvReader.readAll();

			String[] headers = programs.remove(0);
			int index_column = -1;
			int chunk_column = -1;
			int title_column = -1;
			int status_column = -1;
			int dir_column = -1;
			int run_column = -1;
			int boot_column = -1;
			int publisher_column = -1;
			int shortpub_column = -1;
			int collection_column = -1;
			int genre_column = -1;
			int filenames_column = -1;
			for (int i = 0; i < headers.length; i++) {
				if (headers[i].toLowerCase().contains(INDEX)) {
					index_column = i;
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
				if (headers[i].toLowerCase().contains(SHORTPUB)) {
					shortpub_column = i;
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
			}

			for (String[] program : programs) {
				SpreadsheetTitle item = new SpreadsheetTitle();
				String index = program[index_column].trim();
				item.setIndex(Integer.parseInt(index));
				String chunk = program[chunk_column].trim();
				item.setChunk(chunk);
				String title = program[title_column].trim().toUpperCase();
				item.setTitle(title);
				String dir = program[dir_column].trim();
				item.setDir(dir);
				String run = program[run_column].trim();
				item.setRun(run);
				String status = program[status_column].trim();
				item.setStatus(status);
				String boot = program[boot_column].trim();
				item.setBoot(boot);
				String publisher = program[publisher_column].trim().toUpperCase();
				item.setPublisher(publisher);
				String shortpub = program[shortpub_column].trim().toUpperCase();
				item.setShortPublisher(shortpub);
				String collection = program[collection_column].trim().toUpperCase();
				item.setCollection(collection);
				String genre = program[genre_column].trim().toUpperCase();
				item.setGenre(genre);
				String[] filenames = program[filenames_column].trim().toUpperCase().split("\n");				
				List<String> filesnamesList = new ArrayList<String>();
				for (String filename : filenames) {
					filename = filename.trim();
					filesnamesList.add(filename);
					if (item.isPresent()) {
						String path = dir + "/" + filename;
						if (!filesPaths.add(path)) {
							System.out.println("WARNING: " + path + " already in archive");
						}
					}

				}
				item.setFilenames(filesnamesList);
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

	public void accumulateStats(SpreadsheetTitle item) {
		
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
