package uk.co.acornatom.wavtoatm;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.List;

public class BlockDecoderStandard extends BlockDecoderBase {

    private static boolean DEBUG = false;
    private static final int ASCII_STAR = '*';
    private static final int ASCII_CR = 13;

    private enum STATE {
        SYNC0, SYNC1, SYNC2, SYNC3, FILENAME, BLOCKFLAG, BLOCKNUMLO, BLOCKNUMHI, DATALEN, EXECHI, EXECLO, LOADHI, LOADLO, DATA, CKSUM
    }

    public BlockDecoderStandard() {
    }

    @Override
    public List<Block> decodeBlocks(byte[] bytes) {

        List<Block> blocks = new ArrayList<Block>();

        STATE state = STATE.SYNC0;
        STATE oldState = state;

        String filename = null;
        int flag = 0;
        int loadAddr = 0;
        int execAddr = 0;
        int len = 0;
        int count = 0;
        int num = 0;
        int checksum = 0;
        ByteArrayOutputStream data = null;

        for (int i = 0; i < bytes.length; i++) {

            int b = (((int) bytes[i]) + 0x100) & 0xff;

            oldState = state;
            switch (state) {
            case SYNC0:

                flag = 0;
                loadAddr = 0;
                execAddr = 0;
                len = 0;
                num = 0;
                checksum = 0xa8; // Sum of ****
                filename = "";

                if (b == ASCII_STAR) {
                    state = STATE.SYNC1;
                } else {
                    state = STATE.SYNC0;
                }
                break;
            case SYNC1:
                if (b == ASCII_STAR) {
                    state = STATE.SYNC2;
                } else {
                    state = STATE.SYNC0;
                }
                break;
            case SYNC2:
                if (b == ASCII_STAR) {
                    state = STATE.SYNC3;
                } else {

                    // cope with case of sync marker truncated
                    checksum += b;
                    filename = filename + (char) b;
                    if (DEBUG) {
                        log("    WARNING: Block Sync truncated to **");
                    }

                    state = STATE.FILENAME;
                }
                break;
            case SYNC3:
                if (b == ASCII_STAR) {
                    state = STATE.FILENAME;
                } else {

                    // cope with case of sync marker truncated
                    checksum += b;
                    filename = filename + (char) b;
                    if (DEBUG) {
                        log("    WARNING: Block Sync truncated to ***");
                    }

                    state = STATE.FILENAME;
                }
                break;

            case FILENAME:
                checksum += b;
                if (b == ASCII_CR) {
                    state = STATE.BLOCKFLAG;
                } else if (filename.length() > 13) {
                    if (DEBUG) {
                        log("    ERROR: Filename too long: " + Block.cleanFilename(filename));
                    }
                    state = STATE.SYNC0;
                } else {
                    filename = filename + (char) b;
                }
                break;
            case BLOCKFLAG:
                checksum += b;
                flag = b;
                state = STATE.BLOCKNUMHI;
                break;
            case BLOCKNUMHI:
                checksum += b;
                num += b * 256;
                state = STATE.BLOCKNUMLO;
                break;
            case BLOCKNUMLO:
                checksum += b;
                num += b;
                state = STATE.DATALEN;
                break;
            case DATALEN:
                checksum += b;
                len = b;
                count = len;
                state = STATE.EXECHI;
                break;
            case EXECHI:
                checksum += b;
                execAddr += b * 256;
                state = STATE.EXECLO;
                break;
            case EXECLO:
                checksum += b;
                execAddr += b;
                state = STATE.LOADHI;
                break;
            case LOADHI:
                checksum += b;
                loadAddr += b * 256;
                state = STATE.LOADLO;
                break;
            case LOADLO:
                checksum += b;
                loadAddr += b;

                if (DEBUG) {
                    log("### " + Block.cleanFilename(filename) + " " + Block.toHex2(flag) + " " + Block.toHex4(num) + " "
                            + Block.toHex2(len) + " " + Block.toHex4(loadAddr) + " " + Block.toHex4(execAddr));
                }
                data = new ByteArrayOutputStream();
                state = STATE.DATA;
                break;
            case DATA:
                checksum += b;
                data.write(b);
                count--;
                if (count < 0) {
                    state = STATE.CKSUM;
                }
                break;
            case CKSUM:

                boolean cksumGood = b == (checksum & 255);

                if (!cksumGood) {
                    if (DEBUG) {
                        log("    ERROR: Bad Checksum; expected " + Block.toHex2(checksum & 255) + " actual " + Block.toHex2(b));
                    }
                    // We might have lost sync, so back off a few bytes
                    i -= 8;
                }

                Block block = new Block();
                block.setFlag(flag);
                block.setLoadAddr(loadAddr);
                block.setExecAddr(execAddr);
                block.setChecksum(b);
                block.setChecksumValid(cksumGood);
                block.setLen(len + 1);
                block.setFileName(filename);
                block.setBytes(data.toByteArray());

                if (num <= Block.BLOCK_NUM_MAX) {
                    block.setNum(num);
                } else {
                    block.setNum(Block.BLOCK_NUM_MAX);
                    block.updateChecksumValid();
                }

                blocks.add(block);

                state = STATE.SYNC0;
                break;
            }
            if (DEBUG) {
                log(b + " " + oldState + "->" + state);
            }
        }
        return blocks;
    }

    private void log(String message) {
        System.out.println(message);
    }

}
