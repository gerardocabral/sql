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


SQL DAY 2



-- What are the cities of the US? (274) India? (341)

-- finds the US cities

SELECT  name,
	countrycode


FROM city
WHERE countrycode = 'USA'
	ORDER BY name ASC;


  -- finds the cities in India

  SELECT  name,
	countrycode


FROM city
WHERE countrycode = 'IND'
	ORDER BY name ASC;

  -- What are the official languages of Switzerland? (4 languages)

  SELECT
  	countrycode,
  	language


  FROM  countrylanguage

  WHERE countrycode = 'CHE'
  	ORDER BY language ASC;

    -- Which country or contries speak the most languages? (12 languages)

-- correct answer without using JOIN
    SELECT
    	countrycode,
    	COUNT(language) AS language_count


    FROM  countrylanguage

    WHERE countrycode BETWEEN 'ABW' AND 'ZWE'


    GROUP BY countrycode
    ORDER BY language_count DESC

-- also correct answer using JOIN
    SELECT
	cl.countrycode,
	COUNT(language) AS language_count


FROM  country c JOIN countrylanguage cl ON (c.code = cl.countrycode)


GROUP BY countrycode
ORDER BY language_count DESC


    -- Which country or contries have the most offficial languages? (4 languages)

SELECT
c.name,
COUNT(cl.isofficial) AS official_count


FROM  country c JOIN countrylanguage cl ON (c.code = cl.countrycode)

WHERE 	cl.isofficial = 't'
GROUP BY name
ORDER BY official_count DESC


-- Which languages are spoken in the ten largest (area) countries?

WITH
	largest_countries AS
   (SELECT
	surfacearea
    FROM
       country
   WHERE
	surfacearea > 0
	ORDER BY surfacearea DESC
        LIMIT 10)

SELECT  c.surfacearea,
	cl.countrycode,
	c.name,
	cl.language


FROM  country c JOIN countrylanguage cl ON (c.code = cl.countrycode)


GROUP BY name, countrycode, surfacearea, language
ORDER BY c.surfacearea DESC

-- What languages are spoken in the 20 poorest (GNP/ capita) countries in the world? (94 with GNP > 0)

SELECT  c.code,
	c.gnp,
	c.name,
	cl.language,
	c.population,
	c.gnp / c.population AS gnp_pop

FROM  country c JOIN countrylanguage cl ON (c.code = cl.countrycode)


WHERE population > 0
ORDER BY gnp_pop ASC
LIMIT 20;


-- Are there any countries without an official language?


SELECT
-- country name and countrylanguage list all
 c.name,
 cl.*
FROM
-- this joins the two table to allow you to access them at the same time.
 country c JOIN
 countrylanguage cl ON c.code = cl.countrycode
WHERE
-- in the WHERE you nest a query to not include countries that have an official language
 countrycode NOT IN
   (SELECT
     countrycode
    --  selects by country code
   FROM
     countrylanguage
    --  from countrylanguage table
   WHERE
  --  and sorts by the offical languages
     isofficial = 'TRUE')
ORDER BY
-- last it orders the results by country code
 countrycode ASC;

 -- What are the languages spoken in the countries with no official language? (49 countries, 172 languages, incl. English)


-- this allows you to filter through the languages

 SELECT
 DISTINCT cl.language,
 cl.isofficial

 FROM
 country c JOIN
 countrylanguage cl ON c.code = cl.countrycode
WHERE
 countrycode NOT IN
   (SELECT
     countrycode
   FROM
     countrylanguage
   WHERE
     isofficial = 'TRUE')

ORDER BY
 language ASC;

 -- Which countries have the highest proportion of official language speakers? The lowest?

-- returns the hightest proportion of countries with an official language
 SELECT
c.name,
cl.isofficial,
cl.percentage,
cl.countrycode


FROM  country c JOIN countrylanguage cl ON (c.code = cl.countrycode)

WHERE 	cl.isofficial = 't'
GROUP BY name, percentage, countrycode, isofficial
ORDER BY percentage DESC

-- - returns the lowest proportion of countries with an official language

SELECT
c.name,
cl.isofficial,
cl.percentage,
cl.countrycode


FROM  country c JOIN countrylanguage cl ON (c.code = cl.countrycode)

WHERE 	cl.isofficial = 't'
GROUP BY name, percentage, countrycode, isofficial
ORDER BY percentage ASC


-- What is the most spoken language in the world?

-- used to find most spoken language (English)

SELECT
DISTINCT
cl.language,
COUNT(language) AS language_count



FROM  country c JOIN countrylanguage cl ON (c.code = cl.countrycode)


GROUP BY language
ORDER BY language_count DESC


-- CITIES
-- What is the population of the United States? What is the city population of the United States?

-- this show us the population of the United States
SELECT
name,
population


FROM  country

WHERE name = 'United States'
ORDER BY name ASC

-- this gives us the population sum of all the cities in the USA

WITH
	country_code AS
	(SELECT
		population,
		countrycode
	FROM city
	WHERE countrycode = 'USA')

SELECT
sum(country_code.population) AS total_pop


FROM country_code


-- What is the population of the India? What is the city population of the India?

-- gives us the total population of India

SELECT
name,
population


FROM  country

WHERE name = 'India'
ORDER BY name ASC

-- gives us the total population of the cities in India

WITH
	country_code AS
	(SELECT
		population,
		countrycode
	FROM city
	WHERE countrycode = 'IND')

SELECT
sum(country_code.population) AS total_pop


FROM country_code


-- Which countries have no cities? (7 not really contries...)

-- finds the countries with no cities availiable, the LEFT OUTER JOIN gives us the country even though it does not give us text in the ct.name field

SELECT
c.name,
ct.name

FROM  country c LEFT OUTER JOIN city ct ON (c.code = ct.countrycode)


ORDER BY ct.name DESC


-- LANGUAGES AND CITIES

-- What is the total population of cities where English is the offical language? Spanish?
