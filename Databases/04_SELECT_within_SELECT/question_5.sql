SELECT name, 
       CONCAT(CAST(ROUND(100*population/(SELECT population FROM world WHERE name = 'Germany'),0) as int), '%')
FROM world
WHERE continent = 'Europe';
