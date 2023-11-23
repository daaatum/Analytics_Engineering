MERGE INTO {dst_table_name} dst

USING (
SELECT DISTINCT sr.occupation
FROM {src_table_name} sr
LEFT JOIN {dst_table_name} doc
ON sr.occupation = doc.participant_occupation) AS src

ON src.occupation = dst.participant_occupation

WHEN NOT MATCHED THEN
INSERT (participant_occupation)
VALUES (src.occupation);