CREATE VIEW nps_calculation AS
    SELECT permanent_name, %s, ((SUM(promoter_weights) - SUM(detractor_weights)) / SUM(weights))*100 AS nps
    FROM nps_by_features
    GROUP BY permanent_name, %s
    ORDER BY permanent_name;