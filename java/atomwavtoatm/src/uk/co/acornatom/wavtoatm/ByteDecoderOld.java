package uk.co.acornatom.wavtoatm;

import java.io.ByteArrayOutputStream;

public class ByteDecoderOld extends ByteDecoderBase {

    private int window2;

    public ByteDecoderOld(WaveformSquarer squarer, int window2) {
        super(squarer);
        this.window2 = window2;
    }

    @Override
    public int getOptimizationParamMin() {
        int factor = squarer.isBothEdges() ? 2 : 1;
        return (int) (factor * 5 * getBitLength() / window2) ;  // 180 when window2=4
    }

    @Override
    public int getOptimizationParamMax() {
        int factor = squarer.isBothEdges() ? 2 : 1;
        return (int) (factor * 8 * getBitLength() / window2); // 288 when window2=4
    }

    @Override
    public int getOptimizationStep() {
        int factor = squarer.isBothEdges() ? 2 : 1;
        int step = 4 / window2;
        if (step < 1) {
            step = 1;
        }
        return factor * step;
    }


    @Override
    public void initialize(int[] samples) {
        samples = squarer.square(samples);
        double bitLength = squarer.getBitLength();
        samples = WaveformSquarerBase.sumOverWindow(samples, (int) (bitLength + 0.5));
        samples = WaveformSquarerBase.sumOverWindow(samples, (int) (bitLength / window2 + 0.5));
        this.samples = samples;
    }

    @Override
    public byte[] decodeBytes(int numBytes, int start, int optimationParam) {

        double bitLength = getBitLength();

        int threshold = optimationParam;
        int bitThreshold = squarer.isBothEdges() ? 12 : 6;

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
