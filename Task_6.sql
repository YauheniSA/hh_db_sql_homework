-- создаем индексы для полей created_at  таблицах resume и vacancy, поскольку в нашем конкретном случае мы будем
-- выполнять по ним фильтрацию в тасках 4 и 5
CREATE INDEX created_at_index ON vacancy (created_at);
CREATE INDEX created_at_index ON resume (created_at);

-- то же самое но сразу для двух полей compensation по ним фильтрация в таске 3
CREATE INDEX compensation_index ON vacancy (compensation_from, compensation_to);

-- и еще для полей vacancy_id и title таблицы vacancy по ним фильтрация в таске 5
CREATE INDEX vacancy_index ON vacancy (vacancy_id, title);
