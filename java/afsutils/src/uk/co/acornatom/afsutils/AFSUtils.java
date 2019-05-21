package uk.co.acornatom.afsutils;

import java.io.File;
import java.io.IOException;

public class AFSUtils {

    public static final void main(String[] args) {
        try {
            AFSVolume afs = new AFSVolume(new File(args[0]), "rw");
            afs.parseDiskInfoBlock();
            afs.readFreeSpaceMap();
            afs.parseRootDirectory();
            System.out.println("AFS: first free sector = " + afs.allocateSector());

            afs.addZip(new File(args[1]));

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
