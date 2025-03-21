SELECT player
FROM goal JOIN game ON (id = matchid)
WHERE stadium = 'National Stadium, Warsaw'