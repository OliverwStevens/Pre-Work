SELECT name
FROM actor JOIN casting ON (id = actorid)
WHERE movieid = (SELECT id
FROM movie
WHERE title = 'Alien')