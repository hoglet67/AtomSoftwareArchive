package uk.co.acornatom.wavtoatm;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import uk.co.acornatom.wavtoatm.Block.Field;

public class Optimizer {

    private int numChannels;
    private int numFrames;
    private int sampleRate;

    public Optimizer() {
    }

    private short[] readWavIntoMemory(File file, boolean log) throws IOException {

        // Open the wav file specified as the first argument
        WavFile wavFile = WavFile.openWavFile(file);

        // Get the number of audio channels in the wav file
        numChannels = wavFile.getNumChannels();
        numFrames = (int) wavFile.getNumFrames();
        sampleRate = (int) wavFile.getSampleRate();

        // Display information about the wav file
        if (log) {
            wavFile.display();
            System.out.println("@@@ Num Channels = " + numChannels);
            System.out.println("@@@ Num Frames = " + numFrames);
            System.out.println("@@@ Sample Rate = " + sampleRate);
            System.out.println("@@@ Duration = " + numFrames / sampleRate + " secs");
        }

        // Create a buffer to hold all of the samples
        short[] samples = new short[numFrames * numChannels];

        int framesRead = wavFile.readFrames(samples, numFrames);

        if (framesRead != numFrames) {
            System.out.println("@@@ Unexpected number of frames read: expected=" + numFrames + "; actual=" + framesRead);
        }

        // Close the wavFile
        wavFile.close();

        return samples;
    }

    private int[] extractChannel(short[] samples, int channel, int numChannels) {
            int numFrames = samples.length / numChannels;
            int[] newSamples = new int[numFrames];
            int j = channel;
            for (int i = 0; i < numFrames; i++) {
                newSamples[i] = samples[j];
                j += numChannels;
            }
            return newSamples;
    }

    private int[] mergeChannels(short[] samples, int numChannels) {
            int[] newSamples = new int[numFrames];
            int j = 0;
            for (int i = 0; i < numFrames; i++) {
                newSamples[i] = (samples[j] + samples[j + 1]) / 2;
                j += numChannels;
            }
            return newSamples;
    }

