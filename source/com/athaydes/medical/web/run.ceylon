import ceylon.time {
    Date,
    date
}

import com.athaydes.medical.data {
    Person,
    FullName,
    Name
}
import com.athaydes.medical.details {
    MedicalAttributes,
    Allergies,
    KnownConditions,
    CurrentMedication
}
import com.athaydes.medical.legal {
    SocialSecurityNumber,
    Nationality,
    LegalAttributes
}
import com.athaydes.medical.measurement {
    Measurements,
    overweight
}
import com.athaydes.medical.render {
    render,
    row,
    header
}



"Run the module `com.athaydes.medical.web`."
shared void run() {
    value name = Name.createName;
    alias Overweight => Boolean;

    value headerNames = ["Full name", "Date of birth", "SSN",
                         "Overweight", "Allergies", "Current Medication"];


    alias RenderableRow => [FullName, Date, SocialSecurityNumber?, 
                            Overweight?, Allergies?, CurrentMedication?];

    RenderableRow personRow(Person<Anything> person) {
        value legalAttributes = person.attributes.narrow<LegalAttributes>();
        value medicalAttributes = person.attributes.narrow<MedicalAttributes>();
        value measurementAttributes = person.attributes.narrow<Measurements>();
        
        SocialSecurityNumber? ssn = legalAttributes.first?.first else null;
        Measurements? measurements = measurementAttributes.first;
        value personOverweight = if (exists measurements)
                                then overweight(*measurements.properties)
                                else null;
        
        [Allergies?, CurrentMedication?] medicalColumns;
        if (exists attributes = medicalAttributes.first) {
            medicalColumns = [attributes[0], attributes[2]];
        } else {
            medicalColumns = [null, null];
        }
        
        return [person.fullName, person.dob, ssn, personOverweight, *medicalColumns];
    }
    
    String renderedName(FullName fullName)
        => "``fullName.lastName``\
            ``if (exists fn = fullName.firstName)
                then (", " + fn.string)
                else ""``";
    
    String renderedDate(Date date)
        => date.string;
    
    String renderedSSN(SocialSecurityNumber? ssn)
        => ssn?.string else "UNKNOWN";
    
    String renderedAllergies(Allergies? allergies)
        => if (exists a = allergies) then
                (if (a.substances.empty) then "None"
                 else a.substances.string)
           else "UNKNOWN";
    
    String renderedMedication(CurrentMedication? medication)
        => if (exists m = medication) then
                (if (m.medication.empty) then "None"
                 else m.medication.string)
           else "UNKNOWN";
    
    String renderedOverweight(Boolean? overweight)
        => if (exists o = overweight) then
                (if (o) then "True"
                 else "False")
           else "UNKNOWN";
    
    void renderPeople({Person<Anything>*} people) {
        value data = people.map(personRow)
                .map((pr) => [renderedName(pr[0]), renderedDate(pr[1]),
                              renderedSSN(pr[2]), renderedOverweight(pr[3]),
                              renderedAllergies(pr[4]),
                              renderedMedication(pr[5])])
                .map(row);
    
        if (exists firstRow = data.first) {
            // idiom to turn a {A*} into a {A+}
            value nonEmptyData = { firstRow }.chain(data.rest);
            render(process.write, header(headerNames), nonEmptyData);
        } else {
            print("No people were found");
        }
    }
    
    value person1 = Person {
        fullName = FullName(name("Smith"));
        dob = date(1984, 12, 21);
        attributes = [
            [SocialSecurityNumber("555-555-xxx"), Nationality("New Zealand")],
            [Allergies {"peanuts"}, KnownConditions {}, CurrentMedication {}]
        ];
    };
    
    value person2 = Person {
        fullName = FullName {
            firstName = name("Michael");
            lastName = name("Jordan");
        };
        dob = date(1963, 2, 17);
        attributes = [
            [SocialSecurityNumber("555-555-yyy"), Nationality("USA")],
            [Allergies {}, KnownConditions {}, CurrentMedication {"Naproxen"}],
            Measurements { weight = 98; height = 1.98; }
        ];
    };

    renderPeople { person1, person2 };
}
