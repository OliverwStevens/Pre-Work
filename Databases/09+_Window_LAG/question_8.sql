SELECT tw.name,
DATE_FORMAT(tw.whn, '%Y-%m-%d') AS peak_date,
(tw.confirmed - lw.confirmed) AS peak_cases
FROM covid tw
JOIN covid lw ON lw.name = tw.name
AND lw.whn = DATE_ADD(tw.whn, INTERVAL -1 DAY)
WHERE 
tw.confirmed - lw.confirmed >= 1000
AND (tw.confirmed - lw.confirmed) = (
SELECT MAX(tw2.confirmed - lw2.confirmed)
FROM covid tw2
JOIN covid lw2 ON lw2.name = tw2.name
AND lw2.whn = DATE_ADD(tw2.whn, INTERVAL -1 DAY)
WHERE tw2.name = tw.name)
ORDER BY peak_date