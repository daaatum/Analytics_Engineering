MERGE INTO {dst_table_name} dst

USING (
SELECT DISTINCT sr.spending_range
FROM {src_table_name} sr
LEFT JOIN {dst_table_name} dsr
ON sr.spending_range = dsr.spending_range) AS src

ON src.spending_range = dst.spending_range

WHEN NOT MATCHED THEN
INSERT (spending_range)
VALUES (src.spending_range);