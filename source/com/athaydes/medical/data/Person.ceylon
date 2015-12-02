import ceylon.time {
    Date
}

shared class Person<out Attribute>(shared FullName fullName, 
    shared Date dob,
    shared {Attribute*} attributes = {})
        given Attribute satisfies Object {}