    public void process(List<File> srcFiles, File dstDir, boolean baud2400) throws IOException {

        int totalGoodBlocks = 0;
        int totalBadBlocks = 0;
        int totalMissingBlocks = 0;
        int totalBlocks = 0;

        int window1 = 8; // smooth wav by averaging over window1 samples
        int window2 = 5; // smooth number of cycles in the next bit by averaging
                            // over bitlength / windows2 samples

        boolean bothEdges = true;
        int frequency = 2400;

        BlockDecoder blockDecoder = new BlockDecoderStandard();

        for (File srcFile : srcFiles) {

            String dirName = srcFile.getName().toUpperCase();
            dirName = dirName.replace(".WAV", "");
            dirName = dirName.replace("_", "");
            File dstTape = new File(dstDir, "" + dirName);
            dstTape.mkdirs();

            short[] origSamples = readWavIntoMemory(srcFile, true);

            Map<FileSelector, Map<Integer, Set<Block>>> fileMapRecent = new TreeMap<FileSelector, Map<Integer, Set<Block>>>();
            Map<FileSelector, Map<Integer, Set<Block>>> fileMapAllGood = new TreeMap<FileSelector, Map<Integer, Set<Block>>>();
            Map<FileSelector, Map<Integer, Set<Block>>> fileMapAllBad = new TreeMap<FileSelector, Map<Integer, Set<Block>>>();

            // Assumes that left and right are carrying the same signal
            // So if decoding of left is successful it's OK to skip right
            boolean perfect = false;

            Set<FileSelector> expectedFilenames = new HashSet<FileSelector>();

            // for mono we just decode that channel
            // for stereo we decode L, R and (L+R)/2
            for (int channel = 0 ; channel <= (numChannels > 1 ? 2 : 0); channel++) {

                System.out.println("@@@ " + srcFile.getName() + " channel " + channel);

                // Inefficient to read the wav multiple times, but saves memory
                origSamples = readWavIntoMemory(srcFile, false);
                int[] samples;
                if (channel < numChannels ) {
                    samples = extractChannel(origSamples, channel, numChannels);
                } else {
                    samples = mergeChannels(origSamples, numChannels);
                }
                origSamples = null;

                List<ByteDecoder> byteDecoders = new ArrayList<ByteDecoder>();

                if (baud2400) {

                   // With my example so far, 1700...2700 seems to work
                   for (int i = 3500; i >= 1500; i = i - 500) {
                      byteDecoders.add(new ByteDecoder2400Baud(new WaveformSquarerUsingLowPassFilter(i, sampleRate, 4800, bothEdges)));
                   }
                   byteDecoders.add(new ByteDecoder2400Baud(new WaveformSquarerUsingSign(sampleRate, 4800, bothEdges)));
                   for (int i = 1; i < 10; i++) {
                      byteDecoders.add(new ByteDecoder2400Baud(new WaveformSquarerUsingDifferentiation(i, sampleRate, 4800, bothEdges)));
                   }

                } else {

                   WaveformSquarer diffSquarer = new WaveformSquarerUsingDifferentiation(window1, sampleRate, frequency, bothEdges);
                   WaveformSquarer lowPass300Squarer = new WaveformSquarerUsingLowPassFilter(300, sampleRate, frequency, bothEdges);
                   WaveformSquarer lowPass700Squarer = new WaveformSquarerUsingLowPassFilter(700, sampleRate, frequency, bothEdges);
                   // byteDecoders.add(new ByteDecoderKees());
                   byteDecoders.add(new ByteDecoderAtomulator(lowPass700Squarer));
                   byteDecoders.add(new ByteDecoderOld(lowPass700Squarer, window2));
                   byteDecoders.add(new ByteDecoderAtomulator(diffSquarer));
                   byteDecoders.add(new ByteDecoderOld(diffSquarer, window2));
                   byteDecoders.add(new ByteDecoderAtomulator(lowPass300Squarer));
                   byteDecoders.add(new ByteDecoderOld(lowPass300Squarer, window2));

                }

                for (ByteDecoder byteDecoder : byteDecoders) {
                    System.out.println("@@@ Decoding with " + byteDecoder);
                    byteDecoder.initialize(samples);
                    // fileMapLast will contain the best attempt by this decoder
                    Map<FileSelector, Map<Integer, Set<Block>>> fileMapLast = new TreeMap<FileSelector, Map<Integer, Set<Block>>>();
                    perfect = optimizeParam(byteDecoder, blockDecoder, expectedFilenames, fileMapLast, fileMapAllGood,
                            fileMapAllBad);
                    // dumpMap("fileMapLast", fileMapLast);
                    // dumpMap("fileMapRecent", fileMapRecent);
                    mergeFileMaps(fileMapLast, fileMapRecent);
                    // dumpMap("fileMapLast", fileMapLast);
                    // dumpMap("fileMapRecent", fileMapRecent);
                    // Important to allow memory to be garbage collected
                    byteDecoder.close();
                    if (perfect) {
                        break;
                    }
                }
                if (perfect) {
                    break;
                }

            }
            // dumpMap("fileMapRecent", fileMapRecent);
            // dumpMap("fileMapAllGood", fileMapAllGood);
            // dumpMap("fileMapAllBad", fileMapAllBad);
            Map<FileSelector, List<Block>> results = outputMap(expectedFilenames, fileMapRecent, fileMapAllGood, fileMapAllBad);
            int numGoodBlocks = 0;
            int numBadBlocks = 0;
            int numBlocks = 0;
            int numMissingBlocks = 0;
            for (FileSelector fileName : results.keySet()) {

                String unixFileName = unixFileName(fileName.getFileName());
                File dstFile = new File(dstTape, unixFileName);
                int i = 1;
                while (dstFile.exists()) {
                    dstFile = new File(dstTape, unixFileName + i);
                    i++;
                }
                System.out.println(dstFile.getName());

                List<Block> blockList = results.get(fileName);
                for (int blockNum = 0; blockNum < blockList.size(); blockNum++) {
                    Block block = blockList.get(blockNum);
                    if (block == null) {
                        System.out.println("   " + Block.cleanFilename(fileName.getFileName()) + " " + Block.toHex4(blockNum)
                                + " missing");
                    } else {
                        System.out.println("   " + block);
                    }
                }

                ByteArrayOutputStream bos = new ByteArrayOutputStream();

                // Calculate the addresses
                int loadAddr = -1;
                int execAddr = -1;
                for (int blockNum = 0; blockNum < blockList.size(); blockNum++) {
                    Block block = blockList.get(blockNum);
                    if (block != null) {
                        numBlocks++;
                        if (block.isCheckSumValid()) {
                            numGoodBlocks++;
                        } else {
                            numBadBlocks++;
                        }
                        if (loadAddr < 0 || execAddr < 0) {
                            if (block.isCheckSumValid()) {
                                loadAddr = block.getLoadAddr() - blockNum * 0x100;
                                execAddr = block.getExecAddr();
                            }
                        }
                        bos.write(block.getBytes());
                    } else {
                        numMissingBlocks++;
                        for (i = 0; i < 255; i++) {
                            bos.write((byte) 0);
                        }
                    }
                }

                FileOutputStream fos = new FileOutputStream(dstFile);
                writeATMFile(fos, fileName.getFileName(), loadAddr, execAddr, bos.toByteArray());
                fos.close();
            }

            System.out.println("@@@ wav stats\t" + numGoodBlocks + "\t" + numBadBlocks + "\t" + numBlocks + "\t" + numMissingBlocks
                    + " " + srcFile.getName());

            totalGoodBlocks += numGoodBlocks;
            totalBadBlocks += numBadBlocks;
            totalBlocks += numBlocks;
            totalMissingBlocks += numMissingBlocks;

        }

        System.out.println("@@@ total stats\t" + totalGoodBlocks + "\t" + totalBadBlocks + "\t" + totalBlocks + "\t"
                + totalMissingBlocks);

    }

