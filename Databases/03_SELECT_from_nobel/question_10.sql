SELECT yr, subject, winner 
FROM nobel 
WHERE subject = 'medicine' AND yr < 1910 OR subject = 'literature' AND yr >= 2004