package uk.co.acornatom.afsutils;

import java.io.IOException;

public class AFSException extends IOException {

    private static final long serialVersionUID = 1L;

    public AFSException(String message, int sector) {
        super(message + " at sector " + sector);
    }
}
