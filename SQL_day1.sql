-- SQL CHALLENGES
--
-- WHERE
--
-- What is the population of the US? (starts with 2, ends with 000)

SELECT
  population
FROM
  country
WHERE
  name = 'United States';

  --
  -- What is the area of the US? (starts with 9, ends with million square miles)

  SELECT
    surfacearea
  FROM
    country
  WHERE
    name = 'United States';


  -- List the countries in Africa that have a population smaller than 30,000,000 and a life expectancy of more than 45? (all 37 of them)

  Select
    name,
    population,
    lifeexpectancy
  FROM
    country
  WHERE
    continent = 'Africa'
    AND
    population < 30000000
    AND
    lifeexpectancy > 45;

    -- Which countries are something like a republic? (are there 122 or 143 countries or ?)

    Select
   *
  FROM
    country
   WHERE
    governmentform LIKE '%Republic%';


    -- Which countries are some kind of republic and acheived independence after 1945?

    Select
        name,
        governmentform,
        indepyear
    FROM
        country
    WHERE
        governmentform LIKE '%Republic%'
        AND
        indepyear > 1945;


    -- Which countries acheived independence after 1945 and are not some kind of republic?


    Select
        name,
        governmentform,
        indepyear
    FROM
        country
    WHERE
        NOT(governmentform LIKE '%Republic%')
        AND
        indepyear > 1945;


    -- ORDER BY

    -- Which fifteen countries have the lowest life expectancy? highest life expectancy?

-- to get the low to high
    Select
    name,
    lifeexpectancy
    FROM
      country
    WHERE
	lifeexpectancy > 0
	ORDER BY lifeexpectancy ASC
	LIMIT 15;

-- to get high to low
  Select
    name,
    lifeexpectancy
    FROM
      country
    WHERE
	lifeexpectancy > 0
	ORDER BY lifeexpectancy desc
	LIMIT 15;


-- Which five countries have the lowest population density? highest population density?

-- low to high

Select
  name,
  population
  FROM
    country
  WHERE
population > 0
ORDER BY population ASC
LIMIT 5;


-- HIGH TO LOW

Select
name,
population
FROM
country
WHERE
population > 0
ORDER BY population DESC
LIMIT 5;

-- Which is the smallest country, by area and population? the 10 smallest countries, by area and population?

-- to get the smallest country (area,pop)

Select
   name,
   surfacearea,
   population
   FROM
     country
   WHERE
 surfacearea > 0  AND population > 0
 ORDER BY surfacearea ASC, population ASC
 LIMIT 1;

-- to get the 10 smallest countries (area,pop)

 Select
    name,
    surfacearea,
    population
    FROM
      country
    WHERE
	surfacearea > 0  AND population > 0
	ORDER BY surfacearea ASC, population ASC
	LIMIT 10;


  -- Which is the biggest country, by area and population? the 10 biggest countries, by area and population?

-- to get the largest country (area,pop)
  Select
   name,
   surfacearea,
   population
   FROM
     country
   WHERE
 surfacearea > 0  AND population > 0
 ORDER BY surfacearea DESC, population DESC
 LIMIT 1;

-- to get the 10 largest countries(area,pop)
 Select
   name,
   surfacearea,
   population
   FROM
     country
   WHERE
 surfacearea > 0  AND population > 0
 ORDER BY surfacearea DESC, population DESC
 LIMIT 10;

-- WITH

-- Of the smallest 10 countries, which has the biggest gnp? (hint: use WITH and LIMIT)


-- finds the smallest countries and orders them by biggest GNP

Select
	name,
	surfacearea,
	gnp
    FROM
      country
     WHERE
	surfacearea < 37
	ORDER BY GNP DESC
	LIMIT 10;



  -- Of the smallest 10 countries, which has the biggest per capita gnp?

-- with allows you to creat a new colum to call on

  WITH
populated_countries AS
(SELECT
  name,
  population,
  gnp

FROM
    country
WHERE
     population > 0)

Select
name,

gnp,
population,
gnp / population AS gnp_per_capita
  FROM
    populated_countries
   WHERE
gnp / population > 0
ORDER BY population ASC, GNP ASC
LIMIT 10;


-- Of the biggest 10 countries, which has the biggest gnp?


Select
	name,
	surfacearea,
	gnp,
	population
    FROM
      country
     WHERE
	surfacearea > 0
	ORDER BY population DESC, GNP DESC
	LIMIT 10;

  -- Of the biggest 10 countries, which has the biggest per capita gnp?

  WITH
  	populated_countries AS
  	(SELECT
  		name,
  		population,
  		gnp

  	FROM
  	    country
  	WHERE
  	     population > 0)

    Select
  	name,

  	gnp,
  	population,
  	gnp / population AS gnp_per_capita
      FROM
        populated_countries
       WHERE
  	gnp / population > 0
  	ORDER BY population DESC, GNP DESC
  	LIMIT 10;

    -- What is the sum of surface area of the 10 biggest countries in the world? The 10 smallest?

-- 10 largest countries (surfacearea combined)

WITH
   surfacearea_sum AS
   (SELECT
	surfacearea
    FROM
       country
   WHERE
	surfacearea > 0
        LIMIT 10)


SELECT
   SUM(surfacearea) AS surfacearea_sum
FROM
   surfacearea_sum


-- 10 smallest countries combined by surface area
   WITH
   surfacearea_sum AS
   (SELECT
	surfacearea
    FROM
       country
   WHERE
	surfacearea > 0
	ORDER BY surfacearea ASC
        LIMIT 10)


SELECT
   SUM(surfacearea) AS surfacearea_sum
FROM
   surfacearea_sum


  --  How big are the continents in term of area and population?

  SELECT continent, sum(country.surfacearea), sum(country.population)
  FROM country
  GROUP BY continent


  -- Which region has the highest average gnp?

  SELECT region, AVG(gnp) AS avg_gnp
  FROM country
  GROUP BY region
	ORDER BY avg_gnp DESC

  -- Who is the most influential head of state measured by population?


  SELECT headofstate, sum(population) AS head_pop
FROM country
GROUP BY headofstate
ORDER BY head_pop DESC


-- Who is the most influential head of state measured by surface area?

SELECT headofstate, sum(surfacearea) AS surface
FROM country
GROUP BY headofstate
ORDER BY surface DESC
