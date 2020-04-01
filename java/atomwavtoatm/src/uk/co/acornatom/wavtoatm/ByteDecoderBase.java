package uk.co.acornatom.wavtoatm;

public abstract class ByteDecoderBase implements ByteDecoder {

    protected WaveformSquarer squarer;
    protected int[] samples;

    public ByteDecoderBase(WaveformSquarer squarer) {
        this.squarer = squarer;
    }
    
    public void close() {
        samples = null;
    }

}
