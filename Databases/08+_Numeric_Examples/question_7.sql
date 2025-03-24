SELECT institution, 
ROUND(SUM(score * response) / SUM(response), 0)
FROM nss
WHERE question = 'Q22'
AND institution LIKE '%Manchester%'
GROUP BY institution
ORDER BY institution