SELECT continent, 
       (SELECT name FROM world w2 WHERE w2.continent = w1.continent ORDER BY name LIMIT 1) AS first_country
FROM world w1
GROUP BY continent;
