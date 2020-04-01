package uk.co.acornatom.wavtoatm;

import java.io.ByteArrayOutputStream;

public class ByteDecoderAtomulator extends ByteDecoderBase {

    private int cyclesPerBit;
    
    public ByteDecoderAtomulator(WaveformSquarer squarer, int cyclesPerBit) {
        super(squarer);
        this.cyclesPerBit = cyclesPerBit;
    }

    @Override
    public int getOptimizationParamMin() {
        // Bit period in 4MHz cycles (less 10%)
        // Was fixed at 12000 for  300 baud (now calculated at 12000)
        // Was fixed at  1560 for 1200 baud (now calculated at  1500)
        return cyclesPerBit * (4000000/10000) * 9000 / squarer.getFrequency();
    }

    @Override
    public int getOptimizationParamMax() {
        // Bit period in 4MHz cycles (plus 5%)
        // Was fixed at 13500 for  300 baud (now calculated at 14000)
        // Was fixed at  1760 for 1200 baud (now calculated at  1750)
        return cyclesPerBit * (4000000/10000) * 10500 / squarer.getFrequency();
    }

    @Override
    public int getOptimizationStep() {
        // Step size between min and max, giving approx 25 steps
        int step = (getOptimizationParamMax() - getOptimizationParamMin()) / 25;
        if (step < 1) {
            step = 1;
        }
        return step;
    }

    @Override
    public void initialize(int[] samples) {
        this.samples = squarer.square(samples);
    }

    @Override
    public byte[] decodeBytes(int numBytes, int start, int optimationParam) {

        // countThreshold is the bit period, in 4MHz cycles
        int countThresh = optimationParam;

        double cswmul = (double) 4000000 / (double) squarer.getSampleRate();

        // Threshold for discriminating between a 0 and a 1
        // (units are edges per bit period)
        // This was originally hard coded at 12
        int oneThresh = cyclesPerBit * 3 / 2;
        
        // Threshold for detecting high tone
        // (units are 4MHz cycles)
        // This was originally hard coded at 1200 (some way between 833 and 1666)
        int highToneDetectThresh = 3 * 4000000 /  squarer.getFrequency() / 4;

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
                    if (d > highToneDetectThresh) {
                        header = 0;
                    } else {
                        header++;
                    }
                } else if (!cinbyte) {
                    if (d > highToneDetectThresh) { /*0*/
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
                        if (c >= oneThresh) {
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
