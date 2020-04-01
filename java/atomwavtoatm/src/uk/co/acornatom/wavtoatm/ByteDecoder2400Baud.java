package uk.co.acornatom.wavtoatm;

import java.io.ByteArrayOutputStream;

public class ByteDecoder2400Baud extends ByteDecoderBase {

    public ByteDecoder2400Baud(WaveformSquarer squarer) {
        super(squarer);
    }

    @Override
    public int getOptimizationParamMin() {
        return 1660 - 100;
    }

    @Override
    public int getOptimizationParamMax() {
        return 1660 + 100;
    }


    @Override
    public int getOptimizationStep() {
        return 5;
    }

    @Override
    public void initialize(int[] samples) {
        this.samples = squarer.square(samples);
    }

    @Override
    public byte[] decodeBytes(int numBytes, int start, int optimationParam) {

        int countThresh = optimationParam;

        double cswmul = (double) 4000000 / (double) squarer.getSampleRate();

        ByteArrayOutputStream bos = new ByteArrayOutputStream();

        int last = 0;
        int header = 0;
        boolean cinbyte = false;

        int byt = 0;
        int bitsleft = 0;
        int c = 0;
        int count = 0;

        //        System.out.println("Decoding with countThread = " + countThresh);

        for (int i = 0; i < samples.length; i++) {
            if (samples[i] == 1) {
                // d is the number of 4MHz cycles since the last zero crossing
                // a "1" at 2400 baud is 2 cycles of 4800Hz (edge crossings ever d=417 on average)
                // a "0" at 2400 baud is 1 cycle of 2400Hz (edge crossings every d=833 on average)
                int d = (int) (((double) (i - last)) * cswmul + 0.5);
                //System.out.println("d = " + d);
                if (header < 1000) {
                    if (d > 600) {
                        header = 0;
                    } else {
                        header++;
                    }
                } else if (!cinbyte) {
                    //System.out.println("X");
                    if (d > 600) { /*0*/
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
                        if (c >= 3) {
                            byt = (byt >> 1) | 0x80;
                        } else {
                            byt >>= 1;
                        }
                        bitsleft--;
                        if (bitsleft == 1) {
                            bos.write(byt);
                            //                            System.out.println("Byte = " + String.format("%02X", byt));
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
        return "2400 Baud Byte Decoder with " + squarer;
    }


}
