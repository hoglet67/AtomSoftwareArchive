package uk.co.acornatom.wavtoatm;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

public class WavToBits {
	
	private static final int FREQUENCY = 2400;
	private static final int BAUD = 700;
	
	public enum Mode {
		OLD,
		NEW,
        SIMPLE 
	}

	private File file;

	private int[] origSamples;

	private int[] samples;

	private int window1;
	private int window2;
	
	private int sampleRate;
	private int numChannels;
	private int numFrames;
	
	public WavToBits(File file, int window1, int window2) throws IOException {
		this.file = file;
		this.window1 = window1;
		this.window2 = window2;
		this.origSamples = readWavIntoMemory();
	}
	
	public int getNumChannels() {
		return numChannels;
	}
	
	public double process(int channel, Mode mode, boolean bothEdges) throws IOException {
		System.out.println("Processing channel " + channel + " mode " + mode);
		int[] samples = extractChannel(origSamples, channel);
		if (mode == Mode.OLD) {
			samples = sumOverWindow(samples, window1);
			samples = differentiate(samples);
		} else {
			int[] baseLine = lowPassFilter(samples, sampleRate, BAUD);
			samples = compare(samples, baseLine);
		}
		if (bothEdges) {
			samples = anySignChanges(samples);
		} else {
			samples = negToPosSignChanges(samples);			
		}
		double bitLength = calculateBitLength(samples, bothEdges);
		samples = sumOverWindow(samples, (int) (bitLength + 0.5));
		samples = sumOverWindow(samples, (int) (bitLength / window2 + 0.5));
		this.samples = samples;	
		return bitLength;
	}

	
	
	private int[] readWavIntoMemory() throws IOException {
		
		// Open the wav file specified as the first argument
		WavFile wavFile = WavFile.openWavFile(file);

		// Display information about the wav file
		wavFile.display();
	
		// Get the number of audio channels in the wav file
		numChannels = wavFile.getNumChannels();
		numFrames = (int) wavFile.getNumFrames();
		sampleRate = (int) wavFile.getSampleRate();

		System.out.println("Num Channels = " + numChannels);
		System.out.println("Num Frames = " + numChannels);
		System.out.println("Sample Rate = " + sampleRate);
		System.out.println("Duration = " + numFrames / sampleRate + " secs");
		
		// Create a buffer to hold all of the samples
		int[] samples = new int[numFrames * numChannels];

		int framesRead = wavFile.readFrames(samples, numFrames);
		
		if (framesRead != numFrames) {
			System.out.println("Unexpected number of frames read: expected=" + numFrames + "; actual=" + framesRead);			
		}

		// Close the wavFile
		wavFile.close();

		return samples;
	}
	
	private int[] extractChannel(int[] samples, int channel) {
		int numFrames = samples.length / numChannels;
		int[] newSamples = new int[numFrames];
		int j = channel;
		for (int i = 0; i < numFrames; i++) {
			newSamples[i] = samples[j];
			j += numChannels;
		}

		return newSamples;
	}
	
	private int[] sumOverWindow(int[] samples, int window) {
		int[] newSamples = new int[samples.length];
		int sum = 0;
		for (int i = 0; i < samples.length; i++) {
			if (i < window) {
				sum += samples[i];
			} else {
				sum += samples[i] - samples[i - window];
			}
			newSamples[i] = sum;
		}
		return newSamples;
	}

	private int[] differentiate(int[] samples) {
		int[] newSamples = new int[samples.length];
		for (int i = 1; i < samples.length; i++) {
			newSamples[i - 1] = samples[i] - samples[i - 1];
		}
		return newSamples;
	}
	
	private int[] compare(int[] samples, int[] baseline) {
		int[] newSamples = new int[samples.length];
		for (int i = 0; i < samples.length; i++) {
			newSamples[i] = samples[i] > baseline[i] ? 1000 : -1000;
		}
		return newSamples;
	}

