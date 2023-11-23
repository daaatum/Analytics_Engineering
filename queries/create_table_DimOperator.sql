CREATE TABLE {table_name} (
    dim_oper_sk_pk SERIAL PRIMARY KEY,
    permanent_name VARCHAR,
    current_name VARCHAR,
    quarter_start_date VARCHAR,
    insertion_date TIMESTAMP DEFAULT Now()
);