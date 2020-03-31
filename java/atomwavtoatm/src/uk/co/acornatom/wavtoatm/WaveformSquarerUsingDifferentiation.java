package uk.co.acornatom.wavtoatm;

public class WaveformSquarerUsingDifferentiation extends WaveformSquarerBase  {

	private int window;
	public WaveformSquarerUsingDifferentiation(int window, int sampleRate, int frequency, boolean bothEdges) {
		super(sampleRate, frequency, bothEdges);
		this.window = window;
	}

	@Override
	protected int[] extractZeroCrossings(int[] samples) {
		samples = sumOverWindow(samples, window);
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
