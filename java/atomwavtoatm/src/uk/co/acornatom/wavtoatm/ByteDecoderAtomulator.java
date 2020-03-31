package uk.co.acornatom.wavtoatm;

import java.io.ByteArrayOutputStream;

public class ByteDecoderAtomulator extends ByteDecoderBase {

	public ByteDecoderAtomulator(WaveformSquarer squarer) {
		super(squarer);
	}

	@Override
	public int getOptimizationParamMin() {
		return 12000;
	}

	@Override
	public int getOptimizationParamMax() {
		return 13500;
	}


	@Override
	public int getOptimizationStep() {
		return 50;
	}

	@Override
	public void initialize(int[] samples) {
		this.samples = squarer.square(samples);
	}

	@Override
	public byte[] decodeBytes(int numBytes, int start, int optimationParam) {

		int countThresh = optimationParam;

		double cswmul = (double) 4000000 / (double) squarer.getSampleRate();

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

	public String toString() {
		return "Atomulator's Byte Decoder with " + squarer;
	}


}
