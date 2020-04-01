package uk.co.acornatom.wavtoatm;

public interface WaveformSquarer {

    public int[] square(int[] samples);

    public int getSampleRate();

    public int getFrequency();

    public boolean isBothEdges();
}
