package uk.co.acornatom.menu;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class GenerateSplashFiles extends GenerateBase {

	/* 6847 Font taken from Atomulator */

	int fontdata[] = { 0x00, 0x00, 0x00, 0x1c, 0x22, 0x02, 0x1a, 0x2a, 0x2a,
			0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x14, 0x22, 0x22, 0x3e,
			0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3c, 0x12, 0x12, 0x1c,
			0x12, 0x12, 0x3c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x20,
			0x20, 0x20, 0x22, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3c, 0x12,
			0x12, 0x12, 0x12, 0x12, 0x3c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e,
			0x20, 0x20, 0x3c, 0x20, 0x20, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x3e, 0x20, 0x20, 0x3c, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x1e, 0x20, 0x20, 0x26, 0x22, 0x22, 0x1e, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x22, 0x22, 0x22, 0x3e, 0x22, 0x22, 0x22, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x1c, 0x08, 0x08, 0x08, 0x08, 0x08, 0x1c, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x02, 0x02, 0x02, 0x02, 0x22, 0x22, 0x1c,
			0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x24, 0x28, 0x30, 0x28, 0x24,
			0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20,
			0x20, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x36, 0x2a, 0x2a,
			0x22, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x32, 0x2a,
			0x26, 0x22, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x22,
			0x22, 0x22, 0x22, 0x22, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3c,
			0x22, 0x22, 0x3c, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x1c, 0x22, 0x22, 0x22, 0x2a, 0x24, 0x1a, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x3c, 0x22, 0x22, 0x3c, 0x28, 0x24, 0x22, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x1c, 0x22, 0x10, 0x08, 0x04, 0x22, 0x1c, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x3e, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x1c,
			0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x14, 0x14, 0x08,
			0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x2a, 0x2a,
			0x36, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x14, 0x08,
			0x14, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x14,
			0x08, 0x08, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x02,
			0x04, 0x08, 0x10, 0x20, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x38,
			0x20, 0x20, 0x20, 0x20, 0x20, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x20, 0x20, 0x10, 0x08, 0x04, 0x02, 0x02, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x0e, 0x02, 0x02, 0x02, 0x02, 0x02, 0x0e, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x08, 0x1c, 0x2a, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x08, 0x10, 0x3e, 0x10, 0x08, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x08, 0x08, 0x08, 0x08, 0x00,
			0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x14, 0x14, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x14, 0x36, 0x00,
			0x36, 0x14, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x1e, 0x20,
			0x1c, 0x02, 0x3c, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x32, 0x32,
			0x04, 0x08, 0x10, 0x26, 0x26, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10,
			0x28, 0x28, 0x10, 0x2a, 0x24, 0x1a, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x18, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x08, 0x10, 0x20, 0x20, 0x20, 0x10, 0x08, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x08, 0x04, 0x02, 0x02, 0x02, 0x04, 0x08, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x08, 0x1c, 0x3e, 0x1c, 0x08, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x08, 0x3e, 0x08, 0x08, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x30, 0x10,
			0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x30, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x02, 0x04,
			0x08, 0x10, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x24,
			0x24, 0x24, 0x24, 0x24, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08,
			0x18, 0x08, 0x08, 0x08, 0x08, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x1c, 0x22, 0x02, 0x1c, 0x20, 0x20, 0x3e, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x1c, 0x22, 0x02, 0x0c, 0x02, 0x22, 0x1c, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x04, 0x0c, 0x14, 0x3e, 0x04, 0x04, 0x04, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x3e, 0x20, 0x3c, 0x02, 0x02, 0x22, 0x1c, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x1c, 0x20, 0x20, 0x3c, 0x22, 0x22, 0x1c,
			0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x02, 0x04, 0x08, 0x10, 0x20,
			0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x22, 0x1c, 0x22,
			0x22, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x22, 0x1e,
			0x02, 0x02, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x18,
			0x00, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x18,
			0x00, 0x18, 0x18, 0x08, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04,
			0x08, 0x10, 0x20, 0x10, 0x08, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x3e, 0x00, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x10, 0x08, 0x04, 0x02, 0x04, 0x08, 0x10, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x18, 0x24, 0x04, 0x08, 0x08, 0x00, 0x08, 0x00, 0x00, };

	private String version;
	private Map<String, Integer> chunks;
	
	public GenerateSplashFiles(String version, Map<String, Integer> chunks) {
		this.version = version;
		this.chunks = chunks;
	}

	private void writeAtomString(byte[] screen, String s, int x, int y, boolean inverse) {
		int a = y * 32 + x;
		for (int i = 0; i < s.length(); i++) {
			int c = s.charAt(i);
			if (c > 64) {
				c = c - 64;
			}
			c = c & 63;
			for (int j = 0; j < 12; j++) {
				int b = fontdata[c * 12 + j];
				if (inverse) {
					b = b ^ 255;
				}
				screen[a + i + j * 32] = (byte) b;
			}
		}
	}

	private void copyAtomImage(byte[] from, byte[] to, int fromx, int fromy, int w, int h, int tox, int toy) {
		for (int x = 0; x < w; x++) {
			for (int y = 0; y < h; y++) {
				int ax = fromx + x;
				int ay = fromy + y;
				int a = (ax >> 3) + (ay << 5);
				int p = from[a] & (1 << (7 - ax & 7));
				if (p != 0) {
					int bx = tox + x;
					int by = toy + y;
					int b = (bx >> 3) + (by << 5);
					to[b] |= (1 << (7 - bx & 7));
				}
			}
		}
	}

	public void generateFiles(File menuDir, File bootLoaderBinary, List<SpreadsheetTitle> items) throws IOException {

		// Create an grey image
		byte[] screen = new byte[0x1800];
		int bw = 5;
		fill(screen, 0, 0, 256, 192, 1);
		fill(screen, bw, bw, 256 - bw * 2, 192 - bw * 2, 2);
		fill(screen, bw + 1, bw + 1, 256 - (bw + 1) * 2, 192 - (bw + 1) * 2, 0);

		// Load one of Phil Mainwaring's screens to we can leverage some bits
		File file = new File("splash" + File.separator + "SCREEN1.ATM");
		if (!file.exists()) {
			throw new RuntimeException(file.getCanonicalPath() + " does not exist");
		}
		byte[] baseScreen = readATMFile(file);

		// Copy the Acorn Logo
		copyAtomImage(baseScreen, screen, 109, 54, 40, 54, 210, 8);

		// Copy the StarDot and Retro Software logos
		copyAtomImage(baseScreen, screen, 0, 130, 256, 48, 0, 120);


		// Write the ACORN ATOM mmc software archive text
		String font = "Comic Sans Ms";
		BufferedImage image = new BufferedImage(256, 192, BufferedImage.TYPE_INT_ARGB);
		Graphics2D g = (Graphics2D) image.getGraphics();
		Font fontL = new Font(font, Font.BOLD, 28);
		Font fontS = new Font(font, Font.BOLD, 18);
		g.setColor(Color.WHITE);
		g.setFont(fontL);
		g.drawString("ACORN ATOM", 10, 32);
		g.setFont(fontS);
		g.drawString("mmc software archive", 14, 48);
		g.dispose();
		for (int x = 0; x < 256; x++) {
			for (int y = 0; y < 192; y++) {
				int pixel = image.getRGB(x, y);
				if (pixel != 0) {
					int b = 1 << (7 - (x & 7));
					screen[(x >> 3) + (y << 5)] |= b;
				}
			}
		}

		// Write the menu items
		int y = 52;
		// writeAtomString(screen, "PLEASE SELECT:", 1, y, false);
		y += 12;
		
		int i = 0;
		for (Map.Entry<String, Integer> chunk : chunks.entrySet()) {
			String line = (char) ('A' + i) + ".";
			line += chunk.getKey();
			String count = "(" + chunk.getValue() + ")";
			while (line.length() < 30 - count.length()) {
				line += " ";
			}
			line += count;
			writeAtomString(screen, line, 1, y, false);
			y += 12;
			i += 1;
		}		
		y += 3;

		// writeAtomString(screen, "PRESENTED IN ASSOCIATION WITH:", 1, y, false);

		SimpleDateFormat sdf = new SimpleDateFormat("dd/MMM/yyyy");
		String date = sdf.format(new Date()).toUpperCase();
		String line = "RELEASE " + version.toUpperCase();
		while (line.length() < 19) {
			line += " ";
		}
		line += date;
		if (line.length() != 30) {
			throw new RuntimeException("Expected footer to be 30 chars long: >>>" + line + "<<<");
		}
		
		y = 192 - 20;
				
		writeAtomString(screen, line, 1, y, false);

		// Invert the screen
		for (i = 0; i < 32*192; i++) {
			screen[i] = (byte) (screen[i] ^ 255);
		}		
	
		// Save the file
		String name = "SPLASH";
		FileOutputStream fosSplash = new FileOutputStream(new File(menuDir, name));
		writeATMFile(fosSplash, name, 0x8000, 0x8000, screen);
		fosSplash.close();
	}
	
	// Colour 0 = black
	// Colour 1 = grey
	// Colour 2 = white
	private void fill(byte[] screen, int xx, int yy, int w, int h, int colour) {		
		for (int x = xx; x < xx + w; x++) {
			for (int y = yy; y < yy + h; y++) {
				if ((colour == 0) || ((colour == 1) && ((x & 1) != (y & 1)))) {
					screen[(x >> 3) + (y << 5)] &= 255 - (1 << (7 - x & 7));
				} else {
					screen[(x >> 3) + (y << 5)] |= 1 << (7 - x & 7);
				}
			}
		}
		
	}

}
