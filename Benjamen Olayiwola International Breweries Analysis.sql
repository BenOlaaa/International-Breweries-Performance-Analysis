/* International Breweries Analysis */

/* Profit Worth of Brewery within the last 3 years in different territories */
select SUM(profit) as TotalProfit_last_3_years
from
breweries



/* Total profit comparism between 2 territories to aid profit maximization in the coming years */
select CASE
        when countries = 'Nigeria'THEN 'Anglophone'
        when countries = 'Benin'THEN 'Francophone'
        when countries = 'Senegal'THEN 'Francophone'
        when countries = 'Ghana'THEN 'Anglophone'
        when countries = 'Togo'THEN 'Francophone'
    END AS region, 
    SUM(profit)
FROM breweries
GROUP BY 1
ORDER BY 2 DESC 

/* OR */

Select sum(profit) as Anglophone,
(select sum(profit) as francophone
    FROM breweries
    where countries IN ('Benin', 'Senegal', 'Togo'))
FROM breweries
WHERE countries IN ('Nigeria', 'Ghana')



/* Country with the highest profit generated in 2019 */
SELECT countries, sum(profit)
from breweries
WHERE years = 2019
GROUP BY 1 
ORDER BY 2 DESC

/* Overal profit generated */
SELECT years, sum(profit) AS SumOfProfit
FROM breweries
GROUP BY 1
ORDER BY 2 DESC



/* Month with the least profit number in 3 years */
SELECT months, SUM(profit) AS SumOfProfit
FROM breweries
GROUP BY months
ORDER BY 2 ASC



/* Minimum profit generated in the month of December 2019 */
SELECT min(profit), months, years
FROM breweries 
WHERE months = 'December' AND years = 2018
GROUP BY 2,3
ORDER BY 1 DESC

/* OR */

SELECT profit, months, years
FROM breweries 
WHERE months = 'December' AND years = 2018
GROUP BY 1,2,3
ORDER BY 1 ASC
LIMIT 10


/* Profit in percentage for each month in 2019 */

SELECT months, profit_Per_Month, (profit_Per_Month * (100/(SELECT sum(profit)
FROM breweries
WHERE years = 2019))) AS profit_in_percentage
FROM
(SELECT sum(profit) AS profit_Per_Month, months, years
FROM breweries
WHERE years = 2019
GROUP BY 2,3
ORDER BY 1 DESC) as sub1



/* Brand with the highest profit in Senegal */
SELECT brands, sum(profit) AS sum_of_profit, countries
FROM breweries
WHERE countries = 'Senegal'
GROUP BY 1,3
ORDER BY 2 DESC


/* SECTION B (BRAND ANALYSIS) */

/* Top 3 brands consumed in the francophone countries */

SELECT brands, sum(quantity) AS QTYConsumed
FROM breweries
WHERE countries IN ('Togo', 'Senegal','Benin') AND years IN (2019, 2018)
GROUP BY 1
ORDER BY 2 DESC LIMIT 3

/* Top 2 consumer brnads in Ghana */

SELECT brands, sum(quantity) AS QTYConsumed
FROM breweries
WHERE countries IN ('Ghana')
GROUP BY 1
ORDER BY 2 DESC LIMIT 2

/* Product brand consumption in the most oil reached country in west Africa */

SELECT brands, sum(quantity) AS QTYConsumed, sum(profit) AS sum_of_profit, years
FROM breweries
WHERE brands NOT LIKE '%malt%' AND countries IN ('Nigeria') AND years IN ('2017', '2018', '2019' )
GROUP BY 1,4
ORDER BY 4 DESC

/* Favourite malt brand in Anglophone region between 2018 and 2019 */

SELECT brands, sum(quantity) AS Anglophone_QTY_Consumed
FROM breweries
WHERE brands LIKE '%malt%' AND countries IN ('Nigeria', 'Ghana') AND years IN ('2018', '2019' )
GROUP BY 1
ORDER BY 2 DESC

/* Highest sold brand in Nigeria in 2019 */

SELECT brands, sum(unit_price * quantity) as Sales 
FROM breweries
WHERE years IN ('2019') AND countries IN ('Nigeria')
GROUP BY 1
ORDER BY 2 DESC

/* Favourite Brand in South_South Region Nigeria */

SELECT brands, sum(quantity)
FROM breweries
WHERE region IN ('southsouth') AND countries IN ('Nigeria')
GROUP BY 1
ORDER BY 2 DESC


/* Beer Consumption in Nigeria */

SELECT brands, sum(quantity) AS QTYConsumed
FROM breweries
WHERE brands NOT LIKE '%malt%' AND countries IN ('Nigeria')
GROUP BY 1
ORDER BY 2 DESC


/* Budweiser consumption in the regions of Nigeria */

SELECT brands, region, sum(quantity) AS QTYConsumed
FROM breweries
WHERE brands LIKE '%budweiser%' AND countries IN ('Nigeria')
GROUP BY 1,2
ORDER BY 3 DESC

/* Budweiser consumption in the regions of Nigeria in 2019 */

SELECT brands, region, sum(quantity) AS QTYConsumed
FROM breweries
WHERE brands LIKE '%budweiser%' AND countries IN ('Nigeria') AND years IN ('2019')
GROUP BY 1,2
ORDER BY 3 DESC


/* COUNTRIES ANALYSIS */

/* Country with highest consumption of Beer */

SELECT countries, sum(quantity) AS QTYConsumed
FROM breweries
WHERE brands NOT LIKE '%malt%'
GROUP BY 1
ORDER BY 2 DESC

/* Highest sales personnel of Budweiser in Senegal */

SELECT sales_rep, sum(quantity) AS QTYConsumed
FROM breweries
WHERE brands IN ('budweiser') AND countries IN ('Senegal')
GROUP BY 1
ORDER BY 2 DESC


/* Country with the highest profit of the fourth quarter in 2019 */

SELECT countries, sum(profit) AS Profit_Per_4th_Quarter
FROM breweries
WHERE years IN ('2019') AND months IN ('October', 'November', 'December')
GROUP BY 1
ORDER BY 2 DESC