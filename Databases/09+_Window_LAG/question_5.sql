
SELECT tw.name, DATE_FORMAT(tw.whn, '%Y-%m-%d') AS date, tw.confirmed - lw.confirmed AS confirmed_diff
FROM covid tw
LEFT JOIN 
covid lw 
ON DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
AND tw.name = lw.name
WHERE 
tw.name = 'Italy' 
AND WEEKDAY(tw.whn) = 0
ORDER BY tw.whn;
