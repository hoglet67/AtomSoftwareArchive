package uk.co.acornatom.wavtoatm;

import java.io.ByteArrayOutputStream;

public class ByteDecoderKees extends ByteDecoderBase {

	public ByteDecoderKees() {
		super(null);
	}

	private int[] samples;

	private int Sum;

	@Override
	public int getOptimizationParamMin() {
		return 256;
	}

	@Override
	public int getOptimizationParamMax() {
		return 256 * 15;
	}

	@Override
	public int getOptimizationStep() {
		return 128;
	}

	@Override
	public void initialize(int[] samples) {
		this.samples = samples;
	}

	@Override
	public byte[] decodeBytes(int numBytes, int start, int optimationParam) {

		int flatMargin = optimationParam;

		String pulses = decodePulses(samples, 16, flatMargin);

		//System.out.println(pulses);

		String bits = decodeBits(pulses);

		//System.out.println(bits);

		byte[] bytes = readBytes(bits);

		return bytes;
	}

	/*
	'========================================================================================
	'DecodePulses
	'
	' When looking at the sinewaves, I noticed that mostly the first- and last quarter of the
	' sinewave is malformed. The middle part represents a fine sinewave.
	' That's why I count the samples between the bottom and the top peak of the sinewave to
	' determine half the sine length.
	' Sampled at 44100 Hz, short waves (2400 Hz) have a length of 18 samples and a long wave
	' (1200 Hz) have a length of 36 samples.
	'
	' The routine counts the samples to determine the frequency:
	'   9 < sine length < 27 -> Short "S" wave 2400 Hz
	'  27 < sine length < 45 -> Long "L" wave 1200 Hz
	'
	' |   |       |   |
	' |   |       +   |
	' |   |      /|\  |
	' |   |     / | \ |
	' |   |    /  |  \|
	' +---|---+---|---+-------+
	' |\  |  /    |   |\     /
	' | \ | /     |   | \   /
	' |  \|/      |   |  \ /
	' |   +       |   |   +
	' |   |       |   |
	' |   +<--t1->+   |
	' |               |
	' +<------t2----->+
	'========================================================================================
	 */

	private String decodePulses(int[] samples, int numBits, int flatMargin) {

		// Declare variables

		int[] gauss = new int[256]; // Count sine lengths for Gauss curve as
									// study

		int filePointer = 1;

		int t1 = 0;
		int pulsLen = 0;
		int flatCounter = 0;
		String waveStatus = "";
		String lastStatus = "F";

		// Open in-/output files
		StringBuffer pulses = new StringBuffer();

		// Main loop
		while (filePointer  < samples.length) {
			pulsLen = 0;

			// Read 2 sample values
			int val1 = samples[filePointer - 1];
			int val2 = samples[filePointer];

			// Check current pulse direction
			if (Math.abs(val1 - val2) < flatMargin) {
				waveStatus = "="; // Puls is flat
			} else if (val1 > val2) {
				waveStatus = "F"; // Puls is falling
			} else {
				waveStatus = "R"; // Puls is rising
			}

			// Check all puls states

			String status = lastStatus + waveStatus;

			switch (status) {

				case "FR": // Falling peak detected
					if (flatCounter == 0) {
						t1 = filePointer;
					} else {
						t1 = (int) (filePointer - (double) flatCounter / 2.0);
					}
					flatCounter = 0;
					lastStatus = "R";
					break;

				case "RF": // Rising Peak detected
					if (flatCounter == 0) {
						pulsLen = 2 * (filePointer - t1);
					} else {
						pulsLen = 2 * (((int)(filePointer - (double) flatCounter / 2.0)) - t1);
					}
					flatCounter = 0;
					lastStatus = "F";
					break;

				case "FF": // Falling puls
					lastStatus = waveStatus;
					flatCounter = 0;
					break;

				case "RR": // Rising puls
					lastStatus = waveStatus;
					flatCounter = 0;
					break;

				case "F=": // Falling puls going flat
					flatCounter = flatCounter + 1;
					break;

				case "R=": // Rising puls going flat
					flatCounter = flatCounter + 1;
					break;

				default: {
					throw new RuntimeException("Unexpected status " + status);
				}

			}
			// Determine 1200/2400 Hz wave
			if (pulsLen > 9 && pulsLen < 45) {
				pulses.append(pulsLen < 27 ? 'S' : 'L');
				gauss[pulsLen] = gauss[pulsLen] + 1;
			}

			filePointer = filePointer + 1;

		}

		// Write Gauss values to file
//		for (int i = 0; i < 256; i++) {
//			System.out.println("@@@ " + i + "\t" + gauss[i]);
//		}
		return pulses.toString();
	}



