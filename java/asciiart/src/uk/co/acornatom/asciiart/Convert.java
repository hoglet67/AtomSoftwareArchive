package uk.co.acornatom.asciiart;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashSet;
import java.util.Set;

public class Convert {

	private void convertToAtm(File srcFile, File dstFile) throws IOException {

		BufferedReader reader = new BufferedReader(new FileReader(srcFile));
		BufferedWriter writer = new BufferedWriter(new FileWriter(dstFile));

		int frames = 0;
		while (true) {
			String numRepeatsStr = reader.readLine();
			try {
				int numRepeats = Integer.parseInt(numRepeatsStr);
				int hours = (frames / 15 / 3600);
				int minutes = (frames / 15 / 60) % 60;
				int secs = (frames / 15) % 60;
				StringBuffer sb = new StringBuffer();
				if (hours < 10) {
					sb.append(' ');
				}
				sb.append(Integer.toString(hours));
				sb.append(':');
				if (minutes < 10) {
					sb.append('0');
				}
				sb.append(Integer.toString(minutes));
				sb.append(':');
				if (secs < 10) {
					sb.append('0');
				}
				sb.append(Integer.toString(secs));
				writer.write(numRepeatsStr);
				writer.write('\r');
				writer.write('\n');
				writer.write(sb.toString());
				writer.write('\r');
				writer.write('\n');
				for (int i = 0; i < 13; i++) {
					String line = reader.readLine();
					writer.write(line);
					writer.write('\r');
					writer.write('\n');
				}

				frames += numRepeats;
				
			} catch (NumberFormatException e) {
				break;
			}

		}

		reader.close();
		writer.close();
	}

	public static final void main(String[] args) {
		try {
			if (args.length != 2) {
				System.err.println("usage: java -jar asciiart.jar <Src Ascii Art File> <Src Ascii Art File>");
				System.exit(1);
			}
			File srcFile = new File(args[0]);
			if (!srcFile.exists()) {
				System.err.println("Source AsciiART File: " + srcFile + " does not exist");
				System.exit(1);
			}
			if (!srcFile.isFile()) {
				System.err.println("Source AsciiART File: " + srcFile + " is not a file");
				System.exit(1);
			}
			File dstFile = new File(args[1]);
						
			Convert c = new Convert();
			c.convertToAtm(srcFile, dstFile);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
