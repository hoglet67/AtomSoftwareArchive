package uk.co.acornatom.wavtoatm;

import java.util.List;

public interface BlockDecoder {

	List<Block> decodeBlocks(byte[] bytes);
	
}
