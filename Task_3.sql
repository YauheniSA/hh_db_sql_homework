SELECT e.area_id AS area_id,
       round(AVG(v.compensation_from)) AS avg_compensation_from,
       round(AVG(v.compensation_to)) AS avg_compensation_to,
       round(AVG(v.compensation_from + v.compensation_to)) AS avg_compensation
FROM employer e
         JOIN vacancy v ON e.employer_id = v.employer_id
GROUP BY area_id
ORDER BY area_id;
