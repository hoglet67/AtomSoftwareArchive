package uk.co.acornatom.menu;

import java.util.Set;
import java.util.TreeSet;
import java.util.function.Function;

public class RomDef implements Comparable<RomDef> {

    private String name;
    private Function<? super AtomTitle, ? extends Boolean> atomFieldGetter;
    private Set<String> commands;

    public RomDef(
            String name,
            Function<? super AtomTitle, ? extends Boolean> atomFieldGetter,
            String[] commands
            ) {
        this.name = name;
        this.atomFieldGetter = atomFieldGetter;
        this.commands = new TreeSet<String>();
        for (String command : commands) {
            this.commands.add(command);
        }
    }

    public String getName() {
        return this.name;
    }

    public Set<String> getCommands() {
        return this.commands;
    }

    @Override
    public String toString() {
        return name;
    }

    public Boolean isNeeded(AtomTitle title) {
        return atomFieldGetter.apply(title);
    }

    public boolean equals(RomDef o) {
        return name.equals(o.getName());
    }

    @Override
    public int compareTo(RomDef o) {
        return name.compareTo(o.getName());
    }


}
