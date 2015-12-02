shared Float bmi(Kilogram weight, Meter height)
        => weight.float / (height ^ 2.0);

shared Boolean overweight(Kilogram weight, Meter height)
        => bmi(weight, height) > 25.0;
