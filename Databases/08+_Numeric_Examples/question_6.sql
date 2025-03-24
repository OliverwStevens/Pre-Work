SELECT subject, ROUND(SUM(response*A_STRONGLY_AGREE)/SUM(response),0)
FROM nss
WHERE question='Q22'
AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject