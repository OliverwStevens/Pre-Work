SELECT dept.name, COUNT(teacher.name)
FROM teacher RIGHT JOIN dept
ON (teacher.dept = dept.id)
GROUP BY dept.name