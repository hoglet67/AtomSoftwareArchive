package uk.co.acornatom.menu;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;

public class GenerateSplashFiles extends GenerateBase {

    private static final String SPASH_TEMPLATE = "splash" + File.separator + "newsplash.bmp";

    /* 6847 Font taken from Atomulator */

    private enum Font {
        SOFTVDU, MC6847, MC6847T1
    };

    private static final Font font = Font.MC6847T1;

    int fontdata6847t1[] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x08,
            0x08, 0x08, 0x08, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x14, 0x14, 0x3E, 0x14, 0x3E, 0x14, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x1E, 0x20, 0x1C, 0x02, 0x3C,
            0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x32, 0x32, 0x04, 0x08, 0x10, 0x26, 0x26, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x28,
            0x28, 0x10, 0x2A, 0x24, 0x1A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x0C, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x04, 0x08, 0x10, 0x10, 0x10, 0x08, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x08, 0x04, 0x04, 0x04, 0x08,
            0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x2A, 0x1C, 0x2A, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08,
            0x08, 0x3E, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x0C, 0x04, 0x08, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0C,
            0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x02, 0x04, 0x08, 0x10, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x22,
            0x26, 0x2A, 0x32, 0x22, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x18, 0x08, 0x08, 0x08, 0x08, 0x1C, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x1C, 0x22, 0x02, 0x1C, 0x20, 0x20, 0x3E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x22, 0x02, 0x0C, 0x02, 0x22,
            0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x0C, 0x14, 0x3E, 0x04, 0x04, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0x20,
            0x3C, 0x02, 0x02, 0x22, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x20, 0x20, 0x3C, 0x22, 0x22, 0x1C, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x3E, 0x02, 0x04, 0x08, 0x10, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x22, 0x22, 0x1C, 0x22, 0x22,
            0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x22, 0x22, 0x1E, 0x02, 0x02, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0C,
            0x0C, 0x00, 0x0C, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x0C, 0x00, 0x0C, 0x0C, 0x04, 0x08, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x04, 0x08, 0x10, 0x20, 0x10, 0x08, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0x00, 0x3E, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x10, 0x08, 0x04, 0x08, 0x10, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x24,
            0x04, 0x08, 0x08, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x22, 0x2E, 0x2A, 0x2E, 0x20, 0x1C, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x08, 0x14, 0x22, 0x22, 0x3E, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x12, 0x12, 0x1C, 0x12, 0x12,
            0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x22, 0x20, 0x20, 0x20, 0x22, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x12,
            0x12, 0x12, 0x12, 0x12, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0x20, 0x20, 0x38, 0x20, 0x20, 0x3E, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x3E, 0x20, 0x20, 0x3C, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1E, 0x20, 0x20, 0x26, 0x22, 0x22,
            0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x3E, 0x22, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x08,
            0x08, 0x08, 0x08, 0x08, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x02, 0x02, 0x02, 0x22, 0x22, 0x1C, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x22, 0x24, 0x28, 0x30, 0x28, 0x24, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
            0x3E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x36, 0x2A, 0x2A, 0x22, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x32,
            0x2A, 0x26, 0x22, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x22, 0x22, 0x22, 0x22, 0x22, 0x1C, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x3C, 0x22, 0x22, 0x3C, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x22, 0x22, 0x22, 0x2A, 0x24,
            0x1A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x22, 0x22, 0x3C, 0x28, 0x24, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x22,
            0x10, 0x08, 0x04, 0x22, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x22, 0x14, 0x14,
            0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x2A, 0x2A, 0x36, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22,
            0x14, 0x08, 0x14, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x14, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x3E, 0x02, 0x04, 0x08, 0x10, 0x20, 0x3E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x10, 0x10, 0x10, 0x10, 0x10,
            0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x20, 0x10, 0x08, 0x04, 0x02, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x04,
            0x04, 0x04, 0x04, 0x04, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x14, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x08, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x02, 0x3E, 0x22, 0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x20,
            0x3C, 0x22, 0x22, 0x22, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x20, 0x20, 0x20, 0x1C, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x02, 0x02, 0x0E, 0x12, 0x12, 0x12, 0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x22, 0x3E, 0x20,
            0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x20, 0x20, 0x3C, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x1E, 0x22, 0x22, 0x22, 0x1E, 0x02, 0x1C, 0x00, 0x00, 0x00, 0x20, 0x20, 0x3C, 0x22, 0x22, 0x22, 0x22, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x08, 0x00, 0x18, 0x08, 0x08, 0x08, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x04, 0x04, 0x04,
            0x04, 0x14, 0x08, 0x00, 0x00, 0x00, 0x20, 0x20, 0x24, 0x28, 0x30, 0x28, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x08,
            0x08, 0x08, 0x08, 0x08, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x34, 0x2A, 0x2A, 0x2A, 0x2A, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x3C, 0x22, 0x22, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x22, 0x22, 0x22,
            0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x22, 0x22, 0x22, 0x3C, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x1C, 0x22, 0x22, 0x22, 0x1E, 0x02, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2C, 0x32, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x1C, 0x20, 0x1C, 0x02, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x38, 0x10, 0x10, 0x14,
            0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x22, 0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x22, 0x22, 0x14, 0x14, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2A, 0x2A, 0x2A, 0x2A, 0x14, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x22, 0x14, 0x08, 0x14, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x22,
            0x1E, 0x02, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0x04, 0x08, 0x10, 0x3E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x08,
            0x08, 0x10, 0x08, 0x08, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x10, 0x08, 0x08, 0x04, 0x08, 0x08, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, 0x14, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0x3E, 0x3E, 0x3E, 0x3E, 0x3E, 0x3E, 0x00, 0x00, };

    int fontdata6847[] = { 0x00, 0x00, 0x00, 0x1c, 0x22, 0x02, 0x1a, 0x2a, 0x2a, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x14,
            0x22, 0x22, 0x3e, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3c, 0x12, 0x12, 0x1c, 0x12, 0x12, 0x3c, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x1c, 0x22, 0x20, 0x20, 0x20, 0x22, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3c, 0x12, 0x12, 0x12, 0x12, 0x12,
            0x3c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x20, 0x20, 0x3c, 0x20, 0x20, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x20,
            0x20, 0x3c, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1e, 0x20, 0x20, 0x26, 0x22, 0x22, 0x1e, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x22, 0x22, 0x22, 0x3e, 0x22, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x08, 0x08, 0x08, 0x08, 0x08,
            0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x02, 0x02, 0x02, 0x22, 0x22, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x24,
            0x28, 0x30, 0x28, 0x24, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x3e, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x22, 0x36, 0x2a, 0x2a, 0x22, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x32, 0x2a, 0x26, 0x22, 0x22,
            0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x22, 0x22, 0x22, 0x22, 0x22, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3c, 0x22,
            0x22, 0x3c, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x22, 0x22, 0x2a, 0x24, 0x1a, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x3c, 0x22, 0x22, 0x3c, 0x28, 0x24, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x10, 0x08, 0x04, 0x22,
            0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22,
            0x22, 0x22, 0x22, 0x22, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x14, 0x14, 0x08, 0x08, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x22, 0x22, 0x22, 0x2a, 0x2a, 0x36, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x14, 0x08, 0x14, 0x22,
            0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x14, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x02,
            0x04, 0x08, 0x10, 0x20, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x38, 0x20, 0x20, 0x20, 0x20, 0x20, 0x38, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x20, 0x20, 0x10, 0x08, 0x04, 0x02, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0e, 0x02, 0x02, 0x02, 0x02, 0x02,
            0x0e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x1c, 0x2a, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08,
            0x10, 0x3e, 0x10, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x08, 0x08, 0x08, 0x08, 0x08, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x14, 0x14, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x14, 0x36, 0x00, 0x36, 0x14, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x1e,
            0x20, 0x1c, 0x02, 0x3c, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x32, 0x32, 0x04, 0x08, 0x10, 0x26, 0x26, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x10, 0x28, 0x28, 0x10, 0x2a, 0x24, 0x1a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x18, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x10, 0x20, 0x20, 0x20, 0x10, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x04,
            0x02, 0x02, 0x02, 0x04, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x1c, 0x3e, 0x1c, 0x08, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x08, 0x08, 0x3e, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x30, 0x10,
            0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x30, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x02, 0x04, 0x08, 0x10, 0x20, 0x20, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x18, 0x24, 0x24, 0x24, 0x24, 0x24, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x18, 0x08, 0x08, 0x08, 0x08,
            0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x02, 0x1c, 0x20, 0x20, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22,
            0x02, 0x0c, 0x02, 0x22, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x0c, 0x14, 0x3e, 0x04, 0x04, 0x04, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x3e, 0x20, 0x3c, 0x02, 0x02, 0x22, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x20, 0x20, 0x3c, 0x22, 0x22,
            0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x02, 0x04, 0x08, 0x10, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22,
            0x22, 0x1c, 0x22, 0x22, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x22, 0x1e, 0x02, 0x02, 0x1c, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x18, 0x18, 0x00, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x00, 0x18, 0x18, 0x08,
            0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x08, 0x10, 0x20, 0x10, 0x08, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x3e, 0x00, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x08, 0x04, 0x02, 0x04, 0x08, 0x10, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x18, 0x24, 0x04, 0x08, 0x08, 0x00, 0x08, 0x00, 0x00 };

    int fontdataSoftVdu[] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x1a, 0x24, 0x24, 0x1a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x12, 0x12,
            0x1c, 0x12, 0x12, 0x1c, 0x20, 0x00, 0x00, 0x00, 0x00, 0x32, 0x0c, 0x08, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x1c, 0x20, 0x20, 0x20, 0x18, 0x24, 0x24, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x10, 0x1c, 0x10, 0x0c,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x22, 0x3e, 0x22, 0x22, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x10, 0x10, 0x14, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x10, 0x08, 0x14, 0x22, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x12, 0x12, 0x12, 0x1c, 0x10, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x32, 0x12, 0x14, 0x18,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1e, 0x34, 0x14, 0x14, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x10, 0x08,
            0x0c, 0x08, 0x10, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x08, 0x1c, 0x2a, 0x2a, 0x1c, 0x08, 0x08, 0x00, 0x00, 0x00,
            0x00, 0x08, 0x08, 0x2a, 0x2a, 0x1c, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x22, 0x2a, 0x14,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x22, 0x14, 0x14, 0x36, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x0c, 0x12, 0x12, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x0c, 0x04, 0x0e, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x12, 0x04, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1e, 0x04, 0x12,
            0x0c, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x12, 0x12, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x12, 0x04,
            0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x1c, 0x08, 0x00, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x08, 0x00, 0x3e, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x2a, 0x04, 0x10, 0x2a, 0x04, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x0e, 0x08, 0x08, 0x08, 0x28, 0x18, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x0a, 0x08,
            0x08, 0x08, 0x08, 0x28, 0x10, 0x00, 0x00, 0x00, 0x00, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x08, 0x10, 0x3e, 0x10, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x04, 0x3e, 0x04, 0x08, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x1c, 0x2a, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x08,
            0x2a, 0x1c, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x14, 0x14, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x14, 0x3e, 0x14, 0x3e, 0x14, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x1e, 0x28,
            0x1c, 0x0a, 0x3c, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x32, 0x04, 0x08, 0x10, 0x26, 0x06, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x08, 0x14, 0x14, 0x18, 0x2a, 0x24, 0x1a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x08, 0x10, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x08, 0x10, 0x10, 0x10, 0x08, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x08, 0x04,
            0x04, 0x04, 0x08, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x2a, 0x1c, 0x2a, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x08, 0x08, 0x3e, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x08,
            0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x04, 0x08, 0x10, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x1c, 0x22, 0x26, 0x2a, 0x32, 0x22, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x18, 0x08, 0x08, 0x08, 0x08, 0x1c,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x02, 0x04, 0x08, 0x10, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x04, 0x08,
            0x04, 0x02, 0x22, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x0c, 0x14, 0x24, 0x3e, 0x04, 0x04, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x3e, 0x20, 0x3c, 0x02, 0x02, 0x22, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x10, 0x20, 0x3c, 0x22, 0x22, 0x1c,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x02, 0x04, 0x08, 0x10, 0x10, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x22,
            0x1c, 0x22, 0x22, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x22, 0x1e, 0x02, 0x04, 0x18, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x08, 0x08, 0x00, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x08, 0x00, 0x08, 0x08,
            0x10, 0x00, 0x00, 0x00, 0x00, 0x04, 0x08, 0x10, 0x20, 0x10, 0x08, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e,
            0x00, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x08, 0x04, 0x02, 0x04, 0x08, 0x10, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x1c, 0x22, 0x04, 0x08, 0x08, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x2e, 0x2a, 0x2e, 0x20, 0x1c,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x22, 0x3e, 0x22, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3c, 0x22, 0x22,
            0x3c, 0x22, 0x22, 0x3c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x20, 0x20, 0x20, 0x22, 0x1c, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x38, 0x24, 0x22, 0x22, 0x22, 0x24, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x20, 0x20, 0x3c, 0x20, 0x20, 0x3e,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x20, 0x20, 0x3c, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1e, 0x20, 0x20,
            0x26, 0x22, 0x22, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x3e, 0x22, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x1c, 0x08, 0x08, 0x08, 0x08, 0x08, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1e, 0x04, 0x04, 0x04, 0x04, 0x24, 0x18,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x24, 0x28, 0x30, 0x28, 0x24, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x20, 0x20,
            0x20, 0x20, 0x20, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x36, 0x2a, 0x2a, 0x22, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x22, 0x22, 0x32, 0x2a, 0x26, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x22, 0x22, 0x22, 0x22, 0x1c,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x3c, 0x22, 0x22, 0x3c, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x22, 0x22,
            0x22, 0x2a, 0x24, 0x1a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3c, 0x22, 0x22, 0x3c, 0x28, 0x24, 0x22, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x1e, 0x20, 0x20, 0x1c, 0x02, 0x02, 0x3c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22,
            0x22, 0x22, 0x14, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x2a, 0x2a, 0x2a, 0x14, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x22, 0x22, 0x14, 0x08, 0x14, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x14, 0x08, 0x08, 0x08,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x02, 0x04, 0x08, 0x10, 0x20, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x10, 0x10,
            0x10, 0x10, 0x10, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x10, 0x08, 0x04, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x1c, 0x04, 0x04, 0x04, 0x04, 0x04, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x14, 0x22, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x20, 0x10, 0x08,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x02, 0x1e, 0x22, 0x1e, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x20, 0x20, 0x20, 0x3c, 0x22, 0x22, 0x3c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0e, 0x10, 0x10, 0x10, 0x0e,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x02, 0x02, 0x1e, 0x22, 0x22, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0c,
            0x12, 0x1e, 0x10, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x0a, 0x08, 0x1c, 0x08, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x0c, 0x12, 0x12, 0x0e, 0x02, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x10, 0x10, 0x10, 0x1c, 0x12, 0x12, 0x12,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x18, 0x08, 0x08, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00,
            0x04, 0x04, 0x04, 0x14, 0x08, 0x00, 0x00, 0x00, 0x00, 0x10, 0x10, 0x10, 0x14, 0x18, 0x14, 0x12, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x18, 0x08, 0x08, 0x08, 0x08, 0x08, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x2a, 0x2a, 0x22, 0x22,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x12, 0x12, 0x12, 0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0c,
            0x12, 0x12, 0x12, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x12, 0x12, 0x1c, 0x10, 0x10, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x1c, 0x24, 0x24, 0x1c, 0x04, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x16, 0x18, 0x10, 0x10, 0x10,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x20, 0x1c, 0x02, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x1c,
            0x08, 0x08, 0x08, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x24, 0x24, 0x24, 0x24, 0x1e, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x22, 0x22, 0x22, 0x14, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x2a, 0x2a, 0x14,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x14, 0x08, 0x14, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12,
            0x12, 0x12, 0x0e, 0x02, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x04, 0x08, 0x10, 0x3e, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x06, 0x08, 0x08, 0x30, 0x08, 0x08, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x08, 0x08, 0x00, 0x08, 0x08, 0x08,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x08, 0x08, 0x06, 0x08, 0x08, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10,
            0x2a, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2a, 0x14, 0x2a, 0x14, 0x2a, 0x14, 0x2a, 0x14, 0x00, 0x00 };

    int[][] fonts = new int[][] { fontdataSoftVdu, fontdata6847, fontdata6847t1 };

    private String version;
    private Map<String, Integer> chunks;
    private File menuDir;

    public GenerateSplashFiles(File menuDir, String version, Map<String, Integer> chunks) {
        this.menuDir = menuDir;
        this.version = version;
        this.chunks = chunks;
    }

    private void writeAtomString(byte[] screen, String s, int x, int y,boolean forceUpper) {
        for (int i = 0; i < s.length(); i++) {
            int c = s.charAt(i);
            if (forceUpper) {
                c = Character.toUpperCase(c);
            }
            if ((font == Font.MC6847 && c > 96) || (font == Font.MC6847T1)) {
                c = c - 32;
            }
            if (font == Font.MC6847) {
                c = c & 63;
            } else {
                c = c & 127;
            }
            for (int j = 0; j < 12; j++) {

                int b = fonts[font.ordinal()][c * 12 + j];
                for (int k = 7; k >= 0; k--) {
                    if ((b & (1 << k)) != 0) {
                        int xb = x + 8 * i + (7 - k);
                        int yb = (y + j);
                        int addr = 32 * yb + (xb >> 3);
                        int bit = 1 << (7 - (xb & 7));
                        screen[addr] ^=bit;
                    }
                }
            }
        }
    }
    
    private void drawLine(byte[] screen, int x1, int x2, int y) {
        for (int x = x1; x <= x2; x++) {
            int addr = y * 32 + (x >> 3);
            int bit = 1 << (7 - (x & 7));
            screen[addr] ^= bit;
        }
    }

    public void generateFiles(List<SpreadsheetTitle> items, Target target) throws IOException {

        int linex = 9;

        for (int pass = 1; pass <= 2; pass++) {
            boolean includeAll = (pass == 1);

            // Create an grey image
            byte[] screen = new byte[0x1800];
            fill(screen, 0, 0, 256, 192, 0);

            // Start with the template
            readSplashTemplate(SPASH_TEMPLATE, screen);

            // Overlay the menu items
            int y = 48;
            writeAtomString(screen, "maintained by Hoglet", 46, y, false);
            y += 14;

            drawLine(screen, linex, 255 - linex, y);

            y += 2;

            for (Map.Entry<String, Integer> chunk : chunks.entrySet()) {
                if (!includeAll && chunk.getKey().charAt(0) == 'G') {
                    continue;
                }
                // Re-write the chunk titles
                String title;
                switch (chunk.getKey().charAt(0)) {
                case 'A':
                    title = "Commercial";
                    break;
                case 'B':
                    title = "Modern Creations";
                    break;
                case 'C':
                    title = "Arcade Game Designer";
                    break;
                case 'D':
                    title = "Non Commercial";
                    break;
                case 'E':
                    title = "Books and Magazines";
                    break;
                case 'F':
                    title = "Utility ROMS";
                    break;
                case 'G':
                    title = "All Titles";
                    break;
                default:
                    title = "* Unknown Chapter *";
                    break;
                }
                String count = "" + chunk.getValue();
                while (title.length() < 27 - count.length()) {
                    title += " ";
                }
                title += count;
                // Nasty hack to get proportionally spaced brackets
                writeAtomString(screen, "(", 8, y, false);
                writeAtomString(screen, chunk.getKey(), 14, y, false);
                writeAtomString(screen, ")", 20, y, false);
                writeAtomString(screen, title, 30, y, true);
                if (includeAll) {
                    y += 12;
                } else {
                    y += 14;
                }
            }

            y += 2;

            drawLine(screen, linex, 255 - linex, y);

            // Overlay the status line
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MMM/yyyy");
            String date = sdf.format(new Date());
            String line = "Release " + version;
            while (line.length() < 19) {
                line += " ";
            }
            line += date;
            if (line.length() != 30) {
                throw new RuntimeException("Expected footer to be 30 chars long: >>>" + line + "<<<");
            }
            y = 192 - 18;
            drawLine(screen, linex, 255 - linex, y);

            writeAtomString(screen, line, 8, y, false);

            // Save the file
            String name = "SPLASH" + pass;
            FileOutputStream fosSplash = new FileOutputStream(new File(menuDir, name));
            writeATMFile(fosSplash, name, 0x8000, 0x8000, screen);
            fosSplash.close();

            // Save the file as a PNG
            int s = 3;
            int b = 32;
            BufferedImage save = new BufferedImage(s * (256 + b + b), s * (192 + b + b), BufferedImage.TYPE_INT_ARGB);
            Graphics2D g2 = (Graphics2D) save.createGraphics();
            g2.setColor(Color.GREEN);
            g2.fillRect(0, 0, s * (256 + b + b), s * (192 + b + b));
            g2.setColor(Color.BLACK);
            g2.fillRect(s * b, s * b, s * 256, s * 192);
            g2.setColor(Color.GREEN);
            for (int i = 0; i < screen.length; i++) {
                for (int j = 0; j < 8; j++) {
                    int px = ((i & 31) << 3) + 7 - j;
                    int py = (i >> 5);
                    if (((screen[i] >> j) & 1) > 0) {
                        g2.fillRect(s * (b + px), s * (b + py), s, s);
                    }
                }
            }
            ImageIO.write(save, "PNG", new File("Splash" + pass + ".png"));
        }
    }

    // Colour 0 = black
    // Colour 1 = grey
    // Colour 2 = white
    private void fill(byte[] screen, int xx, int yy, int w, int h, int colour) {
        for (int x = xx; x < xx + w; x++) {
            for (int y = yy; y < yy + h; y++) {
                if ((colour == 0) || ((colour == 1) && ((x & 1) != (y & 1)))) {
                    screen[(x >> 3) + (y << 5)] &= 255 - (1 << (7 - x & 7));
                } else {
                    screen[(x >> 3) + (y << 5)] |= 1 << (7 - x & 7);
                }
            }
        }
    }

    private static void readSplashTemplate(String template, byte[] screen) throws IOException {
        // Load the template
        File file = new File(template);
        if (!file.exists()) {
            throw new RuntimeException(file.getCanonicalPath() + " does not exist");
        }
        BufferedImage image = ImageIO.read(file);
        for (int x = 0; x < 256; x++) {
            for (int y = 0; y < 192; y++) {
                int pixel = image.getRGB(x, y) & 0xffffff;
                if (pixel != 0) {
                    int b = 1 << (7 - (x & 7));
                    screen[(x >> 3) + (y << 5)] |= b;
                }
            }
        }
    }

    public static final void main(String[] args) throws IOException {
        readSplashTemplate("../../menu/" + SPASH_TEMPLATE, new byte[256 * 192]);
    }

}
