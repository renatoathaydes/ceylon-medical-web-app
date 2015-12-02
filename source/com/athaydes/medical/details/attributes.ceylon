shared class Allergies(shared {String*} substances) {
    string = substances.string;
}
shared class KnownConditions(shared {String*} conditions) {
    string = conditions.string;
}
shared class CurrentMedication(shared {String*} medication) {
    string = medication.string;
}

shared alias MedicalAttributes => [Allergies, KnownConditions, CurrentMedication];
