package uk.co.acornatom.wavtoatm;

public interface WaveformSquarer {

	public int[] square(int[] samples);

	public double getBitLength();

	public int getSampleRate();

	public boolean isBothEdges();
}