	private int[] negToPosSignChanges(int[] samples) {
		int[] newSamples = new int[samples.length];
		for (int i = 1; i < samples.length; i++) {
			newSamples[i - 1] = samples[i - 1] <0 && samples[i] >= 0 ? 1 : 0;
		}
		return newSamples;
	}
	
	private int[] anySignChanges(int[] samples) {
		int[] newSamples = new int[samples.length];
		for (int i = 1; i < samples.length; i++) {
			newSamples[i - 1] = (samples[i - 1] < 0 && samples[i] >= 0) ||  (samples[i - 1] >= 0 && samples[i] < 0) ? 1 : 0;
		}
		return newSamples;
	}

	private double calculateBitLength(int[] samples, boolean bothEdges) {
		// At 44100, 2400Hz is ~18 samples
		int n = (int) (((double) sampleRate / (double) FREQUENCY) + 0.5);
		int max = n * 2;
		int[] periods = new int[max];
		int last1 = 0;
		int last2 = 0;
		for (int i = 0; i < max; i++) {
			periods[i] = 0;
		}
		for (int i = 0; i < samples.length; i++) {
			if (samples[i] == 1) {
				int period = i - (bothEdges ? last2 : last1);
				last2 = last1;
				last1 = i;
				periods[period < max - 1 ? period : max - 1]++;
			}
		}
		
		double  period = (double) ((n - 1) * periods[n - 1] + n * periods[n] + (n + 1) * periods[n + 1]) * 8 /
				(double) (periods[n - 1] + periods[n] + periods[n + 1]);

		return period;
	}

	


