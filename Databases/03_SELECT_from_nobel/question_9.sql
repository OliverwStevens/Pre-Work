SELECT yr, subject, winner 
FROM nobel 
WHERE yr = 1980 AND subject NOT IN ('chemistry', 'medicine')