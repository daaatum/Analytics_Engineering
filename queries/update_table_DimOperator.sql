MERGE INTO {dst_table_name} dst

USING (
SELECT DISTINCT sr.operator, onm.oper_name_perm, sr.wave
FROM {src_table_name} sr
LEFT JOIN {bridge_table_name} onm
ON sr.operator = onm.oper_name_source) AS src

ON src.oper_name_perm = dst.permanent_name

WHEN NOT MATCHED THEN
INSERT (current_name, permanent_name, quarter_start_date)
VALUES (src.operator, src.oper_name_perm, src.wave);