	public byte[] sampleBytes(int start, int threshold, double bitLength, boolean bothEdges) {
		
		int bitThreshold = bothEdges ? 12 : 6;
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		
		double id = start + 1;
		while (id < samples.length - 1) {
			// Find the start bit, a 1 to 0 transition
			if ((getSample(id - 1) > threshold) && (getSample(id) <= threshold)) {
//				System.out.println("Found start at " + (i - start));
				// Skip 1.5 bits
				id += bitLength * 31 / 20;
				
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

					if (getSample(id) > bitThreshold * bitLength / window2) {
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
	
	
	
	void getLPCoefficientsButterworth2Pole(double samplerate, double cutoff, double[] ax, double[] by)
	{
	    double sqrt2 = Math.sqrt(2.0);

	    double QcRaw  = (2 * Math.PI * cutoff) / samplerate; // Find cutoff frequency in [0..PI]
	    double QcWarp = Math.tan(QcRaw); // Warp cutoff frequency

	    double gain = 1.0 / (1.0 + sqrt2 / QcWarp + 2.0 / (QcWarp * QcWarp));
	    by[2] = (1.0 - sqrt2 / QcWarp + 2.0 / (QcWarp * QcWarp)) * gain;
	    by[1] = (2.0 - 2.0 * 2.0 / ( QcWarp * QcWarp)) * gain;
	    by[0] = 1;
	    ax[0] = 1 * gain;
	    ax[1] = 2 * gain;
	    ax[2] = 1 * gain;
	}
	
	void calcFilter(double samplerate, double cutoff, int type, double[] ax, double[] by) {
		double fudge;
		IIRFilter iir = new IIRFilter();
		iir.setPrototype(IIRFilter.BUTTERWORTH);
		iir.setFilterType(IIRFilter.LP);
		if (type == IIRFilter.LP) {
			iir.setFreq1(0);
			iir.setFreq2((float) cutoff);
			fudge = 2.0;
		} else {
			iir.setFreq1(0);
			iir.setFreq2((float) cutoff);
			fudge = -2.0;
		}
		iir.setOrder(2);
		iir.setRate((float) samplerate);
		iir.design();
		iir.setFreqPoints(1000);
		iir.filterGain();
		for (int i = 0; i <= 2; i++) {
			ax[i] = iir.getACoeff(i) * fudge;
			by[i] = iir.getBCoeff(i);
		}		
	}

	private int[] lowPassFilter(int[] samples, double samplerate, double cutoff) {
		return filter(samples, samplerate, cutoff, IIRFilter.LP);
	}

	private int[] highPassFilter(int[] samples, double samplerate, double cutoff) {
		return filter(samples, samplerate, cutoff, IIRFilter.HP);
	}

	private int[] filter(int[] samples, double samplerate, double cutoff,  int type) {
		int[] newSamples = new int[samples.length];
		double[] xv = new double[3];
		double[] yv = new double[3];
		double[] ax = new double[3];
		double[] by = new double[3];

		if (type == IIRFilter.LP) {
			getLPCoefficientsButterworth2Pole(samplerate, cutoff, ax, by);
		} else {
			calcFilter(samplerate, cutoff, type, ax, by);			
		}
		
		dumpCoeffs(ax, by);

		for (int i = 0; i < samples.length; i++) {
			xv[2] = xv[1];
			xv[1] = xv[0];
			xv[0] = samples[i];
			yv[2] = yv[1];
			yv[1] = yv[0];

			yv[0] = (ax[0] * xv[0] + ax[1] * xv[1] + ax[2] * xv[2] - by[1] * yv[0] - by[2] * yv[1]);

			newSamples[i] = (int) (yv[0] + 0.5);
		}
		return newSamples;
	}
	
	private void dumpCoeffs(double[] ax, double[] by) {
		for (int i = 0; i < ax.length; i++) {
			System.out.println("ax[" + i + "] = " + ax[i]);
		}
		for (int i = 0; i < by.length; i++) {
			System.out.println("by[" + i + "] = " + by[i]);
		}
	}
	
	private void dump_samples(String title, int[] samples, int start, int num) {
		System.out.println("====================================");
		System.out.println(title);
		System.out.println("====================================");
		for (int i = start; i < start + num && i < samples.length; i++ ) {
			System.out.println(i + "\t" + samples[i]);
		}
	}
	
	private void xgraph_samples(String file, String title, int[] samples, int start, int num) throws IOException {
		PrintWriter pw = new PrintWriter(new File(file));
		pw.println("\" " + title);
		for (int i = start; i < start + num && i < samples.length; i++ ) {
			pw.println(i - start + " " + samples[i]);
		}
		pw.close();
	}
	
	private int[] distribution(int[] samples, int bucketSize) {
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



	public double processNew(int channel) throws IOException {
		// System.out.println("Processing channel " + channel);
		int[] samples = extractChannel(origSamples, channel);
		int[] baseLine = lowPassFilter(samples, sampleRate, BAUD);
		samples = compare(samples, baseLine);
		samples = anySignChanges(samples);
		double bitLength = calculateBitLength(samples, true);
		this.samples = samples;
		return bitLength;
	}


	public byte[] sampleNew(int countThresh) throws IOException {

		double cswmul = (double) 4000000 / (double) sampleRate;

		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		
		int last = 0;
		int header = 0;
		boolean cinbyte = false;

		int byt = 0;
		int bitsleft = 0;
		int c = 0;
		int count = 0;
 
		for (int i = 0; i < samples.length; i++) {
			if (samples[i] == 1) {
				int d = (int) (((double) (i - last)) * cswmul + 0.5);
				if (header < 1000) {
					if (d > 1200) {
						header = 0;
					} else {
						header++;
					}
				} else if (!cinbyte) {
					if (d > 1200) { /*0*/
						cinbyte = true;
						bitsleft = 10;
						byt = 0;
						c = 1;
						count = d;
					}
				} else {
					c++;
					count += d;
					if (count >= countThresh) {
						count = 0;
						if (c >= 12) {
							byt = (byt >> 1) | 0x80;
						} else {
							byt >>= 1;
						}
						bitsleft--;
						if (bitsleft == 1) {
							bos.write(byt);
						}
						if (bitsleft == 0) {
							cinbyte = false;
						}
						c = 0;
					}
				}
				last = i;

			} // if
		} // for

		return bos.toByteArray();
	}


}
