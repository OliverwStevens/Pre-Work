SELECT DISTINCT actor.name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE movie.id IN (
    SELECT casting.movieid
    FROM casting
    JOIN actor ON casting.actorid = actor.id
    WHERE actor.name = 'Art Garfunkel'
)
AND actor.name != 'Art Garfunkel';