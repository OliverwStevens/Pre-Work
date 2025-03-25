SELECT id, name
FROM stops JOIN route ON id = stop
WHERE company = 'LRT' AND num = '4'