package uk.co.acornatom.wavtoatm;

import java.io.ByteArrayOutputStream;

public class ByteDecoderOld extends ByteDecoderBase {

    private int cyclesPerBit;
    private int window2;

    private double bitLength = -1;

    public ByteDecoderOld(WaveformSquarer squarer, int cyclesPerBit, int window2) {
        super(squarer);
        this.cyclesPerBit = cyclesPerBit;
        this.window2 = window2;
    }

    @Override
    public int getOptimizationParamMin() {        
        int factor = squarer.isBothEdges() ? 2 : 1;
        if (bitLength == -1) {
            throw new RuntimeException("bitLength not initialized");
        }
        return (int) (factor * 5 * cyclesPerBit * bitLength / 8 / window2) ;  // 180 when window2=4
    }

    @Override
    public int getOptimizationParamMax() {
        int factor = squarer.isBothEdges() ? 2 : 1;
        if (bitLength == -1) {
            throw new RuntimeException("bitLength not initialized");
        }
        return (int) (factor * 8 * cyclesPerBit * bitLength / 8 / window2); // 288 when window2=4
    }

    @Override
    public int getOptimizationStep() {
        // Step size between min and max, giving approx 50 steps
        int step = (getOptimizationParamMax() - getOptimizationParamMin()) / 50;
        if (step < 1) {
            step = 1;
        }
        return step;
    }

    @Override
    public void initialize(int[] samples) {
        samples = squarer.square(samples);
        // At 300 Baud and 44.1KHz sampling bitlength is nominally 147 samples
        bitLength = calculateBitLength(samples);
        System.out.println("@@@ BitLength = " + bitLength + " samples");
        // Compute a rolling sum of the number of zero crossings over a bit period
        samples = WaveformSquarerBase.sumOverWindow(samples, (int) (bitLength + 0.5));
        // Compute a rolling sum of the number of zero crossings over a fraction of a bit period
        // TODO: I don't recall why this is useful....
        samples = WaveformSquarerBase.sumOverWindow(samples, (int) (bitLength / window2 + 0.5));
        this.samples = samples;
    }

    @Override
    public byte[] decodeBytes(int numBytes, int start, int optimationParam) {

        // threshold represents the point of the 1 to 0 transition on the start bit
        // min: factor * 5 * bitLength / window2
        // max: factor * 8 * bitLength / window2
        
        int threshold = optimationParam;
        
        // At  300 baud, cyclesPerBit = 8, giving 12 and 6
        // At 1200 baud, cyclePerBit = 2, giving  3 and 1.5 (bothEdges must be used in his mode)
        int bitThreshold = squarer.isBothEdges() ? (cyclesPerBit * 6 / 4) : (cyclesPerBit * 6 / 8);

        ByteArrayOutputStream bos = new ByteArrayOutputStream();

        double id = start + 1;
        while (id < samples.length - 1) {
            // Find the start bit, a 1 to 0 transition
            if ((getSample(id - 1) > threshold) && (getSample(id) <= threshold)) {
                // Skip 1.5 bits
                id += bitLength * 31 / 20;

                // Sample next 8 bits
                int b = 0;
                for (int j = 0; j < 8; j++) {

                    if (getSample(id) > bitThreshold * bitLength / window2) {
                        b += 1 << j;
                    }
                    id += bitLength;
                }
                // Sample stop bit
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

    // Calculate the actual bit length in samples from the edge crossings
    // multiplied by cyclesPerBit.
    //
    // The nominal value, n, is sampleRate / high-tone-frequency.
    // (e.g. at 44100, 2400Hz is n is ~18 samples)
    //
    // The actual edge crossing data is used to refine this by +/- 1 sample
    //
    // The result is the average based on the size of the n-1, n and n+1 buckets
    // this is returned as a double.
    
    private double calculateBitLength(int[] samples) {
        int n = (int) (((double) squarer.getSampleRate() / (double) squarer.getFrequency()) + 0.5);
        int max = n * 2;
        int[] periods = new int[max];
        int last1 = 0;
        int last2 = 0;
        for (int i = 0; i < max; i++) {
            periods[i] = 0;
        }
        for (int i = 0; i < samples.length; i++) {
            if (samples[i] == 1) {
                int period = i - (squarer.isBothEdges() ? last2 : last1);
                last2 = last1;
                last1 = i;
                periods[period < max - 1 ? period : max - 1]++;
            }
        }

        return (double) ((n - 1) * periods[n - 1] + n * periods[n] + (n + 1) * periods[n + 1]) * cyclesPerBit
                / (double) (periods[n - 1] + periods[n] + periods[n + 1]);

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

    public String toString() {
        return "Dave's Byte Decoder with " + squarer;
    }

}
