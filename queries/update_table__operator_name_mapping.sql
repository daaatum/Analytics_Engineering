INSERT INTO {bridge_table_name} (oper_name_source,  oper_name_perm)
VALUES ('Vivacell', 'VIVA'), ('Vivacel','VIVA'), ('Viva', 'VIVA'),
       ('Beeline', 'Team|Beeline'), ('Team', 'Team|Beeline'),
       ('Ucom', 'UCOM'), ('ucom', 'UCOM')
ON CONFLICT (oper_name_source)
DO NOTHING;