WITH vacancy_counter AS (
    SELECT EXTRACT(MONTH FROM v.created_at) as month,
           COUNT(*) AS count_vacancies
    FROM vacancy v
    GROUP BY month
    ORDER BY count_vacancies DESC
    LIMIT 1
),
     resume_counter AS (
         SELECT EXTRACT(MONTH FROM r.created_at) as month,
                COUNT(*) AS count_resume
         FROM resume r
         GROUP BY month
         ORDER BY  count_resume DESC
         LIMIT 1
     )
SELECT v.month AS  max_vacncy_created_month, r.month AS max_resume_created_month
FROM vacancy_counter v, resume_counter r;
