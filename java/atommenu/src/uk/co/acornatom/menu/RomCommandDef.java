package uk.co.acornatom.menu;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class RomCommandDef {

    private List<String> names;

    private void addName(String name) {
        if (RomScanner.basicRomDef == null || !RomScanner.basicRomDef.getCommands().contains(name)) {
            if (name.equals("%")) {
                for (char c = '@'; c <= 'Z'; c++) {
                    names.add("%" + c + '=');
                    names.add("%" + c + c);
                    names.add("%!");
                }
            } else {
                names.add(name);
            }
        } else {
            System.out.println("Skipping " + name + " as it it handled by BASIC");
        }
    }

    public RomCommandDef (String name) {
        names = new ArrayList<String>();
        addName(name);
    }

    public RomCommandDef (String name, int minLength) {
        this(name);
        for (int i = minLength; i < name.length() - 1; i++) {
            addName(name.substring(0, i) + ".");
        }
    }

    public Collection<String> getNames() {
        return names;
    }

}
