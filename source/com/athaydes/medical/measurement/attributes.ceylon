shared alias Kilogram => Integer;
shared alias Meter => Float;

shared class Measurements(
    shared Kilogram weight,
    shared Meter height) {

    shared [Kilogram, Meter] properties = [weight, height];

}
