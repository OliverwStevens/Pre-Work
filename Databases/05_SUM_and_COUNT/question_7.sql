SELECT continent, COUNT(name) 
FROM world 
WHERE population >= 10000000 
GROUP BY continent