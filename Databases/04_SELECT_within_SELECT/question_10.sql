SELECT name, continent
FROM world w1
WHERE NOT EXISTS (
    SELECT 1
    FROM world w2
    WHERE w1.continent = w2.continent
      AND w1.name != w2.name
      AND w1.population <= 3 * w2.population
)