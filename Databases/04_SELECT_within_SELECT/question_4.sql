SELECT name, population 
FROM world WHERE population > 
(SELECT population FROM world WHERE name = 'United Kingdom') 
AND population < 
(SELECT population FROM world WHERE name = 'Germany')