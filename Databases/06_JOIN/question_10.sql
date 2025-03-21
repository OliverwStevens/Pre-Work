SELECT stadium, COUNT(gtime)
FROM game JOIN goal ON (id = matchid)
GROUP BY stadium