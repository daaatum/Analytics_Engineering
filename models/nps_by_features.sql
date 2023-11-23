
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='view') }}

with nps_by_features as (

    SELECT question_id, permanent_name, gender, age_group, location_type, usage_time_range,
		SUM(CASE WHEN score >= 9 THEN weight ELSE 0 END) AS promoter_weights,
		SUM(CASE WHEN score >= 0 AND score <= 6 THEN weight ELSE 0 END) AS detractor_weights,
		SUM(CASE WHEN score IN (7,8) THEN weight ELSE 0 END) AS neutral_weights,
		SUM(weight) AS weights
	FROM Fact
	LEFT JOIN DimOperator
		ON Fact.operator_id = DimOperator.dim_oper_sk_pk
	LEFT JOIN DimGender
		ON Fact.gender_id = DimGender.gender_id
	LEFT JOIN DimAgeGroup
		ON Fact.age_id = DimAgeGroup.id
	LEFT JOIN DimLocation
		ON Fact.location_id = DimLocation.location_id
	LEFT JOIN DimExperience
		ON Fact.experience_id = DimExperience.experience_id
    GROUP BY
		question_id, permanent_name, gender, age_group, location_type, usage_time_range

)

select *
from nps_by_features

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
