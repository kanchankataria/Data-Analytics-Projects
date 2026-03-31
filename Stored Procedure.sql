-- ─────────────────────────────────────────
-- ANALYSIS 8: Stored Procedure
-- Department Attrition Report
-- Usage: EXEC GetDepartmentReport 'Sales'
-- ─────────────────────────────────────────

CREATE PROCEDURE GetDepartmentReport
    @dept_name NVARCHAR(50)
AS
BEGIN

    -- ── Section 1: Department overall summary ──
    PRINT '── SECTION 1: Department Summary ──';
    SELECT
        Department,
        COUNT(*)                                        AS total_employees,
        SUM(CAST(Attrition_Num AS INT))                 AS employees_left,
        COUNT(*) - SUM(CAST(Attrition_Num AS INT))      AS employees_stayed,
        ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
              / COUNT(*), 2)                            AS attrition_rate_pct,
        ROUND(AVG(CAST(MonthlyIncome AS FLOAT)), 0)     AS avg_monthly_income,
        ROUND(AVG(CAST(Age AS FLOAT)), 1)               AS avg_age
    FROM hr_attrition
    WHERE Department = @dept_name
    GROUP BY Department;

    -- ── Section 2: Breakdown by Job Role ──
    PRINT '── SECTION 2: By Job Role ──';
    SELECT
        JobRole,
        COUNT(*)                                        AS total_employees,
        SUM(CAST(Attrition_Num AS INT))                 AS employees_left,
        ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
              / COUNT(*), 2)                            AS attrition_rate_pct,
        ROUND(AVG(CAST(MonthlyIncome AS FLOAT)), 0)     AS avg_income
    FROM hr_attrition
    WHERE Department = @dept_name
    GROUP BY JobRole
    ORDER BY attrition_rate_pct DESC;

    -- ── Section 3: Overtime impact ──
    PRINT '── SECTION 3: Overtime Impact ──';
    SELECT
        OverTime,
        COUNT(*)                                        AS total_employees,
        SUM(CAST(Attrition_Num AS INT))                 AS employees_left,
        ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
              / COUNT(*), 2)                            AS attrition_rate_pct
    FROM hr_attrition
    WHERE Department = @dept_name
    GROUP BY OverTime;

    -- ── Section 4: Age group breakdown ──
    PRINT '── SECTION 4: By Age Group ──';
    SELECT
        AgeGroup,
        COUNT(*)                                        AS total_employees,
        SUM(CAST(Attrition_Num AS INT))                 AS employees_left,
        ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
              / COUNT(*), 2)                            AS attrition_rate_pct
    FROM hr_attrition
    WHERE Department = @dept_name
      AND AgeGroup != ''
    GROUP BY AgeGroup
    ORDER BY attrition_rate_pct DESC;

    -- ── Section 5: Job satisfaction breakdown ──
    PRINT '── SECTION 5: Job Satisfaction ──';
    SELECT
        CASE JobSatisfaction
            WHEN 1 THEN '1-Low'
            WHEN 2 THEN '2-Medium'
            WHEN 3 THEN '3-High'
            WHEN 4 THEN '4-Very High'
        END                                             AS satisfaction_label,
        COUNT(*)                                        AS total_employees,
        SUM(CAST(Attrition_Num AS INT))                 AS employees_left,
        ROUND(SUM(CAST(Attrition_Num AS INT)) * 100.0
              / COUNT(*), 2)                            AS attrition_rate_pct
    FROM hr_attrition
    WHERE Department = @dept_name
    GROUP BY JobSatisfaction
    ORDER BY JobSatisfaction;

END;


EXEC GetDepartmentReport 'Sales';