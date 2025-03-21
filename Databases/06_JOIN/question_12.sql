SELECT matchid, mdate, COUNT(gtime) AS goal_count
FROM game 
JOIN goal ON matchid = id
WHERE teamid = 'GER'
GROUP BY matchid, mdate;