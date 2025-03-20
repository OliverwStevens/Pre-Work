SELECT name, REPLACE(capital, name, '')
FROM world
WHERE capital LIKE concat(name, '_%')