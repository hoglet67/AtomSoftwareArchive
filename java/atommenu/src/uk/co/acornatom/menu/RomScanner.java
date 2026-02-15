package uk.co.acornatom.menu;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

public class RomScanner {
    private static final String BASIC = "BASIC";
    private static final String FP = "FP";
    private static final String PCHARME = "PCHARME";
    private static final String GAGS = "GAGS";
    private static final String AXR1 = "AXR1";
    private static final String WEROM = "WEROM";
    private static final String PPTOOLKIT = "PPTOOLKIT";

    private File archiveDir;

    public RomScanner(File archiveDir) {
        this.archiveDir = archiveDir;
    }

    public static RomDef basicRomDef =
            new RomDef(
                    BASIC,
                    null,
                    new RomCommandDef[] {
                        new RomCommandDef("CLEAR"),
                        new RomCommandDef("DIM"),
                        new RomCommandDef("DRAW"),
                        new RomCommandDef("DO"),
                        new RomCommandDef("END", 1),
                        new RomCommandDef("FOR", 1),
                        new RomCommandDef("GOSUB", 1),
                        new RomCommandDef("GOTO", 1),
                        new RomCommandDef("IF"),
                        new RomCommandDef("INPUT", 2),
                        new RomCommandDef("LET"),
                        new RomCommandDef("LINK", 2),
                        new RomCommandDef("MOVE"),
                        new RomCommandDef("NEXT", 1),
                        new RomCommandDef("PLOT"),
                        new RomCommandDef("PRINT", 1),
                        new RomCommandDef("PUT"),
                        new RomCommandDef("REM"),
                        new RomCommandDef("SHUT", 3),
                        new RomCommandDef("SPUT", 2),
                        new RomCommandDef("UNTIL", 1),
                        new RomCommandDef("WAIT")
                    });

    public static RomDef fpRomDef=
            new RomDef(
                    FP,
                    AtomTitle::usesFp,
                    new RomCommandDef[] {
                        new RomCommandDef("FDIM"),
                        new RomCommandDef("FIF"),
                        new RomCommandDef("FINPUT", 3),
                        new RomCommandDef("FPRINT", 2),
                        new RomCommandDef("FPUT"),
                        new RomCommandDef("FUNTIL", 2),
                        new RomCommandDef("STR"),
                        new RomCommandDef("COLOUR", 1),
                        new RomCommandDef("%")
                    });

