package uk.co.acornatom.tape;
import java.io.File;
import java.io.IOException;

public class AtomInf extends AtomBase {

	File infFile;
	File binFile;
	File dest;
	
	public String toString() {
		return binFile + " -> " + dest;
	}

	public AtomInf(File infFile, File binFile, File dest) throws IOException {
		super(dest);
		this.infFile = infFile;
		this.binFile = binFile;
		this.dest = dest;
		if (!infFile.exists()) {
			throw new IOException("Missing " + infFile);
		}
		if (!binFile.exists()) {
			throw new IOException("Missing " + binFile);
		}
	}

	@Override
	protected void processArchive() throws IOException {
		
		
		
		
		byte[] inf = read(infFile);

		System.out.println(new String(inf));

		
		if (inf[0] != 'T' || inf[1] != 'A' || inf[2] != 'P' || inf[3] != 'E') {
			return;
			// throw new IOException("Malformed INF file: missing TAPE");
		}
		
		int i = 4;
		
		while (i < inf.length && Character.isWhitespace(inf[i])) {
			i++;
		}

		String title;

		int titleLen = -1;

		// Try to parse the optional <title length> <white space>
		// TAPE  5 "INDEX" 8000 8000 NEXT MINICALC
		// but not
		// TAPE 3D-PLOT/PR.JH     2900     C2B2  NEXT SRT9_AM
		
		
		if (Character.isDigit(inf[i])) {
			int titleLenStart = i;
			while (i < inf.length && Character.isDigit(inf[i])) {
				i++;
			}
			if (Character.isWhitespace(inf[i])) {
				int titleLenEnd = i;
				titleLen = Integer.parseInt(new String(inf, titleLenStart, titleLenEnd - titleLenStart));
				while (i < inf.length && Character.isWhitespace(inf[i])) {
					i++;
				}
			} else {
				i = titleLenStart;
			}
		}
				
		if (inf[i] == '"') {

			// Title is quoted, e.g.
			// TAPE "" 2900 2FA6
			// TAPE  5 "CHESS"          8000     8240  NEXT CHESS_1

			i++; // skip the quote
			int titleStart = i;

			int titleEnd;
			if (titleLen >= 0) {
				i += titleLen;
				titleEnd = i;
			} else {			
				while (i < inf.length && inf[i] != '"') {
					i++;
				}
				titleEnd = i;
			}

			if (inf[i] == '"') {
				i++; // skip the quote
			} else {
				throw new IOException("Missing trailing quote");
			}
			title = new String(inf, titleStart, titleEnd - titleStart);

		} else {
						

			// Title is unquoted, e.g.
			// TAPE QUE            2900     C2B2  NEXT ACCOUNT

			int titleStart = i;
			i += 15;		
			int titleEnd = i;
			
			title = new String(inf, titleStart, titleEnd - titleStart).trim();
		}
		
		
		
		while (i < inf.length && Character.isWhitespace(inf[i])) {
			i++;
		}
		int loadStart = i;
		while (i < inf.length && !Character.isWhitespace(inf[i])) {
			i++;
		}
		int loadEnd = i;
		while (i < inf.length && Character.isWhitespace(inf[i])) {
			i++;
		}
		int execStart = i;
		while (i < inf.length && !Character.isWhitespace(inf[i])) {
			i++;
		}
		int execEnd = i;


		if (title.length() == 0) {
			title = "unnamed";
		}
		
		
		int loadAddr = Integer.parseInt(new String(inf, loadStart, loadEnd - loadStart), 16);

		int execAddr = Integer.parseInt(new String(inf, execStart, execEnd - execStart), 16);
		
		byte[] data = read(binFile);
		
		AtomFile file = new AtomFile(dest.getName(), title, loadAddr, execAddr, data);
		
		getFiles().add(file);
	}


}
