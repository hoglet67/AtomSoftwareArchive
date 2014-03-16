package uk.co.acornatom.wavtoatm;

public class WaveformSquarerUsingDifferentiation extends WaveformSquarerBase  {

	private int window1;
	public WaveformSquarerUsingDifferentiation(int window1, int window2, int sampleRate, int frequency, boolean bothEdges) {
		super(window2, sampleRate, frequency, bothEdges);
		this.window1 = window1;
	}

	@Override
	protected int[] extractZeroCrossings(int[] samples) {
		samples = sumOverWindow(samples, window1);
		samples = differentiate(samples);
		return samples;
	}
	
	private int[] differentiate(int[] samples) {
		int[] newSamples = new int[samples.length];
		for (int i = 1; i < samples.length; i++) {
			newSamples[i - 1] = samples[i] - samples[i - 1];
		}
		return newSamples;
	}
	
	public String toString() {
		return "Diff based Squarer";
	}

}
