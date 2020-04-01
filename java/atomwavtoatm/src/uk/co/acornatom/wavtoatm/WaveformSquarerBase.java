package uk.co.acornatom.wavtoatm;

public abstract class WaveformSquarerBase implements WaveformSquarer {

    protected int sampleRate;
    protected int frequency;
    protected boolean bothEdges;

    private double bitLength;

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
        bitLength = calculateBitLength(samples);
        return samples;
    }

    public double getBitLength() {
        return bitLength;
    }

    public int getSampleRate() {
        return sampleRate;
    }

    public boolean isBothEdges() {
        return bothEdges;
    }

    private double calculateBitLength(int[] samples) {
        // At 44100, 2400Hz is ~18 samples
        int n = (int) (((double) sampleRate / (double) frequency) + 0.5);
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

        return (double) ((n - 1) * periods[n - 1] + n * periods[n] + (n + 1) * periods[n + 1]) * 8
                / (double) (periods[n - 1] + periods[n] + periods[n + 1]);

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
