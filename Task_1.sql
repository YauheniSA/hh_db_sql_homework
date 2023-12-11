CREATE TABLE area (
                      area_id SERIAL PRIMARY KEY,
                      area_name TEXT NOT NULL
);

CREATE TABLE employment_type (
                                 employment_type_id SERIAL PRIMARY KEY,
                                 employment_type_name TEXT NOT NULL
);

CREATE TABLE specialization (
                                specialization_id SERIAL PRIMARY KEY,
                                specialization_name TEXT NOT NULL
);

CREATE TABLE employer (
                          employer_id SERIAL PRIMARY KEY,
                          employer_name TEXT NOT NULL,
                          area_id INTEGER NOT NULL REFERENCES area (area_id),
                          description TEXT NOT NULL,
                          created_at DATE NOT NULL
);

CREATE TABLE person (
                        person_id SERIAL PRIMARY KEY,
                        first_name TEXT NOT NULL,
                        second_name TEXT NOT NULL,
                        middle_name TEXT,
                        email TEXT NOT NULL,
                        phone_number TEXT,
                        created_at DATE NOT NULL,
                        area_id INTEGER NOT NULL REFERENCES area (area_id)
);


CREATE TABLE vacancy (
                         vacancy_id SERIAL PRIMARY KEY,
                         employer_id INTEGER NOT NULL REFERENCES employer (employer_id),
                         specialization_id INTEGER NOT NULL REFERENCES specialization (specialization_id),
                         created_at DATE NOT NULL,
                         title TEXT NOT NULL,
                         compensation_from INTEGER,
                         compensation_to INTEGER,
                         compensation_gross BOOLEAN,
                         experience_from INTEGER,
                         experience_to INTEGER,
                         employment_type INTEGER NOT NULL REFERENCES  employment_type (employment_type_id)
);


CREATE TABLE resume (
                        resume_id SERIAL PRIMARY KEY,
                        person_id INTEGER NOT NULL REFERENCES person (person_id),
                        specialization_id INTEGER NOT NULL REFERENCES specialization (specialization_id),
                        gender TEXT NOT NULL,
                        birth_date DATE,
                        created_at DATE NOT NULL,
                        citizenship TEXT,
                        education TEXT NOT NULL
);

CREATE TABLE response (
                          response_id SERIAL PRIMARY KEY,
                          vacancy_id INTEGER NOT NULL REFERENCES vacancy (vacancy_id),
                          resume_id INTEGER NOT NULL REFERENCES resume (resume_id),
                          created_at DATE NOT NULL
);
