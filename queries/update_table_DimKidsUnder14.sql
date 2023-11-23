MERGE INTO {dst_table_name} dst

USING (
SELECT DISTINCT sr.has_kids
FROM {src_table_name} sr
LEFT JOIN {dst_table_name} dhk
ON sr.has_kids = dhk.has_kids_under_14) AS src

ON src.has_kids = dst.has_kids_under_14

WHEN NOT MATCHED THEN
INSERT (has_kids_under_14)
VALUES (src.has_kids);