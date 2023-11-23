CREATE TABLE {table_name} (
    question_id SERIAL PRIMARY KEY,
    long_name_rus VARCHAR,
    short_name_eng VARCHAR,
    is_nps VARCHAR,
	is_filter_of VARCHAR,
	UNIQUE(short_name_eng)
);