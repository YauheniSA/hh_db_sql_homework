INSERT INTO area (area_id, area_name)
VALUES (1, 'Москва'),
       (2, 'Минск'),
       (3, 'Новосибирск'),
       (4, 'Сочи');


INSERT INTO employment_type (employment_type_id, employment_type_name)
VALUES (1, 'Полная занятость'),
       (2, 'Частичная занятость'),
       (3, 'Стажировка');


INSERT INTO specialization (specialization_id, specialization_name)
VALUES (1, 'Водитель'),
       (2, 'Продавец'),
       (3, 'Разработчик'),
       (4, 'Повар'),
       (5, 'Управляющий');


INSERT INTO employer (employer_id, employer_name, area_id, description, created_at)
VALUES (1, 'hh.ru', 1, 'head_hunter', TIMESTAMP '2002-01-01 20:00:00'),
       (2, 'mail', 2, 'mail', TIMESTAMP '2015-01-01 20:00:00'),
       (3, 'rambler', 3, 'rambler', TIMESTAMP '2008-01-01 20:00:00'),
       (4, 'vk', 1, 'vk', TIMESTAMP '205-01-01 20:00:00'),
       (5, 'yandex', 1, 'yandex', TIMESTAMP '2000-01-01 20:00:00');


WITH test_data (person_id, first_name, second_name, middle_name, email, phone_number, created_at, area_id) AS (
    SELECT generate_series(1, 100000) AS person_id,
           md5(random()::TEXT) AS first_name,
           md5(random()::TEXT) AS second_name,
           md5(random()::TEXT) AS midle_name,
           md5(random()::TEXT) AS phone_number,
           md5(random()::TEXT) AS email,
           TIMESTAMP '2022-01-01 20:00:00' + random() * (
                   TIMESTAMP '2023-01-01 20:00:00' - TIMESTAMP '2022-01-01 20:00:00') AS created_at,
           random() * ((SELECT count(*) FROM area) - 1) + 1 AS area_id
)
INSERT INTO person (person_id, first_name, second_name, middle_name, email, phone_number, created_at, area_id)
SELECT person_id, first_name, second_name, middle_name, email, phone_number, created_at, area_id
FROM test_data;


WITH test_data (
                vacancy_id, employer_id, specialization_id, created_at, title, compensation_from, experience_from,
                employment_type
    ) AS (
    SELECT generate_series(1, 10000) AS vacancy_id,
           random() * ((SELECT count(*) AS count FROM employer) - 1) + 1 AS employer_id,
           random() * ((SELECT count(*) AS count FROM specialization) - 1) + 1 AS specialization_id,
           TIMESTAMP '2022-01-01 20:00:00' + random() * (
                   TIMESTAMP '2023-01-01 20:00:00' - TIMESTAMP '2022-01-01 20:00:00') AS created_at,
           md5(random()::TEXT) AS position_name,
           round((random() * 100000)::INTEGER, -3) AS compensation_from,
           round((random() * 10)::INTEGER, 0) AS experience_from,
           random() * ((SELECT count(*) FROM employment_type) - 1) + 1 AS employment_type
)
INSERT INTO vacancy (
    vacancy_id, employer_id, specialization_id, created_at, title, compensation_from,
    compensation_to, experience_from, experience_to, employment_type
)
SELECT vacancy_id, employer_id, specialization_id, created_at, title, compensation_from, compensation_from + 55555,
       experience_from, experience_from + 5, employment_type
FROM test_data;

WITH test_data (resume_id, person_id, specialization_id, gender, birth_date, created_at, citizenship, education) AS (
    SELECT generate_series(1, 100000) AS resume_id,
           random() * ((SELECT count(*) AS count FROM person) - 1) + 1 AS person_id,
           random() * ((SELECT count(*) AS count FROM specialization) - 1) + 1 AS specialization_id,
           md5(random()::TEXT) AS gender,
           TIMESTAMP '1900-01-01 20:00:00' + random() * (
                   TIMESTAMP '2023-01-01 20:00:00' - TIMESTAMP '1900-01-01 20:00:00') AS birth_date,
           TIMESTAMP '2022-01-01 20:00:00' + random() * (
                   TIMESTAMP '2023-01-01 20:00:00' - TIMESTAMP '2022-01-01 20:00:00') AS created_at,
           md5(random()::TEXT) AS citizenship,
           md5(random()::TEXT) AS education
)
INSERT INTO resume (resume_id, person_id, specialization_id, gender, birth_date, created_at, citizenship, education)
SELECT resume_id, person_id, specialization_id, gender, birth_date, created_at, citizenship, education
FROM test_data;


WITH test_data (response_id, vacancy_id, resume_id, created_at) AS (
    SELECT generate_series(1, 10000) AS response_id,
           random() * ((SELECT count(*) AS count FROM vacancy) - 1) + 1 AS vacancy_id,
           random() * ((SELECT count(*) AS count FROM resume) - 1) + 1 AS resume_id,
           TIMESTAMP '2022-01-01 20:00:00' + random() * (
                   TIMESTAMP '2023-01-01 20:00:00' - TIMESTAMP '2022-01-01 20:00:00') AS created_at
)
INSERT INTO response (response_id, vacancy_id, resume_id, created_at)
SELECT response_id, vacancy_id, resume_id, created_at
FROM test_data;
