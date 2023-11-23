CREATE TABLE Fact (
    fact_id SERIAL PRIMARY KEY,
    date TIMESTAMP,
    phone_num INTEGER,
    participant_id_nk VARCHAR,
    operator_id INTEGER,
    age_id INTEGER,
    gender_id INTEGER,
    spending_id INTEGER,
    location_id INTEGER,
    experience_id INTEGER,
    participant_id INTEGER,
    occupation_id INTEGER,
    education_level_id INTEGER,
    has_kids_under_14_id INTEGER,
    family_financial_state_id INTEGER,
	question_id INTEGER,
    date_id INTEGER,
    avg_monthly_spending INTEGER,
    is_the_payer VARCHAR,
    score INTEGER,
    weight NUMERIC
);

