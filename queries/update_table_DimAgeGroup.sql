MERGE INTO {dst_table_name} dst

USING (
SELECT DISTINCT sr.age_group
FROM {src_table_name} sr
LEFT JOIN {dst_table_name} dag
ON sr.age_group = dag.age_group) AS src

ON src.age_group = dst.age_group

WHEN NOT MATCHED THEN
INSERT (age_group)
VALUES (src.age_group);