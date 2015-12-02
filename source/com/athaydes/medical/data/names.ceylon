shared class Name {
    shared actual String string;
    
    throws(`class Exception`, "if the given string is not between 1 and 256 characters long")
    shared new createName(String string) {
        if (1 <= string.size <= 256) {
            this.string = string;
        } else {
            throw Exception("Name must be between 1 and 256 characters long");
        }
    }
}

shared class FullName(shared Name lastName,
    shared Name? firstName = null, 
    shared {Name*} otherNames = {}) {}
