package uk.co.acornatom.wavtoatm;

public class WaveformSquarerUsingSign extends WaveformSquarerBase  {

    public WaveformSquarerUsingSign(int sampleRate, int frequency, boolean bothEdges) {
        super(sampleRate, frequency, bothEdges);
    }

    @Override
    protected int[] extractZeroCrossings(int[] samples) {
        return samples;
    }

   public String toString() {
        return "Sign based Squarer";
    }

}
