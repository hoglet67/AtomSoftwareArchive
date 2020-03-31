package uk.co.acornatom.wavtoatm;

public interface ByteDecoder {

	public int getOptimizationParamMin();

	public int getOptimizationParamMax();

	public int getOptimizationStep();

	public void initialize(int[] samples);

	public void close();

	public byte[] decodeBytes(int numBytes, int start, int optimationParam);

	public double getBitLength();

}
