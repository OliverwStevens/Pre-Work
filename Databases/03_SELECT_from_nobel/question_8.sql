SELECT yr, subject, winner 
FROM nobel 
WHERE yr = 1980 AND subject = 'physics' OR yr = 1984 AND subject = 'chemistry'