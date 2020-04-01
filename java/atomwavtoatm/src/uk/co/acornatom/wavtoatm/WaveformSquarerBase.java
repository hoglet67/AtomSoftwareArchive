package uk.co.acornatom.wavtoatm;

public abstract class WaveformSquarerBase implements WaveformSquarer {

    protected int sampleRate;
    protected int frequency;
    protected boolean bothEdges;

    public WaveformSquarerBase(int sampleRate, int frequency, boolean bothEdges) {
        this.sampleRate = sampleRate;
        this.frequency = frequency;
        this.bothEdges = bothEdges;
    }

    protected abstract int[] extractZeroCrossings(int[] samples);

    public int[] square(int[] samples) {
        samples = extractZeroCrossings(samples);
        if (bothEdges) {
            samples = anySignChanges(samples);
        } else {
            samples = negToPosSignChanges(samples);
        }
        return samples;
    }

    public int getSampleRate() {
        return sampleRate;
    }

    public int getFrequency() {
        return frequency;
    }

    public boolean isBothEdges() {
        return bothEdges;
    }

    private static int[] negToPosSignChanges(int[] samples) {
        int[] newSamples = new int[samples.length];
        for (int i = 1; i < samples.length; i++) {
            newSamples[i - 1] = samples[i - 1] < 0 && samples[i] >= 0 ? 1 : 0;
        }
        return newSamples;
    }

    protected static int[] anySignChanges(int[] samples) {
        int[] newSamples = new int[samples.length];
        for (int i = 1; i < samples.length; i++) {
            newSamples[i - 1] = (samples[i - 1] < 0 && samples[i] >= 0) || (samples[i - 1] >= 0 && samples[i] < 0) ? 1 : 0;
        }
        return newSamples;
    }

    protected static int[] sumOverWindow(int[] samples, int window) {
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

}
