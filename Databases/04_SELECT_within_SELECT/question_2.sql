SELECT name 
FROM world 
WHERE continent = 'Europe' AND GDP/population > 
(SELECT GDP/population FROM world WHERE name = 'United Kingdom');