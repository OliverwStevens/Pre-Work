SELECT subject, SUM(response*A_STRONGLY_AGREE/100)
FROM nss
WHERE question='Q22'
AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject