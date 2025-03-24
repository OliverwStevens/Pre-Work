SELECT constituency, party
FROM ge
WHERE (constituency, votes) IN (
SELECT constituency, MAX(votes)
FROM ge
WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
AND yr = 2017
GROUP BY constituency
)
ORDER BY constituency
