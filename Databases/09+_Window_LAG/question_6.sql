SELECT 
name,
confirmed,
RANK() OVER (ORDER BY confirmed DESC) rc,
deaths,
RANK() OVER (ORDER BY deaths DESC) dc
FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC
