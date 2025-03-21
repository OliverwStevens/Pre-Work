SELECT mdate, 
       team1, 
       SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1, 
       team2, 
       SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2
FROM game
LEFT JOIN goal ON matchid = id
GROUP BY mdate, matchid, team1, team2
ORDER BY mdate, matchid, team1, team2;
