-- ─────────────────────────────────────────
-- ANALYSIS 2: Attrition Overview

-- ─────────────────────────────────────────

-- Overall attrition rate
SELECT
    COUNT(*)                                        AS total_employees,
    SUM(CAST(Attrition_Num AS INT))                 AS employees_left,
    ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
          / COUNT(*), 2)                            AS attrition_rate_pct
FROM hr_attrition;

-- Attrition by department
SELECT
    Department,
    COUNT(*)                                        AS total,
    SUM(CAST(Attrition_Num AS INT))                 AS left_count,
    ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
          / COUNT(*), 2)                            AS attrition_rate_pct
FROM hr_attrition
GROUP BY Department
ORDER BY attrition_rate_pct DESC;

-- Top 6 job roles by attrition rate
SELECT TOP 6
    JobRole,
    COUNT(*)                                        AS total,
    SUM(CAST(Attrition_Num AS INT))                 AS left_count,
    ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
          / COUNT(*), 2)                            AS attrition_rate_pct
FROM hr_attrition
GROUP BY JobRole
ORDER BY attrition_rate_pct DESC;

-- Overtime vs attrition
SELECT
    OverTime,
    COUNT(*)                                        AS total,
    SUM(CAST(Attrition_Num AS INT))                 AS left_count,
    ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
          / COUNT(*), 2)                            AS attrition_rate_pct
FROM hr_attrition
GROUP BY OverTime;