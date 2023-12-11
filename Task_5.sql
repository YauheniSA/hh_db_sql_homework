WITH responses_count AS (
    SELECT v.vacancy_id,
           v.title,
           COUNT(*) AS count_responses
    FROM response r
             JOIN vacancy v ON r.vacancy_id = v.vacancy_id
    WHERE (r.created_at BETWEEN v.created_at AND (v.created_at + INTERVAL '7 days'))
    GROUP BY v.title, v.vacancy_id)
SELECT r.vacancy_id, r.title
FROM responses_count r
WHERE r.count_responses > 5;
