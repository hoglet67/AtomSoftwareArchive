package uk.co.acornatom.basic;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

public class Oric {

	public static Map<Integer,String> tokens = new HashMap<Integer, String>();

	static {
		tokens.put(128, "END");
		tokens.put(129, "EDIT");
		tokens.put(130, "STORE");
		tokens.put(131, "RECALL");
		tokens.put(132, "TRON");
		tokens.put(133, "TROFF");
		tokens.put(134, "POP");
		tokens.put(135, "PLOT");
		tokens.put(136, "PULL");
		tokens.put(137, "LORES");
		tokens.put(138, "DOKE");
		tokens.put(139, "REPEAT");
		tokens.put(140, "UNTIL");
		tokens.put(141, "FOR");
		tokens.put(142, "LLIST");
		tokens.put(143, "LPRINT");
		tokens.put(144, "NEXT");
		tokens.put(145, "DATA");
		tokens.put(146, "INPUT");
		tokens.put(147, "DIM");
		tokens.put(148, "CLS");
		tokens.put(149, "READ");
		tokens.put(150, "LET");
		tokens.put(151, "GOTO");
		tokens.put(152, "RUN");
		tokens.put(153, "IF");
		tokens.put(154, "RESTORE");
		tokens.put(155, "GOSUB");
		tokens.put(156, "RETURN");
		tokens.put(157, "REM");
		tokens.put(158, "HIMEM");
		tokens.put(159, "GRAB");
		tokens.put(160, "RELEASE");
		tokens.put(161, "TEXT");
		tokens.put(162, "HIRES");
		tokens.put(163, "SHOOT");
		tokens.put(164, "EXPLODE");
		tokens.put(165, "ZAP");
		tokens.put(166, "PING");
		tokens.put(167, "SOUND");
		tokens.put(168, "MUSIC");
		tokens.put(169, "PLAY");
		tokens.put(170, "CURSET");
		tokens.put(171, "CURMOV");
		tokens.put(172, "DRAW");
		tokens.put(173, "CIRCLE");
		tokens.put(174, "PATTERN");
		tokens.put(175, "FILL");
		tokens.put(176, "CHAR");
		tokens.put(177, "PAPER");
		tokens.put(178, "INK");
		tokens.put(179, "STOP");
		tokens.put(180, "ON");
		tokens.put(181, "WAIT");
		tokens.put(182, "CLOAD");
		tokens.put(183, "CSAVE");
		tokens.put(184, "DEF");
		tokens.put(185, "POKE");
		tokens.put(186, "PRINT");
		tokens.put(187, "CONT");
		tokens.put(188, "LIST");
		tokens.put(189, "CLEAR");
		tokens.put(190, "GET");
		tokens.put(191, "CALL");
		tokens.put(192, "!");
		tokens.put(193, "NEW");
		tokens.put(194, "TAB(");
		tokens.put(195, "TO");
		tokens.put(196, "FN");
		tokens.put(197, "SPC(");
		tokens.put(198, "@");
		tokens.put(199, "AUTO");
		tokens.put(200, "ELSE");
		tokens.put(201, "THEN");
		tokens.put(202, "NOT");
		tokens.put(203, "STEP");
		tokens.put(204, "+");
		tokens.put(205, "-");
		tokens.put(206, "*");
		tokens.put(207, "/");
		tokens.put(208, "^");
		tokens.put(209, "AND");
		tokens.put(210, "OR");
		tokens.put(211, ">");
		tokens.put(212, "=");
		tokens.put(213, "<");
		tokens.put(214, "SGN");
		tokens.put(215, "INT");
		tokens.put(216, "ABS");
		tokens.put(217, "USR");
		tokens.put(218, "FRE");
		tokens.put(219, "POS");
		tokens.put(220, "HEX$");
		tokens.put(221, "&");
		tokens.put(222, "SQR");
		tokens.put(223, "RND");
		tokens.put(224, "LN");
		tokens.put(225, "EXP");
		tokens.put(226, "COS");
		tokens.put(227, "SIN");
		tokens.put(228, "TAN");
		tokens.put(229, "ATN");
		tokens.put(230, "PEEK");
		tokens.put(231, "DEEK");
		tokens.put(232, "LOG");
		tokens.put(233, "LEN");
		tokens.put(234, "STR$");
		tokens.put(235, "VAL");
		tokens.put(236, "ASC");
		tokens.put(237, "CHR$");
		tokens.put(238, "PI");
		tokens.put(239, "TRUE");
		tokens.put(240, "FALSE");
		tokens.put(241, "KEY$");
		tokens.put(242, "SCRN");
		tokens.put(243, "POINT");
		tokens.put(244, "LEFT$");
		tokens.put(245, "RIGHT$");
		tokens.put(246, "MID$");
		tokens.put(247, "GO");

	}
	
	public void convert(File f) throws IOException {
		StringBuffer sb = new StringBuffer();
		byte[] bytes = readFile(f);
		
		int i = 13;
		
		// Skip the .tap filename and 0 terminator
		while (bytes[i] != 0) {
			i++;
		}
		i++;
		
		while (i + 4 < bytes.length) {
			
			
			// Skip the address
			i += 2;

			// Line number
			int line = (bytes[i] & 0xff) + 256 * (bytes[i + 1] & 0xff);
			i += 2;
			sb.append(String.format("%5d", line) + " ");
		
			// Line
			while (bytes[i] != 0 && i < bytes.length) {
				int c = bytes[i] & 0xff;
				if (c < 128) {
					sb.append((char) c);
				} else {
					sb.append(tokens.get(c));
				}
				i++;
			}
			i++;
			sb.append("\n");
		}
		System.out.println(sb.toString());
	}
	
	
	private byte[] readFile(File file) throws IOException {
		if (!file.exists()) {
			throw new IOException("Could not read " + file);
		}
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
	
	public static final void main(String[] args) {
		try {
			if (args.length != 1) {
				System.err.println("usage: java -jar oric.jar <Src Atom Basic Text File>");
				System.exit(1);
			}
			File srcFile = new File(args[0]);
			if (!srcFile.exists()) {
				System.err.println("Source Oric Basic File: " + srcFile + " does not exist");
				System.exit(1);
			}
			if (!srcFile.isFile()) {
				System.err.println("Source Oric Basic File: " + srcFile + " is not a file");
				System.exit(1);
			}
			Oric oric = new Oric();
			oric.convert(srcFile);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
