package uk.co.acornatom.tape;
import java.io.IOException;
import java.io.OutputStream;

public class FreqOut {

	/*
	 * From some old text or other (ATAP probably):
	 * 
	 * A logic 0 consists of 4 cycles of a 1.2 kHz tone, and a logic 1 consists
	 * of 8 cycles of a 2.4 kHz tone.
	 * 
	 * Each byte of data is preceeded by a logic zero start bit, and is
	 * terminated by a logic 1 stop bit.
	 */

	// 1 cycle of 1200hz = 36.75 samples @ 44100hz
	// 36.75 * 4 = 147 samples
	//
	// 1 cycle of 2400hz = 18.375 samples @ 44100hz
	// 18.375 * 8 = 147 samples

	// Bit position (0..7) to mask
	//
	int _BV(int x) {
		return (1 << x);
	}

	OutputStream m_out;

	AtomFile m_atmfile;
	int m_writtenSampleCount;
	static short[] m_sine = new short[147];
	int m_checksum;
	
	static {
		// Build the output table. 4 cycles into 147 bytes.
		//
		double val = 0;
		double step = (Math.PI * 8.0) / 147.0;

		for (int i = 0; i < 147; ++i) {
			double s = Math.sin(val) * 16384.0;

			// Sinusoidal data doesn't look to good at this audio resolution,
			// so square it off.
			//
//			if (s >= 0.0) {
//				s = -16384;
//			} else {
//				s = 16384;
//			}

			m_sine[i] = (short) s;
			val += step;
		}	
	}

	public FreqOut(AtomFile atmfile, OutputStream out) {
		m_atmfile = atmfile;
		m_out = out;
		m_writtenSampleCount = 0;
	}

	// Output a 1 bit, 8 cycles of 24khz
	//
	void out1() throws IOException {
		for (int i = 0; i < 147; ++i) {
			// Double step the table for a higher frequency
			//
			short val = m_sine[(i * 2) % 147];
			byte lo = (byte) ((val >> 8) & 255);
			byte hi = (byte) (val & 255);
			m_out.write(hi);
			m_out.write(lo);
		}
		m_writtenSampleCount += 147;
	}

	// Output a 0 bit, 4 cycles of 12khz
	//
	void out0() throws IOException {
		for (int i = 0; i < 147; ++i) {
			short val = m_sine[i];
			byte lo = (byte) ((val >> 8) & 255);
			byte hi = (byte) (val & 255);
			m_out.write(hi);
			m_out.write(lo);
		}
		m_writtenSampleCount += 147;
	}

	// Output a byte plus its surrounding start & stop bit.
	// Add the byte's value to the rolling checksum.
	//

	void outByte(int value) throws IOException {
		out0();
		for (int i = 0; i < 8; ++i) {
			if ((value & _BV(i)) > 0) {
				out1();
			} else {
				out0();
			}
		}
		out1();

		m_checksum += value;
	}

	void outByte(byte value) throws IOException {
		outByte(value & 0xff);
	}

	// Write atom formatted data to the wave file.
	//
	boolean write(boolean shortheaders) throws IOException {

		int blockNum = 0;
		int blockLoadAddr = m_atmfile.getLoadAddr();

		int m_rawdata = 0;

		// Bit 7 = last block. Clear = last block.
		// Bit 6 = do load me. Set = load. Clear = don't.
		// Bit 5 = first block. Clear = first block.
		//
		int flags = _BV(7) | _BV(6);

		// Initial header time about 4 1/2 seconds. One out() call puts ~3.3ms
		// of data.
		//
		float headerTime = (float) (shortheaders ? 2500 : 4550);

		while ((flags & _BV(7)) > 0) {
			while (headerTime > 0.0) {
				out1();
				headerTime -= 3.3F;
			}

			m_checksum = 0;

			// Preamble
			//
			outByte('*');
			outByte('*');
			outByte('*');
			outByte('*');

			// Header max 14 chars, including terminator.
			//
			String filename = m_atmfile.getTitle();
			for (int i = 0; i < 14 && i < filename.length(); ++i) {
				outByte(filename.charAt(i));
			}
			outByte(0x0d);

			int blockLen = (int) (m_atmfile.getData().length - m_rawdata);
			if (blockLen < 257) {
				// flags.7 cleared to indicate last block
				//
				flags &= ~_BV(7);
			} else if (blockLen > 256) {
				// Blocks are 256 bytes max.
				//
				blockLen = 256;
			}

			/*
			 * - Header format: <*> ) <*> ) <*> ) <*> ) Header preamble
			 * <Filename> ) Name is 1 to 13 bytes long <Status Flag> ) Bit 7
			 * clear if last block ) Bit 6 clear to skip block ) Bit 5 clear if
			 * first block <MSB block number> ) Always zero <LSB block number>
			 * <Bytes in block> <MSB run address> <LSB run address> <MSB block
			 * load address> <LSB block load address>
			 */

			outByte(flags);
			outByte(0);
			outByte(blockNum & 0xff);
			outByte(blockLen - 1);
			outByte((m_atmfile.getExecAddr() & 0xff00) >> 8);
			outByte(m_atmfile.getExecAddr() & 0xff);
			outByte((blockLoadAddr & 0xff00) >> 8);
			outByte(blockLoadAddr & 0xff);

			// Header/data gap is about 1 second. One out() call puts ~3.3ms of
			// data.
			//
			headerTime = (float) (shortheaders ? 500 : 1000);
			while (headerTime > 0.0) {
				out1();
				headerTime -= 3.3F;
			}

			// Now for the data. You know you want it.
			//
			for (int i = 0; i < blockLen; ++i) {
				outByte(m_atmfile.getData()[m_rawdata + i]);
			}

			// The checksum itself gets added to the internal count, but not
			// until after it's written. It's reset again at the start of the
			// loop. So go ahead, corrupt it all you like.
			//
			outByte(m_checksum);

			blockLoadAddr += 0x100;
			m_rawdata += 0x100;
			++blockNum;

			// flags.5 is clear on first block
			//
			flags |= _BV(5);

			// Reset inter-block header time ready for leader tone at start of
			// loop.
			//
			headerTime = (float) (shortheaders ? 500 : 1000);
		}
		
		while (headerTime > 0.0) {
			out1();
			headerTime -= 3.3F;
		}

		return true;
	}
	
	public int getWrittenSampleCount() {
		return m_writtenSampleCount;
	}

	// // Write atom formatted data to the wave file - unnamed mode
	// //
	// boolean writeunnamed(boolean shortheaders) throws IOException {
	// int blockNum = 0;
	// int blockLoadAddr = m_atmfile.getLoadAddr();
	//
	// int m_rawdata = 0;
	//
	// int blockEndAddr = blockLoadAddr + atm.header.length;
	//
	// // Initial header time about 4 1/2 seconds. One out() call puts ~3.3ms of
	// data.
	// //
	// float headerTime = (float) (shortheaders ? 2500 : 4550);
	// while(headerTime > 0.0)
	// {
	// out1();
	// headerTime -= 3.3F;
	// }
	//
	// outByte(blockEndAddr / 256);
	// outByte(blockEndAddr % 256);
	// outByte(blockLoadAddr / 256);
	// outByte(blockLoadAddr % 256);
	//
	// for (int i = 0; i < atm.header.length; ++i)
	// {
	// outByte(m_atmfile.getData()[m_rawdata + i]);
	// }
	//
	// return true;
	// }
}
