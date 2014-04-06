package uk.co.acornatom.wavtoatm;

public class FileSelector implements Comparable<FileSelector>{

	private static final boolean INCLUDE_LOAD_ADDR = true;
	
	private String fileName;
	private int loadAddr;

	public FileSelector(Block block) {
		this.fileName = block.getFileName();
		this.loadAddr = block.getLoadAddr() - 256 * block.getNum();
	}

	public String getFileName() {
		return fileName;
	}

	public int getLoadAddr() {
		return loadAddr;
	}

	@Override
	public int hashCode() {
		int prime = 31;
		int hashCode = (fileName != null ? fileName.hashCode() : 0);
		if (INCLUDE_LOAD_ADDR) {
			hashCode = prime * hashCode + loadAddr;
		}
		return hashCode;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (!(obj instanceof FileSelector)) {
			return false;
		}
		FileSelector that = (FileSelector) obj;
		if (INCLUDE_LOAD_ADDR) {
			if (loadAddr != that.loadAddr) {
				return false;
			}
		}
		return (fileName == null && that.fileName == null) || fileName.equals(that.fileName);
	}
	
	@Override
	public int compareTo(FileSelector that) {
		int ret = 0;
		if (fileName == null && that.fileName != null) {
			ret = 1;
		} else if (fileName != null && that.fileName == null) {
			ret = -1;
		} else if (fileName != null && that.fileName != null) {
			ret = this.fileName.compareTo(that.fileName);
		}
		if (INCLUDE_LOAD_ADDR) {
			if (ret == 0) {
				ret = loadAddr - that.loadAddr;
			}
		}
		return ret;
	}

	@Override
	public String toString() {
		return Block.cleanFilename(fileName) + ":" + Block.toHex4(loadAddr); 
	}

}
