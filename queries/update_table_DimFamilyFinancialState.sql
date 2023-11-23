MERGE INTO {dst_table_name} dst

USING (
SELECT DISTINCT sr.fin_state
FROM {src_table_name} sr
LEFT JOIN {dst_table_name} dffs
ON sr.fin_state = dffs.fam_financial_state) AS src

ON src.fin_state = dst.fam_financial_state

WHEN NOT MATCHED THEN
INSERT (fam_financial_state)
VALUES (src.fin_state);