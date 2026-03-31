-- ─────────────────────────────────────────
-- PHASE 6: Risk Segmentation
-- ─────────────────────────────────────────

-- Assign each employee a risk score
SELECT
    EmployeeNumber,
    JobRole,
    Department,
    Age,
    MonthlyIncome,
    OverTime,
    JobSatisfaction,
    YearsSinceLastPromotion,
    Attrition,
    (
        CASE WHEN OverTime = 'Yes'                THEN 1 ELSE 0 END +
        CASE WHEN JobSatisfaction = 1             THEN 1 ELSE 0 END +
        CASE WHEN YearsSinceLastPromotion >= 4    THEN 1 ELSE 0 END +
        CASE WHEN MonthlyIncome < 3000            THEN 1 ELSE 0 END +
        CASE WHEN WorkLifeBalance = 1             THEN 1 ELSE 0 END
    )                                             AS risk_score
FROM hr_attrition
ORDER BY risk_score DESC;

-- Attrition rate by risk tier

SELECT
    risk_score,
    COUNT(*)                                        AS total,
    SUM(CAST(Attrition_Num AS INT))                 AS left_count,
    ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
          / COUNT(*), 2)                            AS attrition_rate_pct
FROM (
    SELECT
        Attrition_Num,
        (
            CASE WHEN OverTime = 'Yes'             THEN 1 ELSE 0 END +
            CASE WHEN JobSatisfaction = 1          THEN 1 ELSE 0 END +
            CASE WHEN YearsSinceLastPromotion >= 4 THEN 1 ELSE 0 END +
            CASE WHEN MonthlyIncome < 3000         THEN 1 ELSE 0 END +
            CASE WHEN WorkLifeBalance = 1          THEN 1 ELSE 0 END
        )                                           AS risk_score
    FROM hr_attrition
) AS scored
GROUP BY risk_score
ORDER BY risk_score DESC;
