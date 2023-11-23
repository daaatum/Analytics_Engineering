MERGE INTO {dst_table_name} dst

USING (
SELECT DISTINCT sr.usage_period
FROM {src_table_name} sr
LEFT JOIN {dst_table_name} de
ON sr.usage_period = de.usage_time_range) AS src

ON src.usage_period = dst.usage_time_range

WHEN NOT MATCHED THEN
INSERT (usage_time_range)
VALUES (src.usage_period);