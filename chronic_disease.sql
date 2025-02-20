CREATE TABLE chronic_disease (
    YearStart INT,
    LocationAbbr VARCHAR(10),
    LocationDesc VARCHAR(255),
    Topic VARCHAR(255),
    Question TEXT,
    DataValueUnit VARCHAR(50),
    DataValueType VARCHAR(50),
    DataValue FLOAT,
    DataValueAlt VARCHAR(50),
    LowConfidenceLimit FLOAT,
    HighConfidenceLimit FLOAT,
    StratificationCategory1 VARCHAR(255),
    Stratification1 VARCHAR(255),
    LocationID INT
);
select * from chronic_disease

COPY chronic_disease 
FROM 'C:\chronic_Disease.csv' 
DELIMITER ',' 
CSV HEADER;

--1. Find the Most Common Chronic Disease
SELECT Topic, COUNT(*) AS Count
FROM chronic_disease
GROUP BY Topic
ORDER BY Count DESC
LIMIT 1;

--2. Get the Trend of a Disease Over the Years
SELECT YearStart, AVG(DataValue) AS Avg_Prevalence
FROM chronic_disease
WHERE Topic = 'Diabetes'
GROUP BY YearStart
ORDER BY YearStart;

--for cancer
SELECT YearStart, AVG(DataValue) AS Avg_Prevalence
FROM chronic_disease
WHERE Topic = 'Cancer'
GROUP BY YearStart
ORDER BY YearStart;

--3. Find the Highest Prevalence State for a Disease
SELECT LocationDesc, MAX(DataValue) AS Max_Prevalence
FROM chronic_disease
WHERE Topic = 'Asthma'
GROUP BY LocationDesc
ORDER BY Max_Prevalence DESC
LIMIT 1;

--4. Compare Disease Rates by Demographic Group
SELECT Stratification1 AS Gender, AVG(DataValue) AS Avg_Prevalence
FROM chronic_disease
WHERE StratificationCategory1 = 'Sex'
GROUP BY Stratification1;

--5. Compare Disease Prevalence Between Males and Females for a Specific Disease
SELECT Stratification1 AS Gender, AVG(DataValue) AS Avg_Prevalence
FROM chronic_disease
WHERE Topic = 'Cancer' AND StratificationCategory1 = 'Sex'
GROUP BY Stratification1;

--6. Find the Year with the Highest Disease Prevalence Overall
SELECT YearStart, AVG(DataValue) AS Avg_Prevalence
FROM chronic_disease
GROUP BY YearStart
ORDER BY Avg_Prevalence DESC
LIMIT 1;







