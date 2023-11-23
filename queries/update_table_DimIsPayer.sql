MERGE INTO {dst_table_name} dst

USING (
SELECT DISTINCT sr.who_pays
FROM {src_table_name} sr
LEFT JOIN {dst_table_name} dip
ON sr.who_pays = dip.who_pays) AS src

ON src.who_pays = dst.who_pays

WHEN NOT MATCHED THEN
INSERT (who_pays)
VALUES (src.who_pays);

