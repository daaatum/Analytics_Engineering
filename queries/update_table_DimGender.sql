MERGE INTO {dst_table_name} dst

USING (
SELECT DISTINCT sr.gender
FROM {src_table_name} sr
LEFT JOIN {dst_table_name} dag
ON sr.gender = dag.gender) AS src

ON src.gender = dst.gender

WHEN NOT MATCHED THEN
INSERT (gender)
VALUES (src.gender);