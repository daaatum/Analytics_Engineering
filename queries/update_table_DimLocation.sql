MERGE INTO {dst_table_name} dst

USING (
SELECT DISTINCT sr.location, sr.location_type
FROM {src_table_name} sr
LEFT JOIN {dst_table_name} dl
ON sr.location = dl.region) AS src

ON src.location = dst.region

WHEN NOT MATCHED THEN
INSERT (region, location_type)
VALUES (src.location, src.location_type);