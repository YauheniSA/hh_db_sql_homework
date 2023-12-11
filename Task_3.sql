-- Вариант 1 с функцией мне кажется более аккуратным)
CREATE OR REPLACE FUNCTION get_net_salary(compensation INTEGER, gross BOOLEAN)
    RETURNS FLOAT
    LANGUAGE plpgsql
    AS
    $$
    BEGIN
        IF gross IS TRUE
            THEN RETURN compensation * 0.87;
        END IF;
        RETURN compensation;
    END;
    $$;


SELECT e.area_id AS area_id,
       round(AVG(get_net_salary(v.compensation_from, v.compensation_gross))) AS avg_compensation_from,
       round(AVG(get_net_salary(v.compensation_to, v.compensation_gross))) AS avg_compensation_to,
       round(AVG(get_net_salary((v.compensation_from + v.compensation_to) / 2, v.compensation_gross)))
           AS avg_compensation
FROM employer e
         JOIN vacancy v ON e.employer_id = v.employer_id
GROUP BY area_id
ORDER BY area_id;


-- Вариант 2 без функции кажется мне громоздким из-за кучи повторяющегося кода
SELECT e.area_id AS area_id,
       round(AVG(
           CASE
               WHEN v.compensation_gross IS TRUE
                   THEN v.compensation_from * 0.87
               ELSE v.compensation_from
               END)
           )
           AS avg_compensation_from,

       round(
           AVG(
           CASE
               WHEN v.compensation_gross IS TRUE
                   THEN v.compensation_to * 0.87
               ELSE v.compensation_to
               END)
           )
           AS avg_compensation_to,
       round(AVG(
           CASE
               WHEN v.compensation_gross IS TRUE
                   THEN (v.compensation_to + v.compensation_from) / 2 * 0.87
               ELSE (v.compensation_to + v.compensation_from) / 2
               END)
           )
           AS avg_compensation
FROM employer e
         JOIN vacancy v ON e.employer_id = v.employer_id
GROUP BY area_id
ORDER BY area_id;