    private RomDef[] roms = new RomDef[] {
        fpRomDef,

        new RomDef(
                   PCHARME,
                   AtomTitle::usesPcharme,
                   new RomCommandDef[] {
                       new RomCommandDef("BEEP", 2),
                       new RomCommandDef("CASE", 2),
                       new RomCommandDef("CONT"),
                       new RomCommandDef("COPY"),
                       new RomCommandDef("DATA"),
                       new RomCommandDef("ELSE"),
                       new RomCommandDef("FEND"),
                       new RomCommandDef("FUNCTION", 4),
                       new RomCommandDef("HTAB", 2),
                       new RomCommandDef("ICOPY", 2),
                       new RomCommandDef("INKEY", 3),
                       new RomCommandDef("KEY", 1),
                       new RomCommandDef("ON ERROR"),
                       new RomCommandDef("ON", 1),
                       new RomCommandDef("PAUSE", 2),
                       new RomCommandDef("PEND"),
                       new RomCommandDef("POP"),
                       new RomCommandDef("PROC"),
                       new RomCommandDef("PROGRAM"),
                       new RomCommandDef("READ"),
                       new RomCommandDef("RESTORE", 3),
                       new RomCommandDef("STOP"),
                       new RomCommandDef("VTAB"),
                       new RomCommandDef("WEND"),
                       new RomCommandDef("WHILE"),
                       new RomCommandDef("XIF"),
                       new RomCommandDef("ZERO", 1),
                   }),

        new RomDef(
                   GAGS,
                   AtomTitle::usesGags,
                   new RomCommandDef[] {
                       new RomCommandDef("CLS", 2),
                       new RomCommandDef("ATKEY", 2),
                       new RomCommandDef("JOYSTK", 2),
                       new RomCommandDef("INV"),
                       new RomCommandDef("BORDER", 2),
                       new RomCommandDef("PAINT", 2),
                       new RomCommandDef("CUBE", 2),
                       new RomCommandDef("CIRCLE", 2),
                       new RomCommandDef("PIXEL", 2),
                       new RomCommandDef("WINDOW", 2),
                       new RomCommandDef("WOFF", 2),
                       new RomCommandDef("FILL", 2),
                       new RomCommandDef("SCROLL", 2),
                       new RomCommandDef("HLINE", 2),
                       new RomCommandDef("VLINE", 2),
                       new RomCommandDef("INK", 3),
                       new RomCommandDef("PAPER", 2),
                       new RomCommandDef("MODE", 2),
                       new RomCommandDef("BLOCK", 2),
                       new RomCommandDef("SOUND", 2),
                       new RomCommandDef("PAUSE", 2),
                       new RomCommandDef("CREATE", 2),
                       new RomCommandDef("DEF", 2),
                       new RomCommandDef("BASE", 2),
                       new RomCommandDef("ASSIGN:", 2),
                       new RomCommandDef("DEASS:", 2),
                       new RomCommandDef("KILL", 2),
                       new RomCommandDef("SET", 2),
                       new RomCommandDef("UNSET", 3),
                       new RomCommandDef("IMAGE", 2),
                       new RomCommandDef("TURN", 2),
                       new RomCommandDef("CARRY", 2),
                       new RomCommandDef("SHOVE", 3),
                       new RomCommandDef("POS", 2),
                       new RomCommandDef("ATHIT", 2),
                       new RomCommandDef("INT", 2),
                       new RomCommandDef("ATTRG", 2)
                   }),

        new RomDef(
                   AXR1,
                   AtomTitle::usesAxr1,
                   new RomCommandDef[] {
                       new RomCommandDef("GRMOD", 2),
                       new RomCommandDef("TXMOD", 2),
                       new RomCommandDef("SHAPE", 2),
                       new RomCommandDef("PLAY", 2),
                       new RomCommandDef("COPY", 2),
                       new RomCommandDef("KEY", 1),
                       new RomCommandDef("ON ERR", 2),
                       new RomCommandDef("READ", 2),
                       new RomCommandDef("DATA", 2),
                       new RomCommandDef("RESTORE", 3)
                   }),

        new RomDef(
                   WEROM,
        		   AtomTitle::usesWerom,
        		   new RomCommandDef[] {
        		       new RomCommandDef("ABDO", 3),
        		       new RomCommandDef("ABFOR", 1),
        		       new RomCommandDef("ABSUB", 3),
        		       new RomCommandDef("CURSOR", 2),
        		       new RomCommandDef("DATA", 2),
        		       new RomCommandDef("EXIT", 2),
        		       new RomCommandDef("KBD", 2),
        		       new RomCommandDef("KEY", 1),
        		       new RomCommandDef("ONERROR", 1),
        		       new RomCommandDef("READ", 3),
        		       new RomCommandDef("RESTORE", 3)
                   }),

        new RomDef(
        		   PPTOOLKIT,
        		   AtomTitle::usesPPToolkit,
        		   new RomCommandDef[] {
        		       new RomCommandDef("BEEP", 2),
        		       new RomCommandDef("CURSOR", 2),
        		       new RomCommandDef("KEY", 2),
        		       new RomCommandDef("INKEY", 2),
        		       new RomCommandDef("STOP", 2),
        		       new RomCommandDef("POP", 2),
        		       new RomCommandDef("XIF", 2),
        		       new RomCommandDef("ELSE", 2),
        		       new RomCommandDef("WHILE", 2),
        		       new RomCommandDef("ENDWHILE", 2),
        		       new RomCommandDef("READ", 2),
        		       new RomCommandDef("DATA", 2),
        		       new RomCommandDef("RESTORE", 2),
        		       new RomCommandDef("ONERROR", 2)
                   })

    };

