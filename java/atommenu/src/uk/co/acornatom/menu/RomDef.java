package uk.co.acornatom.menu;

public class RomDef {

    protected String name;
    protected String[] commands;

    public RomDef(String name, String[] commands) {
        this.name = name;
        this.commands = commands;
    }

    public String getName() {
        return this.name;
    }

    public String[] getCommands() {
        return this.commands;
    }

    @Override
    public String toString() {
        return name;
    }

}
