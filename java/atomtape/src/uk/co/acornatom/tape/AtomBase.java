package uk.co.acornatom.tape;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public abstract class AtomBase {

	private File dir;
	private List<AtomFile> files = new ArrayList<AtomFile>();

	public AtomBase(File dir) {
		this.dir = dir;
	}

	protected List<AtomFile> getFiles() {
		return files;
	}
	
	protected abstract void processArchive() throws IOException;
	
	public byte[] read(File file) throws IOException {
		ByteArrayOutputStream ous = null;
		InputStream ios = null;
		try {
			byte[] buffer = new byte[4096];
			ous = new ByteArrayOutputStream();
			ios = new FileInputStream(file);
			int read = 0;
			while ((read = ios.read(buffer)) != -1) {
				ous.write(buffer, 0, read);
			}
		} finally {
			try {
				if (ous != null)
					ous.close();
			} catch (IOException e) {
			}

			try {
				if (ios != null)
					ios.close();
			} catch (IOException e) {
			}
		}
		return ous.toByteArray();
	}
	
	public void generateFiles(boolean writeBAS, boolean writeATM, boolean writeWAV, boolean writeCSW)
			throws IOException {


		if (!dir.exists()) {
			if (!dir.mkdirs()) {
				throw new IOException("Filed to create directory " + dir);
			}
		}
		int count = 1;

		for (AtomFile file : files) {
			if (file.getData().length == 0) {
				System.out.println("# " + file.getTitle());
			} else {

				System.out.println(file);

				if (writeBAS) {
					File basFile = new File(dir, file.getTitleClean() + ".bas");
					if (!basFile.exists()) {
						System.out.println("    ->" + basFile + " ("
								+ file.getTitle() + ")");
						FileOutputStream fos = new FileOutputStream(basFile);
						file.writeBasicFile(fos);
						fos.close();
					}					
				}
				
				if (writeATM) {
					File atmFile = new File(dir, file.getTitleClean());
					if (!atmFile.exists()) {
						System.out.println("    ->" + atmFile + " ("
								+ file.getTitle() + ")");
						FileOutputStream fos = new FileOutputStream(atmFile);
						file.writeATMFile(fos);
						fos.close();
					}
				}

				if (writeWAV) {
					File wavFile = new File(dir, toDecimal(count, 2) + "_"
							+ file.getTitleClean() + ".wav");
					System.out.println("    ->" + wavFile);
					FileOutputStream fos = new FileOutputStream(wavFile);
					file.writeWavFile(fos);
					fos.close();

					// --tt title
					// audio/song title (max 30 chars for version 1 tag)
					//
					// --ta artist
					// audio/song artist (max 30 chars for version 1 tag)
					//
					// --tl album
					// audio/song album (max 30 chars for version 1 tag)
					//
					// --ty year
					// audio/song year of issue (1 to 9999)
					//
					// --tc comment
					// user-defined text (max 30 chars for v1 tag, 28 for v1.1)
					//
					// --tn track[/total]
					// audio/song track number and (optionally) the total number
					// of tracks on the original recording. (track and
					// total each 1 to 255. Providing just the track number
					// creates v1.1 tag, providing a total forces v2.0).
					//
					// --tg genre
					// audio/song genre (name or number in list)

					File mp3File = new File(dir, toDecimal(count, 2) + "_"
							+ file.getTitleClean() + ".mp3");
					System.out.println("    ->" + mp3File);

					String[] lame_mp3 = new String[] { "/usr/bin/lame", "-h",
							"--cbr", "-b", "256", "--silent", "--ta",
							"Acorn Atom", "--tl", dir.getName(), "--tt",
							file.getTitle(), "--ty", "1982", "--tn",
							"" + count, wavFile.toString(), mp3File.toString() };

					// String[] ffmpeg_alac = new String[] {
					// "/usr/bin/ffmpeg",
					// "-loglevel",
					// "quiet",
					// "-y",
					// "-i",
					// wavFile.toString(),
					// "-acodec",
					// "alac",
					// m4aFile.toString()
					// };

					String[] command = lame_mp3;
					Process p = Runtime.getRuntime().exec(command);

					int ret = -1;
					try {
						ret = p.waitFor();
					} catch (InterruptedException e) {
					}
					if (ret != 0) {
						throw new IOException("Command failed: " + command);
					}
				}

				if (writeCSW) {
					File cswFile = new File(dir, toDecimal(count, 2) + "_"
							+ file.getTitleClean() + ".csw");
					System.out.println("    ->" + cswFile);
					FileOutputStream fos = new FileOutputStream(cswFile);
					file.writeCswFile(fos);
					fos.close();
            }

				count++;
			}
		}
	}
	
	private String toDecimal(int i, int pad) {
		int p = (int) Math.pow(10, pad);
		return Integer.toString((i % p) + p).substring(1);
	}

}
