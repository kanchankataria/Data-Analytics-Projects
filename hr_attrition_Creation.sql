create database hr_database;


-- Create the table (PostgreSQL compatible)
CREATE TABLE hr_attrition (
    EmployeeNumber    INT PRIMARY KEY,
    Age               INT,
    AgeGroup          VARCHAR(10),
    Attrition         VARCHAR(5),     -- 'Yes' / 'No'
    Attrition_Num     TINYINT,        -- 1 = left, 0 = stayed
    Department        VARCHAR(50),
    JobRole           VARCHAR(50),
    Gender            VARCHAR(10),
    MaritalStatus     VARCHAR(15),
    BusinessTravel    VARCHAR(30),
    EducationField    VARCHAR(30),
    JobLevel          INT,
    JobSatisfaction   INT,
    EnvironmentSatisfaction INT,
    WorkLifeBalance   INT,
    JobInvolvement    INT,
    OverTime          VARCHAR(5),
    MonthlyIncome     INT,
    DailyRate         INT,
    HourlyRate        INT,
    PercentSalaryHike INT,
    StockOptionLevel  INT,
    TotalWorkingYears INT,
    YearsAtCompany    INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager    INT,
    NumCompaniesWorked       INT,
    TrainingTimesLastYear    INT,
    DistanceFromHome         INT,
    PerformanceRating        INT,
    Education                INT
);



DROP TABLE IF EXISTS hr_attrition;