	/*
	'========================================================================================
	'DecodeBits
	'
	' First the beginning of the databits is detected by locating 3 long pulses after each
	' other. From this point on the decoding starts.
	' Normally 4 long pulses represent a 0-bit and 8 short pulses a 1-bit. If the WAV is a
	' bit malformed, it is possible to have 1 more or less long/short pulse for a bit.
	' This routine starts with counting the long pulses and when the pulses switch to short
	' pulses, the count is divided by 4 and rounded to the next multiple of 4. Then this
	' amount of 0-bits is written.
	' The same is done for the short pulses only then the count is divided by 8 and rounded
	' to the next multiple of 8. This amount of 1-bits is written.
	' Gaps between block (more then 9 1-bits) are skipped
	'========================================================================================
	*/

	private String decodeBits(String pulses) {

		StringBuffer bits = new StringBuffer();
		boolean readStart = false;
		int ptr = 1;
		int longCount = 0;

		// Find datastart by locating 3 longpulses after each other
		while (!readStart && ptr < pulses.length()) {
			char dataByte = pulses.charAt(ptr);
			if (dataByte == 'L') {
				longCount = longCount + 1;
				if (longCount == 3) {
					readStart = true;
				}
			} else {
				longCount = 0;
			}
			ptr = ptr + 1;
		}

		// Read bits
		int shortCount = 0;
		char lastPulse = 'L';
		int bitCounter = 0;
		int nrBits;

		while (ptr < pulses.length()) {
			char DataByte = pulses.charAt(ptr);

			String state = "" + lastPulse + DataByte;
			switch (state) {
				case "LL": // No Pulse change
					longCount = longCount + 1;
					break;

				case "SS": // No Pulse change
					shortCount = shortCount + 1;
					break;
				case "LS": // Pulse change detected, write 0-bits
					shortCount = 1;
					nrBits = (longCount / 4) + (longCount % 4 > 2 ? 1 : 0); // Check
																			// amount
																			// of
																			// 0-bits
					for (int i = 1; i <= nrBits; i++) {
						bits.append('0');
						bitCounter = bitCounter + 1;
						if (bitCounter % 10 == 0) {
							bits.append('\n');
							bitCounter = 0;
						}
					}
					break;

				case "SL": // Pulse change detected, write 1-bits
					longCount = 1;
					nrBits = (shortCount / 8) + (shortCount % 8 > 6 ? 1 : 0); // Check
																				// amount
																				// of
																				// 1-bits
					if (nrBits > 10) { // If more then nine 1-bits then gap detected
						if (bitCounter < 10 && bitCounter != 0) {
							for (int i = bitCounter; i <= 9; i++) { // Complete byte
																	// if not 10
																	// bits and skip
																	// gap
								bits.append('1');
							}
							bits.append('*');
							bits.append(" " + (ptr + 1) + "\n");
						}
						bitCounter = 0;
					} else {
						for (int i = 1; i <= nrBits; i++) {
							bits.append('1');
							bitCounter = bitCounter + 1;
							if (bitCounter % 10 == 0) {
								bits.append("  " + (ptr + 1) + "\n");
								bitCounter = 0;
							}
						}
					}
					break;

				default: {
					throw new RuntimeException("Unexpected state" + state);
				}
			}
			lastPulse = DataByte;

			ptr = ptr + 1;
		}

		char DataByte = pulses.charAt(ptr - 2);
		if (bitCounter < 10) { // Complete byte if not 10 bits
			for (int i = bitCounter; i <= 9; i++) {
				if (DataByte == 'S') {
					bits.append('1');
				}
				if (DataByte == 'L') {
					bits.append('0');
				}
			}
		}
		return bits.toString();
	}


	/*
	'===================================================================
	' Readbyte
	'
	' Read line from BIT file, 10 bits, * for completion with 1-bit
	' and filepointer
	' Return byte value and add to sum
	'===================================================================
	 */

	private byte[] readBytes(String bits) {
		ByteArrayOutputStream bos = new ByteArrayOutputStream();

		for (String line : bits.split("\n")) {
			int retVal = 0;
			int power = 1;
			// Check if Byte has startbit (0) and stopbit (1)
			if (line.charAt(0) == '0' && line.charAt(9) == '1') {
				for (int i = 1; i <= 8; i++) {
					retVal = retVal + (line.charAt(i) == '1' ? power : 0);
					power = power * 2;
				}
			} else {
				// System.out.println("@@@ Badly framed byte: " + line);
			}

			Sum = (Sum + retVal) & 255;
			bos.write(retVal);
		}
		return bos.toByteArray();
	}

	public String toString() {
		return "Kees's Byte Decoder";
	}
}
