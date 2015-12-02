import ceylon.time {
    date
}

shared void run() {
    value name = Name.createName;
    value person4 = Person(FullName(name("Smith")),
        date(1984, 12, 21), [
            "",
            "Some other attributes from other modules"
        ]);

}