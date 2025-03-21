SELECT title, name
FROM movie JOIN casting ON (movieid = movie.id AND ord = 1)
JOIN actor ON (actorid = actor.id)
WHERE movie.id IN (SELECT movieid FROM casting WHERE actorid IN (SELECT id FROM actor WHERE name = 'Julie Andrews'))