    private Set<String> basicStatements(AtomTitle item) {
        Set<String> statements = new TreeSet<String>();
        for (String filename : item.getFilenames()) {
            File file = new File(new File(archiveDir, item.getDir()), filename);
            try {
                ATMFile atm = new ATMFile(file);
                if (atm.isAtm()) {
                    byte[] data = atm.getData();
                    // Determine the first page boundary
                    int offset = atm.getLoadAddr() & 0xff;
                    if (offset > 0) {
                        offset = 0x100 - offset;
                    }
                    // Scan for basic
                    int i = offset;
                    int lastLine = -1;
                    while (i < data.length - 4) {
                        // Test for a valid start of line
                        if (data[i] == ((byte) 0x0D) && data[i + 1] >= 0) {
                            int line = ((data[i + 1] & 0xff) << 8) + (data[i + 2] & 0xff);
                            i += 3; // Skip <CR> <Line Number>
                            if ((data[i] >= ((byte) 'a')) && (data[i] <= ((byte) 'z'))) {
                                i++; // Skip label
                            }
                            // Search for the end of the line
                            int lineStart = i;
                            while (i < data.length && data[i] != ((byte) 0x0d)) {
                                i++;
                            }
                            if (i < data.length && line > lastLine) {
                                // Test line for signature statements
                                String basic = new String(data, lineStart, i - lineStart);
                                // Split the line a semicolon characters, except within quoted strings
                                int start = 0;
                                boolean inQuotedString = false;
                                for (int j = 0; j < basic.length(); j++) {
                                    if (basic.charAt(j) == '"') {
                                        inQuotedString = !inQuotedString;
                                    } else if (basic.charAt(j) == ';') {
                                        if (!inQuotedString) {
                                            statements.add(basic.substring(start, j).strip());
                                            start = j + 1;
                                        }
                                    }
                                }
                                if (start < basic.length()) {
                                    statements.add(basic.substring(start).strip());
                                }
                                lastLine = line;
                            } else {
                                // Skip to next page
                                i = ((i + 0x100) & 0xff00) + offset;
                                lastLine = -1;
                            }
                        } else {
                            i += 0x100; // Skip to next page
                        }
                    }
                }
            } catch (IOException e) {
                System.out.println("WARNING: Missing file: " + file);
            }
        }
        return statements;
    }

    private void setFinalROMMetadata(AtomTitle item) {
        // Update the textual romDependency field
        StringBuffer sb = new StringBuffer();
        boolean first = true;
        for (RomDef rom : roms) {
            if (rom.isNeeded(item)) {
                if (!first) {
                    sb.append(",");
                }
                sb.append(rom.getName());
                item.getCollections().add("R:" + rom.getName());
                first = false;
            }
        }
        if (first) {
            sb.append("NONE");
        }
        item.setRomDependency(sb.toString());
    }

    private Set<String> allCommands() {
        Set<String> all = new TreeSet<String>();
        for (RomDef rom : roms) {
            for (String command : rom.getCommands()) {
                all.add(command);
            }
        }
        return all;
    }

    private Set<String> matchCommands(Set<String> statements, Set<String> commands) {
        Set<String> matched = new TreeSet<String>();
        for (String statement : statements) {
            String best = null;
            int bestLen = -1;
            // Look for the length of longest match
            for (String command : commands) {
                if (statement.startsWith(command)) {
                    int len = command.length();
                    if (len  > bestLen) {
                        bestLen = len;
                        best = command;
                    }
                }
            }
            if (best != null) {
                matched.add(best);
            }
        }
        return matched;
    }

