--the output to the first ten rows --
SELECT top 10* FROM international_debt
/*column 1 : country_name
column 2: country_code
column 3: indicator_name: the purpose of taking the debt
column 4: indicator_code : the category of these debts
column 4: debt : the amout of debt
*/
--countries have more than $1 billion  in dept and what indicator name is that debt in?
SELECT *
FROM international_debt
WHERE debt > 1000000000
--total distinct countries
SELECT COUNT(DISTINCT(country_name)) AS total_distinct_countries
FROM international_debt
SELECT COUNT(DISTINCT(indicator_code)) AS total_indicator_code
FROM international_debt
/*124*/
--distinct indicator code
SELECT DISTINCT(indicator_code) AS distinct_debt_indicators
FROM international_debt
ORDER BY indicator_code asc
--total debt of 124 countries ( billion $USD)
SELECT 
ROUND(SUM(debt)/1000000000, 2) AS total_debt
FROM international_debt
/*3079.73 billion USD*/
--Top 10 countries with the most debt
SELECT  TOP 10 country_name,
ROUND(SUM(debt)/1000000000,2) as total_debt
FROM international_debt
GROUP BY country_name
ORDER BY total_debt desc
--The country has the lowest debt
SELECT  TOP 1 country_name,
ROUND(SUM(debt)/1000000000,2) as total_debt
FROM international_debt
GROUP BY country_name
ORDER BY total_debt asc
/* Sao Tome and Principe*/
--Top 10 indicator_name have the most average_debt
SELECT top 10
    indicator_code  AS debt_indicator,
    indicator_name ,
    AVG(debt/1000000000) AS average_debt
FROM international_debt
GROUP BY indicator_code, indicator_name
ORDER BY average_debt DESC
--the indicator DT.AMT.DLXF.CD tops the chart of average debt => which country owes the highest amount of debt in this indicator
SELECT 
    country_name, 
    indicator_name
FROM international_debt
WHERE debt = (SELECT 
                 MAX(debt)
             FROM international_debt
             WHERE indicator_code LIKE 'DT.AMT.DLXF.CD')
/*China*/
--the most common indicator in which the countries owe their debt 
SELECT top 15
indicator_code, COUNT(indicator_code) AS indicator_count
FROM international_debt
GROUP BY indicator_code
ORDER BY indicator_count DESC, indicator_code DESC
-- the lowest indicator in which the coutries owe their debt
SELECT TOP 1
indicator_code, count(indicator_code) as indicator_count
FROM international_debt
GROUP BY indicator_code
ORDER BY indicator_count ASC
/*DT.DIS.PROP.CB and 19 indicator*/
--  max_debt and average_debt in VietNam
SELECT  MAX(debt/1000000000) as max_debt, AVG(debt/1000000000) as average_debt
FROM international_debt
WHERE country_name like 'Vietnam'
/*max_debt = 8.87 and average_debt = 2.08414*/

