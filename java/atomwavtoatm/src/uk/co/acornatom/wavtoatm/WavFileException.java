package uk.co.acornatom.wavtoatm;

import java.io.IOException;

public class WavFileException extends IOException
{
    private static final long serialVersionUID = 1L;

    public WavFileException()
    {
        super();
    }

    public WavFileException(String message)
    {
        super(message);
    }

    public WavFileException(String message, Throwable cause)
    {
        super(message, cause);
    }

    public WavFileException(Throwable cause)
    {
        super(cause);
    }
}
