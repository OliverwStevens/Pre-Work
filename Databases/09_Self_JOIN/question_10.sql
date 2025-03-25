SELECT DISTINCT 
first.num AS first_bus, 
first.company AS first_company, 
transfer.name AS transfer_stop, 
second.num AS second_bus, 
second.company AS second_company
FROM 
route AS first
JOIN 
route AS first_full ON (first.company = first_full.company AND first.num = first_full.num)
JOIN 
stops AS start ON first.stop = start.id
JOIN 
stops AS transfer ON first_full.stop = transfer.id
JOIN 
route AS second ON transfer.id = second.stop
JOIN 
route AS second_full ON (second.company = second_full.company AND second.num = second_full.num)
JOIN 
stops AS end ON second_full.stop = end.id
WHERE start.name = 'Craiglockhart'
AND end.name = 'Lochend'
AND transfer.id IN (
SELECT r1.stop
FROM route r1
WHERE r1.company = first.company AND r1.num = first.num
INTERSECT
SELECT r2.stop
FROM route r2
WHERE r2.company = second.company AND r2.num = second.num)
ORDER BY first.num, transfer.name, second.num