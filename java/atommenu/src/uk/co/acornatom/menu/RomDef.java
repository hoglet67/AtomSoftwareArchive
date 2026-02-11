package uk.co.acornatom.menu;

import java.util.function.Function;

public class RomDef {

    protected String name;
    protected Function<? super AtomTitle, ? extends Boolean> atomFieldGetter;
    protected String[] commands;

    public RomDef(
            String name,
            Function<? super AtomTitle, ? extends Boolean> atomFieldGetter,
            String[] commands
            ) {
        this.name = name;
        this.atomFieldGetter = atomFieldGetter;
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

    public Boolean isNeeded(AtomTitle title) {
        return atomFieldGetter.apply(title);
    }

}