    private String unixFileName(String s) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < s.length(); i++) {
            Character c = s.charAt(i);
            if (c > 32 && c < 127 && Character.isLetterOrDigit(c)) {
                sb.append(c);
            }
        }
        s = sb.toString();
        if (s.length() > 7) {
            s = s.substring(0, 7);
        }
        return s.toUpperCase();
    }

    protected void writeATMFile(OutputStream out, String title, int loadAddr, int execAddr, byte[] data) throws IOException {
        writeString(out, title);
        for (int i = 0; i < 16 - title.length(); i++) {
            out.write(0);
        }
        writeShort(out, loadAddr);
        writeShort(out, execAddr);
        writeShort(out, data.length);
        out.write(data);
    }

    private void writeString(OutputStream out, String value) throws IOException {
        out.write(value.getBytes());
    }

    private void writeShort(OutputStream out, int value) throws IOException {
        byte[] buffer = new byte[2];
        buffer[0] = (byte) (value & 0xff);
        buffer[1] = (byte) ((value >> 8) & 0xff);
        out.write(buffer);
    }

    private void mergeFileMaps(Map<FileSelector, Map<Integer, Set<Block>>> fromFileMap,
            Map<FileSelector, Map<Integer, Set<Block>>> toFileMap) {
        for (FileSelector fileName : fromFileMap.keySet()) {
            Map<Integer, Set<Block>> fromBlockMap = fromFileMap.get(fileName);
            Map<Integer, Set<Block>> toBlockMap = toFileMap.get(fileName);
            if (toBlockMap == null) {
                toBlockMap = new TreeMap<Integer, Set<Block>>();
                toFileMap.put(fileName, toBlockMap);
            }
            mergeBlockMaps(fromBlockMap, toBlockMap);
        }
    }

    private void mergeBlockMaps(Map<Integer, Set<Block>> fromBlockMap, Map<Integer, Set<Block>> toBlockMap) {
        for (int blockNum : fromBlockMap.keySet()) {
            Set<Block> fromSet = fromBlockMap.get(blockNum);
            Set<Block> toSet = toBlockMap.get(blockNum);
            if (toSet == null) {
                toSet = new HashSet<Block>();
                toBlockMap.put(blockNum, toSet);
            }
            for (Block block : fromSet) {
                toSet.add(block);
            }
        }
    }

    private boolean isComplete(Set<FileSelector> fileNames, Map<FileSelector, Map<Integer, Set<Block>>> fileMap) {
        if (fileNames == null || fileNames.size() == 0 || fileMap == null || fileMap.size() == 0) {
            return false;
        }
        for (FileSelector fileName : fileNames) {
            Map<Integer, Set<Block>> blockMap = fileMap.get(fileName);
            if (blockMap == null) {
                return false;
            }
            int expect = 0;
            boolean lastBlockFound = false;
            while (!lastBlockFound) {
                Set<Block> blocks = blockMap.get(expect);
                // If a block is missing block, then we've more to do
                if (blocks == null) {
                    return false;
                }
                // Look for a block with a good checksum
                boolean blockFound = false;
                for (Block block : blocks) {
                    if (block.isCheckSumValid()) {
                        if (block.getFlag() < 128) {
                            lastBlockFound = true;
                        }
                        blockFound = true;
                        break;
                    }
                }
                // If a block is bad, then we've more to do
                if (!blockFound) {
                    return false;
                }
                expect++;
            }
        }
        return true;
    }

    // private void dumpMap(String name, Map<String, Map<Integer, Set<Block>>>
    // fileMap) {
    // System.out.println(name);
    // for (String fileName : fileMap.keySet()) {
    // System.out.println("    " + Block.cleanFilename(fileName));
    // Map<Integer, Set<Block>> blockMap = fileMap.get(fileName);
    // for (Map.Entry<Integer, Set<Block>> entry : blockMap.entrySet()) {
    // System.out.println("        " + entry.getKey());
    // for (Block block : entry.getValue()) {
    // System.out.println("            " + block);
    // }
    // }
    // }
    // }

    private Map<FileSelector, List<Block>> outputMap(Set<FileSelector> expectedFilenames,
            Map<FileSelector, Map<Integer, Set<Block>>> fileMap, Map<FileSelector, Map<Integer, Set<Block>>> fileMapAllGood,
            Map<FileSelector, Map<Integer, Set<Block>>> fileMapAllBad) {

        Map<FileSelector, List<Block>> results = new TreeMap<FileSelector, List<Block>>();
        for (FileSelector fileName : expectedFilenames) {
            List<Block> blockList = new ArrayList<Block>();
            Map<Integer, Set<Block>> blockMap = fileMap.get(fileName);
            int blockNum = 0;
            Block block = null;
            while (blockNum <= Block.BLOCK_NUM_MAX && (block == null || block.getFlag() >= 128)) {
                Set<Block> blocks = null;
                if (blockMap != null) {
                    blocks = blockMap.get(blockNum);
                } else {
                    System.out.println("@@@ decode missing block map for " + fileName);
                }
                if (blocks != null) {
                    block = findBestBlock(fileName, blockNum, blocks);
                } else {
                    block = findBestBlock(fileName, blockNum, fileMapAllGood, fileMapAllBad);
                }
                blockList.add(block);
                blockNum++;
            }
            // Prune any missing blocks from the end
            for (blockNum = blockList.size() - 1; blockNum >= 0; blockNum--) {
                block = blockList.get(blockNum);
                if (block == null) {
                    blockList.remove(blockNum);
                } else {
                    break;
                }
            }
            results.put(fileName, blockList);
        }
        return results;
    }

    private Block findBestBlock(FileSelector fileName, int blockNum, Map<FileSelector, Map<Integer, Set<Block>>> fileMapAllGood,
            Map<FileSelector, Map<Integer, Set<Block>>> fileMapAllBad) {
        Block block = findBestBlock(fileName, blockNum, fileMapAllGood);
        if (block == null) {
            block = findBestBlock(fileName, blockNum, fileMapAllBad);
        }
        return block;
    }

    private Block findBestBlock(FileSelector fileName, int blockNum, Map<FileSelector, Map<Integer, Set<Block>>> fileMap) {
        Map<Integer, Set<Block>> blockMap = fileMap.get(fileName);
        if (blockMap == null) {
            return null;
        }
        Set<Block> blocks = blockMap.get(blockNum);
        if (blocks == null || blocks.isEmpty()) {
            return null;
        }
        return findBestBlock(fileName, blockNum, blocks);
    }

    private Block findBestBlock(FileSelector blockSelector, int blockNum, Set<Block> blocks) {
        String fileName = blockSelector.getFileName();
        if (blocks.size() == 1) {
            Block block = blocks.iterator().next();
            block.updateChecksumValid();
            return block;
        } else if (blocks.size() == 0) {
            System.out.println("@@@ " + Block.cleanFilename(fileName) + " " + Block.toHex4(blockNum) + " is missing");
            return null;
        } else {
            for (Block block : blocks) {
                if (block.isCheckSumValid()) {
                    return block;
                }
            }

            System.out.println("@@@ " + Block.cleanFilename(fileName) + " " + Block.toHex4(blockNum) + " has " + blocks.size()
                    + " instances, recovering data");
            Block block = new Block();
            block.setFileName(fileName);
            block.setNum(blockNum);
            block.setLoadAddr(getField(Field.LOADADDR, -1, blocks));
            block.setExecAddr(getField(Field.EXECADDR, -1, blocks));
            block.setChecksum(getField(Field.CHECKSUM, -1, blocks));
            block.setFlag(getField(Field.FLAG, -1, blocks));
            int len = getField(Field.LEN, -1, blocks);
            if (len > 256) {
                len = 256;
            }
            block.setLen(len);
            byte[] bytes = new byte[len];
            block.setBytes(bytes);
            for (int i = 0; i < len; i++) {
                bytes[i] = (byte) getField(null, i, blocks);
            }
            block.updateChecksumValid();
            System.out.println("@@@ " + Block.cleanFilename(fileName) + " " + Block.toHex4(blockNum) + " recovery was "
                    + (block.isCheckSumValid() ? "successful" : "unsuccessful"));
            return block;
        }
    }

    private int getField(Field field, int index, Set<Block> blocks) {
        Map<Integer, Integer> stats = new TreeMap<Integer, Integer>();
        for (Block block : blocks) {
            int val = -1;
            if (field != null) {
                val = block.getField(field);
            } else {
                if (index < block.getBytes().length) {
                    val = 0xff & block.getBytes()[index];
                }
            }
            if (val >= 0) {
                Integer count = stats.get(val);
                if (count == null) {
                    count = 0;
                }
                stats.put(val, count + 1);
            }
        }
        int bestVal = -1;
        int bestCount = -1;
        for (Map.Entry<Integer, Integer> entry : stats.entrySet()) {
            // if (field != null) {
            // System.out.println("    " + field + " " +
            // Block.toHex4(entry.getKey()) + " occurred " + entry.getValue() +
            // " times");
            // } else {
            // System.out.println("    data[" + index + "] " +
            // Block.toHex2(entry.getKey()) + " occurred " + entry.getValue() +
            // " times");
            // }
            if (entry.getValue() > bestCount) {
                bestCount = entry.getValue();
                bestVal = entry.getKey();
            }
        }
        // if (field != null) {
        // System.out.println("    " + field + " best value " +
        // Block.toHex4(bestVal));
        // } else {
        // System.out.println("    data[" + index + "] best value " +
        // Block.toHex4(bestVal));
        // }
        return bestVal;
    }

    private void updateMap(Map<FileSelector, Map<Integer, Set<Block>>> fileMapGood,
            Map<FileSelector, Map<Integer, Set<Block>>> fileMapBad, List<Block> blocks) {
        for (Block block : blocks) {
            Map<FileSelector, Map<Integer, Set<Block>>> fileMap = block.isCheckSumValid() ? fileMapGood : fileMapBad;
            if (fileMap == null) {
                continue;
            }
            Map<Integer, Set<Block>> blockMap = fileMap.get(block.getSelector());
            if (blockMap == null) {
                blockMap = new TreeMap<Integer, Set<Block>>();
                fileMap.put(block.getSelector(), blockMap);
            }

            Set<Block> goodSet = blockMap.get(block.getNum());
            if (goodSet == null) {
                goodSet = new HashSet<Block>();
                blockMap.put(block.getNum(), goodSet);
            }
            goodSet.add(block);
        }
    }

    public boolean optimizeParam(ByteDecoder byteDecoder, BlockDecoder blockDecoder,
            Set<FileSelector> expectedFilenames,
            Map<FileSelector, Map<Integer, Set<Block>>> fileMapRecent,
            Map<FileSelector, Map<Integer, Set<Block>>> fileMapAllGood,
            Map<FileSelector, Map<Integer, Set<Block>>> fileMapAllBad) {


        int best = -1;
        int bestThreshold1 = 0;
        int bestThreshold2 = 0;

        int loThreshold = byteDecoder.getOptimizationParamMin();
        int hiThreshold = byteDecoder.getOptimizationParamMax();
        int step = byteDecoder.getOptimizationStep();

        System.out.println("@@@ Optimizer range: " + loThreshold + " to " + hiThreshold + " in steps of " + step);

        byte[] bytes;
        List<Block> blocks;

        int mid = (hiThreshold + loThreshold) / 2;
        int numPoints = step == 0 ? 0 : (hiThreshold - loThreshold) / step;

        // Example:
        // 500 to 1000 step 5
        // mid = 750
        // numPoints = 100
        // i =   1; threshold =  750
        // i =   2; threshold =  745
        // i =   3; threshold =  755
        // i = 100; threshold =  500
        // i = 101; threshold = 1000

        boolean loDone = false;
        boolean hiDone = false;

        for (int i = 1; i <= numPoints + 1; i++) {

            if (loDone && hiDone) {
                break;
            }

            // Start at the mid point
            int threshold;
            if ((i & 1 ) == 1) {
                threshold = mid + (i >> 1) * step;
                if (hiDone) {
                    continue;
                }
            } else {
                threshold = mid - (i >> 1) * step;
                if (loDone) {
                    continue;
                }
            }

            bytes = byteDecoder.decodeBytes(Integer.MAX_VALUE, 0, threshold);
            blocks = blockDecoder.decodeBlocks(bytes);

            int numBlocks = blocks.size();
            int numGoodBlocks = getNumGoodBlock(blocks);
            int numBadBlocks = numBlocks - numGoodBlocks;

            System.out.println("### Threshold = " + threshold + " numGoodBlocks = " + numGoodBlocks + "; numBadBlocks = " + numBadBlocks + "; total = " + numBlocks);;

            if ((i & 1) == 1) {
                if (best > 0 && numGoodBlocks == 0) {
                    hiDone = true;
                }
            } else {
                if (best > 0 && numGoodBlocks == 0) {
                    loDone = true;
                }
            }

            if (numGoodBlocks > best) {
                best = numGoodBlocks;
                bestThreshold1 = threshold;
                bestThreshold2 = threshold;
            } else if (numGoodBlocks == best) {
                if (threshold < bestThreshold1) {
                    bestThreshold1 = threshold;
                }
                if (threshold > bestThreshold2) {
                    bestThreshold2 = threshold;
                }
            }

            // Keep all the decoded blocks, so we can do the best with bad decodes
            updateMap(fileMapAllGood, fileMapAllBad, blocks);

            // If we get a perfect last set of blocks, then exit
            Map<FileSelector, Map<Integer, Set<Block>>> fileMapLast = new TreeMap<FileSelector, Map<Integer,Set<Block>>>();
            updateMap(fileMapLast, null, blocks);

            // Update the expected filenames from the good blocks
            addToExpectedFilenames(blocks, expectedFilenames);

            if (isComplete(expectedFilenames, fileMapLast)) {
                mergeFileMaps(fileMapLast, fileMapRecent);
                System.out.println("@@@ Perfect decode at : " + threshold + " numGoodBlocks = " + numGoodBlocks + "; numBadBlocks = " + numBadBlocks + "; total = " + numBlocks);
                for (Block block : blocks) {
                    System.out.println("@@@ block " + block);
                }
                return true;
            }

        }

        // If we get to here, then it's an partial decode, so use the best value we found
        int threshold = (bestThreshold1 + bestThreshold2) / 2;
        bytes = byteDecoder.decodeBytes(Integer.MAX_VALUE, 0, threshold);
        blocks = blockDecoder.decodeBlocks(bytes);

        int numBlocks = blocks.size();
        int numGoodBlocks = getNumGoodBlock(blocks);
        int numBadBlocks = numBlocks - numGoodBlocks;

        //for (Block block : blocks) {
        //  System.out.println("### " + block);
        //}

        System.out.println("@@@ Partial decode at : [" + bestThreshold1 + "," + bestThreshold2 + "] using " + threshold + " numGoodBlocks = " + numGoodBlocks + "; numBadBlocks = " + numBadBlocks + "; total = " + numBlocks);;

        updateMap(fileMapRecent, null, blocks);
        for (Block block : blocks) {
            System.out.println("@@@ block " + block);
        }

        return false;

    }

    private void addToExpectedFilenames(List<Block> blocks, Set<FileSelector> expectedFilenames) {
        Map<FileSelector, Integer> goodFilenameCounts = new HashMap<FileSelector, Integer>();
        Map<FileSelector, Integer> badFilenameCounts = new HashMap<FileSelector, Integer>();
        Set<FileSelector> goodFileNames = new HashSet<FileSelector>();

        for (Block block : blocks) {
            if (block.isFileNameValid() && block.getNum() < Block.BLOCK_NUM_MAX) {
                FileSelector fileName = block.getSelector();
                goodFileNames.add(fileName);
                Map<FileSelector, Integer> filenameCounts = block.isCheckSumValid() ? goodFilenameCounts : badFilenameCounts;
                Integer count = filenameCounts.get(fileName);
                if (count == null) {
                    count = 0;
                }
                count++;
                filenameCounts.put(fileName, count);
            }
        }

        for (Block block : blocks) {
            FileSelector fileName = block.getSelector();
            if (expectedFilenames.contains(fileName)) {
                continue;
            }
            Integer goodCount = goodFilenameCounts.get(fileName);
            if (goodCount == null) {
                goodCount = 0;
            }
            Integer badCount = badFilenameCounts.get(fileName);
            if (badCount == null) {
                badCount = 0;
            }
            boolean add = false;
            if (goodCount > 1) {
                add = true;
            } else if (goodCount == 1 && badCount <= 2 && block.getNum() <= 2 && block.getFlag() < 128) {
                add = true;
            }
            if (add) {
                System.out.println("@@@ adding to expected: " + block + " (good=" + goodCount + "; bad=" + badCount + ")");
                System.out.println("@@@ expected now: " + Block.cleanFilenames(expectedFilenames));
                expectedFilenames.add(fileName);
            }
        }
    }

    private int getNumGoodBlock(List<Block> blocks) {
        int num = 0;
        for (Block block : blocks) {
            if (block.isCheckSumValid()) {
                num++;
            }
        }
        return num;
    }

    public static void main(String[] args) {

        try {

            boolean baud2400 = false;

            // Very primitive option parsing
            int i = 0;
            while (i < args.length && args[i].startsWith("-")) {
                if (args[i].equals("-x")) {
                    baud2400 = true;
                } else {
                    System.out.println("Unknown options: " + args[i]);
                    System.exit(1);
                }
                i++;
            }

            if (args.length < 2 + i) {
                System.out.println("usage: java -jar atomwavtoatm.jar [-x] <Dst ATM Dir> <Src Wav/Dat File or Directory>... ");
                System.exit(1);
            }

            File dstDir = new File(args[i]);
            dstDir.mkdirs();
            i++;

            List<File> srcFiles = new ArrayList<File>();
            while (i < args.length) {

                File src = new File(args[i]);
                if (!src.exists()) {
                    System.out.println("Source: " + src + " does not exist");
                    System.exit(1);
                }

                if (src.isDirectory()) {
                    for (String file : src.list(new FilenameFilter() {
                        @Override
                        public boolean accept(File dir, String name) {
                            return name.toLowerCase().endsWith(".wav") || name.toLowerCase().endsWith(".dat");
                        }
                    })) {
                        srcFiles.add(new File(src, file));
                    }
                } else {
                    srcFiles.add(src);
                }

                i++;
            }

            Collections.sort(srcFiles);

            Optimizer optimizer = new Optimizer();

            optimizer.process(srcFiles, dstDir, baud2400);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
