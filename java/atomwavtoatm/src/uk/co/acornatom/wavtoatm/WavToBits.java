package uk.co.acornatom.wavtoatm;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

public class WavToBits {

	File file;

	int[] samples;
	
	public WavToBits(File file) {
		this.file = file;
	}
	
	private void readWavIntoMemory() throws IOException {
		
		
		// Open the wav file specified as the first argument
		WavFile wavFile = WavFile.openWavFile(file);

		// Display information about the wav file
		// wavFile.display();

		
		
		// Get the number of audio channels in the wav file
		int numChannels = wavFile.getNumChannels();
		int numFrames = (int) wavFile.getNumFrames();
		
		// Create a buffer of 100 frames
		samples = new int[numFrames * numChannels];

		int framesRead = wavFile.readFrames(samples, numFrames);

		// System.out.println("Read " + framesRead + " frames");

		// Close the wavFile
		wavFile.close();
		
		
	}

	public void differentiate() {
		for (int i = 1; i < samples.length; i++) {
			samples[i - 1] = samples[i] - samples[i - 1];
		}
	}

	public void negToPosSignChanges() {
		for (int i = 1; i < samples.length; i++) {
			samples[i - 1] = samples[i - 1] <0 && samples[i] >= 0 ? 1 : 0;
		}
	}

	public double calculateBitLength() {
		// At 44100, 2400Hz is ~18 samples
		int max = 32;
		int[] periods = new int[max];
		int last = 0;
		for (int i = 0; i < max; i++) {
			
		}
		for (int i = 0; i < samples.length; i++) {
			if (samples[i] == 1) {
				int period = i - last;
				last = i;
				periods[period < max - 1 ? period : max - 1]++;
			}
		}
		
		double  period = (double) (17 * periods[17] + 18 * periods[18] + 19 * periods[19]) * 8 /
				(double) (periods[17] + periods[18] + periods[19]);

		return period;
	}
	
	public void sumOverWindow(int window) {
		int sum = 0;
		for (int i = 0; i < samples.length; i++) {
			if (i < window) {
				sum += samples[i];
			} else {
				sum += samples[i] - samples[i - window];
				samples[i - window] = sum;
			}
		}
	}

	
	
	public int[] distribution(int[] samples, int bucketSize) {
		int max= 100;
		int[] dist = new int[max];
		for (int i = 0; i < max; i++) {
			dist[i] = 0;
		}
		for (int i = 0; i < samples.length; i++) {
			dist[(samples[i] < max - 1 ? samples[i] : max - 1) / bucketSize]++;
		}
		return dist;
	}

	public byte[] sampleBytes(int start, int threshold, double bitLength) {
		
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		
		double id = start + 1;
		while (id < samples.length - 1) {
			// Find the start bit, a 1 to 0 transition
			if ((getSample(id - 1) > threshold) && (getSample(id) <= threshold)) {
//				System.out.println("Found start at " + (i - start));
				// Skip 1.5 bits
				id += bitLength * 3 / 2;
				
//				// Sample the start bit
//				if (getSample(i] > threshold) {
//					System.out.println("Incorrect Start Bit at " + i);
//					continue;
//				}
//				i += bitLength;
//				if (i >= samples.length) {
//					break;
//				}
				// Sample next 8 bits
				int b = 0;
				for (int j = 0; j < 8; j++) {
//					System.out.println("Samping bit " + j + " at " + (i - start));

					if (getSample(id) > threshold) {
						b += 1 << j;
					}
					id += bitLength;
				}
				// Sample stop bit
//				System.out.println("Samping stop bit  at " + (i - start));
				if (getSample(id) <= threshold) {
					// System.out.println("Incorrect Stop Bit at " + i + " byte " + b);
				} else {
					bos.write(b);
				}
			} else {
				id++;
			}
			
		}
		return bos.toByteArray();
	}

	// Interpolate between two samples
	private int getSample(double id) {
		int i1 = (int) id;
		int i2 = i1 + 1;
		if (i2 >= samples.length - 1) {
			return 0;
		}
		return (int) (samples[i1] * (id - i1) + samples[i2] * (i2 - id) + 0.5);
	}
	
	
	
	public void dump_samples(String title, int[] samples, int start, int num) {
		System.out.println("====================================");
		System.out.println(title);
		System.out.println("====================================");
		for (int i = start; i < start + num && i < samples.length; i++ ) {
			System.out.println(i + "\t" + samples[i]);
		}
	}
	
	
	
	public void xgraph_samples(String file, String title, int[] samples, int start, int num) throws IOException {
		PrintWriter pw = new PrintWriter(new File(file));
		pw.println("\" " + title);
		for (int i = start; i < start + num && i < samples.length; i++ ) {
			pw.println(i - start + " " + samples[i]);
		}
		pw.close();
	}
	

	
	public double process() throws IOException {
		readWavIntoMemory();

		// int start = 0;
		// int num = bitLength * 8 * 32 * 100 / 100;

		sumOverWindow(8);
		
		//dump_samples("Raw Samples", samples, start, num);
		differentiate();
		//dump_samples("Differentiated Samples", samples, start, num);
		negToPosSignChanges();

		double bitLength = calculateBitLength();
		
		//dump_samples("Neg to PosSign Changes", samples, start, num);

		sumOverWindow((int) (bitLength + 0.5));
		//dump_samples("Sign Changes In Next Bit", samples, start, num);
		//dump_samples("Distribution 1", distribution(samples, 1), 0, Integer.MAX_VALUE);

		sumOverWindow((int) (bitLength / 4 + 0.5));

		//dump_samples("Sum Sign Changes In Next Bit", samples, start, num);
		//dump_samples("Distribution 2", distribution(samples, 10), 0, Integer.MAX_VALUE);
		// xgraph_samples("test.xgr", "Averaged", samples, start, num);
		
		return bitLength;
	}

}
