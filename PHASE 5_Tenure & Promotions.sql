-- ─────────────────────────────────────────
-- PHASE 5: Tenure & Promotions
-- ─────────────────────────────────────────

-- Years at company: stayers vs leavers
SELECT
    Attrition,
    ROUND(AVG(CAST(YearsAtCompany AS FLOAT)), 2)        AS avg_years_at_company,
    ROUND(AVG(CAST(YearsInCurrentRole AS FLOAT)), 2)    AS avg_years_in_role,
    ROUND(AVG(CAST(YearsSinceLastPromotion AS FLOAT)), 2) AS avg_yrs_since_promotion,
    ROUND(AVG(CAST(YearsWithCurrManager AS FLOAT)), 2)  AS avg_yrs_with_manager
FROM hr_attrition
GROUP BY Attrition;

-- Promotion lag analysis
SELECT
    CASE
        WHEN YearsSinceLastPromotion = 0            THEN 'Just promoted'
        WHEN YearsSinceLastPromotion BETWEEN 1 AND 2 THEN '1-2 yrs ago'
        WHEN YearsSinceLastPromotion BETWEEN 3 AND 5 THEN '3-5 yrs ago'
        ELSE '6+ yrs ago'
    END                                             AS promotion_bucket,
    COUNT(*)                                        AS total,
    SUM(CAST(Attrition_Num AS INT))                 AS left_count,
    ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
          / COUNT(*), 2)                            AS attrition_rate_pct
FROM hr_attrition
GROUP BY
    CASE
        WHEN YearsSinceLastPromotion = 0            THEN 'Just promoted'
        WHEN YearsSinceLastPromotion BETWEEN 1 AND 2 THEN '1-2 yrs ago'
        WHEN YearsSinceLastPromotion BETWEEN 3 AND 5 THEN '3-5 yrs ago'
        ELSE '6+ yrs ago'
    END
ORDER BY attrition_rate_pct DESC;

-- Tenure bands
SELECT
    CASE
        WHEN YearsAtCompany <= 1  THEN '0-1 yrs'
        WHEN YearsAtCompany <= 3  THEN '2-3 yrs'
        WHEN YearsAtCompany <= 5  THEN '4-5 yrs'
        WHEN YearsAtCompany <= 10 THEN '6-10 yrs'
        ELSE '10+ yrs'
    END                                             AS tenure_band,
    COUNT(*)                                        AS total,
    SUM(CAST(Attrition_Num AS INT))                 AS left_count,
    ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
          / COUNT(*), 2)                            AS attrition_rate_pct
FROM hr_attrition
GROUP BY
    CASE
        WHEN YearsAtCompany <= 1  THEN '0-1 yrs'
        WHEN YearsAtCompany <= 3  THEN '2-3 yrs'
        WHEN YearsAtCompany <= 5  THEN '4-5 yrs'
        WHEN YearsAtCompany <= 10 THEN '6-10 yrs'
        ELSE '10+ yrs'
    END
ORDER BY attrition_rate_pct DESC;