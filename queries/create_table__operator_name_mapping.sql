CREATE TABLE {table_name} (
    oper_name_source VARCHAR UNIQUE,
	oper_name_perm VARCHAR,
	insertion_date TIMESTAMP DEFAULT Now()
);