    private Set<String> getMatches(Set<String> progCommands, Set<String> romCommands) {
        Set<String> matches = new TreeSet<String>();
        for (String progCommand : progCommands) {
            if (romCommands.contains(progCommand)) {
                matches.add(progCommand);
            }
        }
        return matches;
    }

    public void setNeeded(AtomTitle item, RomDef rom, boolean needed) {
        // TODO: Make this generic
        switch (rom.getName()) {
        case FP:
            item.setFp(needed);
            break;
        case PCHARME:
            item.setPcharme(needed);
            break;
        case GAGS:
            item.setGags(needed);
            break;
        case AXR1:
            item.setAxr1(needed);
            break;
        case WEROM:
            item.setWerom(needed);
            break;
        case PPTOOLKIT:
            item.setPPToolkit(needed);
            break;
        default:
            throw new RuntimeException("Unknown ROM: " + rom.getName());
        }
    }


    public boolean testForCopyOrBase(String s) {
        String hex = "89ABCDEF";
        if (s.contains("COPY") || s.contains("BASE")) {
            for (char c : hex.toCharArray()) {
                if (s.contains("#9" + c)) {
                    return true;
                }
            }
        }
        return false;

    }
    public void scan(AtomTitle item) {
        // Extract all likely Basic Statements from the item (scanning multiple files if needed)
        Set<String> statements = basicStatements(item);

        // Scan for COPY to #9800 region
        item.setPages98to8F(false);
        for (String statement : statements) {
            if (testForCopyOrBase(statement)) {
                item.setPages98to8F(true);
                System.out.println("INFO: RAM Compatibility: Title: " + item + " uses pages 98-9F: " + statement);
            }
        }

        // Match those statements against known ROM commands
        Set<String> progCommands = matchCommands(statements, allCommands());

        Map<RomDef, Set<String>> neededMap = new TreeMap<RomDef, Set<String>>();
        // Match the program commands to fewest ROMs
        while (!progCommands.isEmpty()) {
            RomDef bestRom = null;
            Set<String> bestMatches = null;
            // Go through ROMs in priority order, lookimg for the ROM that matches the most commands
            for (RomDef rom : roms) {
                Set<String> matches = getMatches(progCommands, rom.getCommands());
                if ((bestMatches == null) ||
                        (matches.size() > bestMatches.size()) ||
                        (matches.size() == bestMatches.size() && Boolean.TRUE.equals(rom.isNeeded(item)))
                        ) {
                    bestMatches = matches;
                    bestRom = rom;
                }
            }
            if (bestRom != null) {
                progCommands.removeAll(bestMatches);
                System.out.println("INFO: ROM Compatibility: Title " + item  + ": uses commands from " + bestRom + ": " + bestMatches);
                neededMap.put(bestRom, bestMatches);
            } else {
                throw new RuntimeException("No commands matched: " + progCommands);
            }
        }

        // Tag the item with the ROM(s) that can best could those commands
        for (RomDef rom : roms) {
            boolean needed = neededMap.containsKey(rom);
            if (Boolean.TRUE.equals(rom.isNeeded(item))) {
                if (!needed) {
                    System.out.println("WARNING: ROM Compatibility: Title " + item + ": probably wrongly marked as " + rom + " = YES");
                }
            } else if (Boolean.FALSE.equals(rom.isNeeded(item))) {
                if (needed) {
                    System.out.println(
                            "WARNING: ROM Compatibility: Title " + item + ": probably wrongly marked as " + rom + " = NO: " + neededMap.get(rom));
                }
            } else {
                if (needed) {
                    System.out.println("WARNING: ROM Compatibility: Title " + item + ": probably should be marked as " + rom + " = YES: " + neededMap.get(rom));
                }
                setNeeded(item, rom, needed);
            }
        }
        setFinalROMMetadata(item);
    }
}
