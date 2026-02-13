package uk.co.acornatom.menu;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

public class RomScanner {

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


    private RomDef[] roms = new RomDef[] {

        new RomDef(
                   PCHARME,
                   AtomTitle::isPcharme,
                   new String[] {
                       "BEEP",
                       "CASE",
                       "CONT",
                       "COPY",
                       "FUNCTION",
                       "FEND",
                       "INKEY",
                       "INSTR",
                       "KEY",
                       "PAUSE",
                       "POP",
                       "PROC",
                       "PEND",
                       "PROGRAM",
                       "HTAB",
                       "VTAB",
                       "WHILE",
                       "WEND",
                       "XIF",
                       "ELSE",
                       "READ",
                       "DATA",
                       "RESTORE"
                   }),

        new RomDef(
                   GAGS,
                   AtomTitle::isGags,
                   new String[] {
                       "CLS",
                       "ATKEY",
                       "JOYSTK",
                       "INV",
                       "BORDER",
                       "PAINT",
                       "CUBE",
                       "CIRCLE",
                       "PIXEL",
                       "WINDOW",
                       "WOFF",
                       "FILL",
                       "SCROLL",
                       "HLINE",
                       "VLINE",
                       "INK",
                       "PAPER",
                       "MODE",
                       "BLOCK",
                       "SOUND",
                       "PAUSE",
                       "CREATE",
                       "DEF",
                       "BASE",
                       "ASSIGN:",
                       "DEASS:",
                       "KILL",
                       "SET",
                       "UNSET",
                       "IMAGE",
                       "TURN",
                       "CARRY",
                       "SHOVE",
                       "POS",
                       "ATHIT",
                       "INT",
                       "ATTRG"
                   }),

        new RomDef(
                   AXR1,
                   AtomTitle::isAxr1,
                   new String[] {
                       "GRMOD",
                       "GRMO.",
                       "GRM.",
                       "GR.",
                       "TXMOD",
                       "TXMO.",
                       "TXM.",
                       "TX.",
                       "SHAPE",
                       "SHAP.",
                       "SHA.",
                       "SH.",
                       "PLAY",
                       "PLA.",
                       "PL.",
                       "COPY",
                       "KEY",
                       "READ",
                       "DATA",
                       "RESTORE"
                   }),

        new RomDef(
                WEROM,
                AtomTitle::isWerom,
                new String[] {
                       "ABDO",
                       "ABFOR",
                       "ABSUB",
                       "CURSOR",
                       "DATA",
                       "EXIT",
                       "KBD",
                       "KEY",
                       "ONERROR",
                       "READ",
                       "RESTORE"
                   }),

        new RomDef(
                PPTOOLKIT,
                AtomTitle::isPPToolkit,
                new String[] {
                       "BEEP",
                       "CURSOR",
                       "KEY",
                       "INKEY",
                       "STOP",
                       "POP",
                       "XIF",
                       "ELSE",
                       "WHILE",
                       "ENDWHILE",
                       "READ",
                       "DATA",
                       "RESTORE",
                       "ONERROR"
                   }),

        new RomDef(
                   FP,
                   AtomTitle::isFp,
                   new String[] {
                       "%",
                       "COLOUR",
                       "FDIM",
                       "FIF",
                       "FINPUT",
                       "FPRINT",
                       "FPUT",
                       "FUNTIL",
                       "STR"
                   }),


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
                            int start = i;
                            while (i < data.length && data[i] != ((byte) 0x0d)) {
                                i++;
                            }
                            if (i < data.length && line > lastLine) {
                                // Test line for signature statements
                                int end = i;
                                String basic = new String(data, start, end - start);
                                for (String s : basic.split(";")) {
                                    statements.add(s.strip());
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

    public String getFormattedRomList(AtomTitle item) {
        // Update the textual romDependency field
        StringBuffer sb = new StringBuffer();
        boolean first = true;
        for (RomDef rom : roms) {
            if (rom.isNeeded(item)) {
                if (!first) {
                    sb.append(",");
                }
                sb.append(rom.getName());
                item.getCollections().add(rom.getName());
                first = false;
            }
        }
        if (first) {
            sb.append("NONE");
        }
        return sb.toString();
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
            for (String command : commands) {
                if (statement.startsWith(command)) {
                    matched.add(command);
                }
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
    public void scan(AtomTitle item) {
        // Extract all likely Basic Statements from the item (scanning multiple files if needed)
        Set<String> statements = basicStatements(item);

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
                if (bestMatches == null || matches.size() > bestMatches.size()) {
                    bestMatches = matches;
                    bestRom = rom;
                }
            }
            if (bestRom != null) {
                progCommands.removeAll(bestMatches);
                neededMap.put(bestRom, bestMatches);
                System.out.println("INFO: Compatibility: Title " + item + ": uses commands from " + bestRom + ": " + bestMatches);
            } else {
                throw new RuntimeException("No commands matched: " + progCommands);
            }
        }


        // Tag the item with the ROM(s) that could supply those commands
        // Note: lots of false positives due to the same command being in multiple ROMs
        for (RomDef rom : roms) {
            boolean needed = neededMap.containsKey(rom);
            if (Boolean.TRUE.equals(rom.isNeeded(item))) {
                if (!needed) {
                    System.out.println("WARNING: Compatibility: Title " + item + ": probably wrongly marked as " + rom);
                }
            } else if (Boolean.FALSE.equals(rom.isNeeded(item))) {
                if (needed) {
                    System.out.println(
                            "WARNING: Compatibility: Title " + item + ": probably should be marked as " + rom + ": " + neededMap.get(rom));
                }
            } else {
                setNeeded(item, rom, needed);
            }
        }

        item.setRomDependency(getFormattedRomList(item));

    }

}
