INSERT INTO {dst_table_name}(short_name_eng,long_name_rus)
	(SELECT KEY AS short_name_eng, VALUE AS long_name_rus
		FROM (SELECT row_to_json(t.*) as line
				FROM {src_table_name} t
				LIMIT 1
				) AS r
	CROSS JOIN LATERAL json_each_text (r.line))
ON CONFLICT (short_name_eng)
DO NOTHING;


UPDATE {dst_table_name}
SET is_nps=subquery.is_nps, is_filter_of=subquery.is_filter_of
FROM (SELECT short_name_eng,
	  	CASE
			WHEN short_name_eng IN ('n01', 'q1a', 'q3_1_mob_int') THEN '1'
			ELSE '0'
		END is_nps,
	    CASE
			WHEN short_name_eng IN ('q1a', 'q3_1_mob_int') THEN 'n01'
			ELSE null
		END is_filter_of
	  FROM {dst_table_name}) AS subquery
WHERE {dst_table_name}.short_name_eng=subquery.short_name_eng;