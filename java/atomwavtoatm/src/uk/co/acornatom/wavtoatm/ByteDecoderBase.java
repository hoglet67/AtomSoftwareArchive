package uk.co.acornatom.wavtoatm;

public abstract class ByteDecoderBase implements ByteDecoder {

	protected WaveformSquarer squarer;
	protected int[] samples;

	private double bitLength = -1;

	public ByteDecoderBase(WaveformSquarer squarer) {
		this.squarer = squarer;
	}

	public double getBitLength() {
		if (bitLength < 0) {
			bitLength = squarer.getBitLength();
		}
		return bitLength;
	}

	public void close() {
		samples = null;
	}

}
