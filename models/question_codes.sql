
-- Use the `ref` function to select from other models

with question_codes as (

    SELECT DISTINCT(short_name_eng) FROM {{ ref('nps_by_features') }}
    LEFT JOIN DimQuestion dq
    ON {{ ref('nps_by_features') }}.question_id = dq.question_id
)

select *
from question_codes