-- ─────────────────────────────────────────
-- PHASE 4: Satisfaction & Overtime
-- ─────────────────────────────────────────

-- Job satisfaction vs attrition rate
SELECT
    JobSatisfaction,
    CASE JobSatisfaction
        WHEN 1 THEN '1-Low'
        WHEN 2 THEN '2-Medium'
        WHEN 3 THEN '3-High'
        WHEN 4 THEN '4-Very High'
    END                                             AS satisfaction_label,
    COUNT(*)                                        AS total,
    SUM(CAST(Attrition_Num AS INT))                 AS left_count,
    ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
          / COUNT(*), 2)                            AS attrition_rate_pct
FROM hr_attrition
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

-- Work-life balance vs attrition
SELECT
    WorkLifeBalance,
    CASE WorkLifeBalance
        WHEN 1 THEN '1-Bad'
        WHEN 2 THEN '2-Good'
        WHEN 3 THEN '3-Better'
        WHEN 4 THEN '4-Best'
    END                                             AS wlb_label,
    COUNT(*)                                        AS total,
    SUM(CAST(Attrition_Num AS INT))                 AS left_count,
    ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
          / COUNT(*), 2)                            AS attrition_rate_pct
FROM hr_attrition
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance;

-- Cross-tab: Overtime x JobSatisfaction
SELECT
    OverTime,
    JobSatisfaction,
    COUNT(*)                                        AS total,
    SUM(CAST(Attrition_Num AS INT))                 AS left_count,
    ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
          / COUNT(*), 2)                            AS attrition_rate_pct
FROM hr_attrition
GROUP BY OverTime, JobSatisfaction
ORDER BY OverTime, JobSatisfaction;