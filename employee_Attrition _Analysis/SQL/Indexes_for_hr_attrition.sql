SELECT COUNT(*) AS total_rows FROM hr_attrition;

SELECT Attrition, COUNT(*) AS count
FROM hr_attrition
GROUP BY Attrition;



-- ─────────────────────────────────────────
-- Indexes for hr_attrition

-- Speeds up all 8 analyses
-- ─────────────────────────────────────────

CREATE INDEX idx_attrition   ON hr_attrition (Attrition);
CREATE INDEX idx_department  ON hr_attrition (Department);
CREATE INDEX idx_jobrole     ON hr_attrition (JobRole);
CREATE INDEX idx_overtime    ON hr_attrition (OverTime);
CREATE INDEX idx_agegroup    ON hr_attrition (AgeGroup);
CREATE INDEX idx_jobsat      ON hr_attrition (JobSatisfaction);
CREATE INDEX idx_wlb         ON hr_attrition (WorkLifeBalance);
CREATE INDEX idx_income      ON hr_attrition (MonthlyIncome);
