SELECT world.name, ROUND(100000*confirmed/population,2) AS populationInfected,
RANK() OVER (ORDER BY populationInfected ASC) rank
FROM covid JOIN world ON covid.name=world.name
WHERE whn = '2020-04-20' AND population >= 10000000
ORDER BY population DESC
