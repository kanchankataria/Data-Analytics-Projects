-- ─────────────────────────────────────────
-- PHASE 7: Executive Summary KPI Dashboard
-- ─────────────────────────────────────────

WITH base AS (
    SELECT
        COUNT(*)                                        AS total_emp,
        SUM(CAST(Attrition_Num AS INT))                 AS total_left,
        ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
              / COUNT(*), 2)                            AS overall_rate,
        ROUND(AVG(CAST(MonthlyIncome AS FLOAT)), 0)     AS avg_income,
        ROUND(SUM(CASE WHEN OverTime = 'Yes'
                       THEN CAST(Attrition_Num AS INT)
                       ELSE 0 END) * 100.0
              / NULLIF(SUM(CASE WHEN OverTime = 'Yes'
                                THEN 1 ELSE 0 END), 0)
              , 2)                                      AS ot_attrition_rate,
        ROUND(SUM(CASE WHEN JobSatisfaction = 1
                       THEN CAST(Attrition_Num AS INT)
                       ELSE 0 END) * 100.0
              / NULLIF(SUM(CASE WHEN JobSatisfaction = 1
                                THEN 1 ELSE 0 END), 0)
              , 2)                                      AS low_sat_rate,
        ROUND(SUM(CASE WHEN AgeGroup = '18-25'
                       THEN CAST(Attrition_Num AS INT)
                       ELSE 0 END) * 100.0
              / NULLIF(SUM(CASE WHEN AgeGroup = '18-25'
                                THEN 1 ELSE 0 END), 0)
              , 2)                                      AS young_attrition_rate
    FROM hr_attrition
)
SELECT * FROM base;
