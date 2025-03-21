SELECT title, COUNT(actor.id)
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(actor.id) DESC, title;