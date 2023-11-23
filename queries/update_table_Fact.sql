--drop intermediate views, tables
DROP VIEW IF EXISTS staging_fact;
DROP TABLE IF EXISTS temp_staging_fact;

--long format staging table
CREATE VIEW staging_fact
AS
(SELECT date, phone_n, operator, gender, age, age_group, location, location_type, usage_period,
 		is_only_sim, sim2, spendings, spending_range, occupation, education_lvl, has_kids, fin_state,
 		wave, who_pays, weight, N01 AS score, 'N01' AS question FROM {src_table_name})
UNION ALL
(SELECT date, phone_n, operator, gender, age, age_group, location, location_type, usage_period,
 		is_only_sim, sim2, spendings, spending_range, occupation, education_lvl, has_kids, fin_state,
 		wave, who_pays, weight, Q1A AS score, 'Q1A' AS question FROM {src_table_name});

--merge tables with the long format staging table
CREATE TABLE temp_staging_fact (
    id SERIAL PRIMARY KEY,
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


MERGE INTO temp_staging_fact dst

USING (
SELECT sr.*, dop.current_name, dop.dim_oper_sk_pk, dag.id, dg.gender_id, ds.spending_id, dl.location_id,
	         de.experience_id, doc.occupation_id, del.education_lvl_id, dffs.financial_state_id,
	         dku.has_kids_id, dip.is_payer_id, dq.question_id, dd.date_id
FROM staging_fact sr
LEFT JOIN DimOperator dop
ON sr.operator = dop.current_name
LEFT JOIN DimAgeGroup dag
ON sr.age_group = dag.age_group
LEFT JOIN DimGender dg
ON sr.gender = dg.gender
LEFT JOIN DimSpending ds
ON sr.spending_range = ds.spending_range
LEFT JOIN DimLocation dl
ON sr.location = dl.region AND sr.location_type = dl.location_type
LEFT JOIN DimExperience de
ON sr.usage_period = de.usage_time_range
LEFT JOIN DimOccupation doc
ON sr.occupation = doc.participant_occupation
LEFT JOIN DimEducationLevel del
ON sr.education_lvl = del.education_level
LEFT JOIN DimFamilyFinancialState dffs
ON sr.fin_state = dffs.fam_financial_state
LEFT JOIN DimKidsUnder14 dku
ON sr.has_kids = dku.has_kids_under_14
LEFT JOIN DimIsPayer dip
ON sr.who_pays = dip.who_pays
LEFT JOIN DimQuestion dq
ON sr.question = UPPER(dq.short_name_eng)
LEFT JOIN DimDate dd
ON sr.date = dd.date) AS src

ON dst.date = src.date AND dst.phone_num = src.phone_n

WHEN NOT MATCHED THEN
INSERT (date, phone_num, operator_id, weight, score, age_id, gender_id,
		spending_id, location_id, experience_id, occupation_id, education_level_id,
	    family_financial_state_id, has_kids_under_14_id, avg_monthly_spending, is_the_payer, question_id, date_id)
VALUES (src.date, src.phone_n, src.dim_oper_sk_pk, src.weight, src.score, src.id, src.gender_id,
		src.spending_id, src.location_id, src.experience_id, src.occupation_id, src.education_lvl_id,
	    src.financial_state_id, src.has_kids_id, src.spendings, src.is_payer_id, src.question_id, src.date_id);


--update fact table
INSERT INTO {dst_table_name} (
	date,
    phone_num,
    participant_id_nk,
    operator_id,
    age_id,
    gender_id,
    spending_id,
    location_id,
    experience_id,
    participant_id,
    occupation_id,
    education_level_id,
    has_kids_under_14_id,
    family_financial_state_id,
	question_id,
    date_id,
    avg_monthly_spending,
    is_the_payer,
    score,
    weight)
SELECT
	date,
    phone_num,
    participant_id_nk,
    operator_id,
    age_id,
    gender_id,
    spending_id,
    location_id,
    experience_id,
    participant_id,
    occupation_id,
    education_level_id,
    has_kids_under_14_id,
    family_financial_state_id,
	question_id,
    date_id,
    avg_monthly_spending,
    is_the_payer,
    score,
    weight
FROM temp_staging_fact;