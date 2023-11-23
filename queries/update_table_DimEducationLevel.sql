MERGE INTO {dst_table_name} dst

USING (
SELECT DISTINCT sr.education_lvl
FROM {src_table_name} sr
LEFT JOIN {dst_table_name} del
ON sr.education_lvl = del.education_level) AS src

ON src.education_lvl = dst.education_level

WHEN NOT MATCHED THEN
INSERT (education_level)
VALUES (src.education_lvl);