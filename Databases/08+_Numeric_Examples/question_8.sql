SELECT institution, 
SUM(sample), 
SUM(CASE WHEN subject = '(8) Computer Science' THEN sample ELSE 0 END)
FROM nss
WHERE question = 'Q01'
AND institution LIKE '%Manchester%'
GROUP BY institution
ORDER BY institution