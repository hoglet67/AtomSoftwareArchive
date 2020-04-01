package uk.co.acornatom.wavtoatm;


public class WaveformSquarerUsingLowPassFilter extends WaveformSquarerBase {

    private double cutoff;

    public WaveformSquarerUsingLowPassFilter(int cutoff, int sampleRate, int frequency, boolean bothEdges) {
        super(sampleRate, frequency, bothEdges);
        this.cutoff = cutoff;
    }

    @Override
    protected int[] extractZeroCrossings(int[] samples) {
        int[] baseLine = lowPassFilter(samples, sampleRate, cutoff);
        samples = compare(samples, baseLine);
        return samples;
    }

    private int[] compare(int[] samples, int[] baseline) {
        int[] newSamples = new int[samples.length];
        for (int i = 0; i < samples.length; i++) {
            newSamples[i] = samples[i] > baseline[i] ? 1000 : -1000;
        }
        return newSamples;
    }

    void getLPCoefficientsButterworth2Pole(double samplerate, double cutoff, double[] ax, double[] by)
    {
        double sqrt2 = Math.sqrt(2.0);

        double QcRaw  = (2 * Math.PI * cutoff) / samplerate; // Find cutoff frequency in [0..PI]
        double QcWarp = Math.tan(QcRaw); // Warp cutoff frequency

        double gain = 1.0 / (1.0 + sqrt2 / QcWarp + 2.0 / (QcWarp * QcWarp));
        by[2] = (1.0 - sqrt2 / QcWarp + 2.0 / (QcWarp * QcWarp)) * gain;
        by[1] = (2.0 - 2.0 * 2.0 / ( QcWarp * QcWarp)) * gain;
        by[0] = 1;
        ax[0] = 1 * gain;
        ax[1] = 2 * gain;
        ax[2] = 1 * gain;
    }

    void calcFilter(double samplerate, double cutoff, int type, double[] ax, double[] by) {
        double fudge;
        IIRFilter iir = new IIRFilter();
        iir.setPrototype(IIRFilter.BUTTERWORTH);
        iir.setFilterType(IIRFilter.LP);
        if (type == IIRFilter.LP) {
            iir.setFreq1(0);
            iir.setFreq2((float) cutoff);
            fudge = 2.0;
        } else {
            iir.setFreq1(0);
            iir.setFreq2((float) cutoff);
            fudge = -2.0;
        }
        iir.setOrder(2);
        iir.setRate((float) samplerate);
        iir.design();
        iir.setFreqPoints(1000);
        iir.filterGain();
        for (int i = 0; i <= 2; i++) {
            ax[i] = iir.getACoeff(i) * fudge;
            by[i] = iir.getBCoeff(i);
        }
    }

    private int[] lowPassFilter(int[] samples, double samplerate, double cutoff) {
        return filter(samples, samplerate, cutoff, IIRFilter.LP);
    }

//    private int[] highPassFilter(int[] samples, double samplerate, double cutoff) {
//        return filter(samples, samplerate, cutoff, IIRFilter.HP);
//    }

    private int[] filter(int[] samples, double samplerate, double cutoff,  int type) {
        int[] newSamples = new int[samples.length];
        double[] xv = new double[3];
        double[] yv = new double[3];
        double[] ax = new double[3];
        double[] by = new double[3];

        if (type == IIRFilter.LP) {
            getLPCoefficientsButterworth2Pole(samplerate, cutoff, ax, by);
        } else {
            calcFilter(samplerate, cutoff, type, ax, by);
        }

        // dumpCoeffs(ax, by);

        for (int i = 0; i < samples.length; i++) {
            xv[2] = xv[1];
            xv[1] = xv[0];
            xv[0] = samples[i];
            yv[2] = yv[1];
            yv[1] = yv[0];

            yv[0] = (ax[0] * xv[0] + ax[1] * xv[1] + ax[2] * xv[2] - by[1] * yv[0] - by[2] * yv[1]);

            newSamples[i] = (int) (yv[0] + 0.5);
        }
        return newSamples;
    }

//    private void dumpCoeffs(double[] ax, double[] by) {
//        for (int i = 0; i < ax.length; i++) {
//            System.out.println("ax[" + i + "] = " + ax[i]);
//        }
//        for (int i = 0; i < by.length; i++) {
//            System.out.println("by[" + i + "] = " + by[i]);
//        }
//    }

    public String toString() {
        return "LowPass(" + cutoff + ") based Squarer";
    }


}
