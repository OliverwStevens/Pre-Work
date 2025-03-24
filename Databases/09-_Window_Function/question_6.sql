SELECT party, COUNT(constituency)
FROM ge
WHERE constituency LIKE 'S%' 
AND yr = 2017
AND votes = (
SELECT MAX(votes)
FROM ge AS inner_ge
WHERE inner_ge.constituency = ge.constituency
AND inner_ge.yr = ge.yr)
GROUP BY party