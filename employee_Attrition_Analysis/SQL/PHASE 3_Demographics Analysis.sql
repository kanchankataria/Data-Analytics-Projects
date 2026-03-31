-- ─────────────────────────────────────────
-- PHASE 3: Demographics Analysis

-- ─────────────────────────────────────────

-- Attrition by age group
SELECT
    AgeGroup,
    COUNT(*)                                        AS total,
    SUM(CAST(Attrition_Num AS INT))                 AS left_count,
    ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
          / COUNT(*), 2)                            AS attrition_rate_pct
FROM hr_attrition
WHERE AgeGroup IS NOT NULL
  AND AgeGroup != ''
GROUP BY AgeGroup
ORDER BY attrition_rate_pct DESC;

-- Gender vs attrition
SELECT
    Gender,
    COUNT(*)                                        AS total,
    SUM(CAST(Attrition_Num AS INT))                 AS left_count,
    ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
          / COUNT(*), 2)                            AS attrition_rate_pct
FROM hr_attrition
GROUP BY Gender;

-- Average monthly income by job role
SELECT
    JobRole,
    COUNT(*)                                        AS headcount,
    ROUND(AVG(MonthlyIncome), 0)                    AS avg_monthly_income,
    ROUND(AVG(CASE WHEN Attrition = 'Yes'
                   THEN MonthlyIncome END), 0)      AS avg_income_leavers,
    ROUND(AVG(CASE WHEN Attrition = 'No'
                   THEN MonthlyIncome END), 0)      AS avg_income_stayers
FROM hr_attrition
GROUP BY JobRole
ORDER BY avg_monthly_income DESC;

-- Income distribution: stayers vs leavers
-- ⚠️ STDDEV replaced with STDEV for SQL Server
SELECT
    Attrition,
    ROUND(AVG(MonthlyIncome), 0)                    AS avg_income,
    MIN(MonthlyIncome)                              AS min_income,
    MAX(MonthlyIncome)                              AS max_income,
    ROUND(STDEV(MonthlyIncome), 0)                  AS stddev_income
FROM hr_attrition
GROUP BY Attrition;
