
-- Use the `ref` function to select from other models


with nps_by_question_by_oper as (

    SELECT permanent_name, 
           age_group, 
           ((SUM(promoter_weights) - SUM(detractor_weights)) / SUM(weights))*100 AS nps
    FROM {{ ref('nps_by_features') }} 
    LEFT JOIN DimQuestion dq
    ON {{ ref('nps_by_features') }} .question_id = dq.question_id
    WHERE short_name_eng = 'n01'
    GROUP BY permanent_name, age_group
	ORDER BY permanent_name

)

select *
from nps_by_question_by_oper