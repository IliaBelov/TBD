1.
select n_group,
	COUNT(n_group) AS st_count
FROM student
GROUP BY n_group
2.
SELECT n_group,MAX(score)
From student
GROUP BY n_group
3.
SELECT  surname,
      COUNT (surname) AS st_name
FROM student
group by surname
4.
SELECT COUNT(birthday), to_char(birthday,'YYYY')
from student
group by to_char(birthday,'YYYY')

5.
SELECT n_group,AVG(score)
From student
GROUP BY n_group
6.
SELECT MAX(score)
From student
Where n_group >= 2000 and n_group <3000;
7.
SELECT n_group, AVG(score)
from student
where (select AVG(score)
	  from student
	  where n_group = n_group ) >3.5
group by n_group
ORDER BY AVG(score) ASC 

8.
select n_group,
	COUNT(n_group) AS st_count,
	Max(score) as MAX_score,
	AVG(score) as AVG_score,
	Min(score) as MIN_score
FROM student
GROUP BY n_group
9.
SELECT n_group, name,max(score) 
FROM student
WHERE score = (SELECT max(score) 
               FROM student) and n_group = 2281
Group by n_group, name

10.
SELECT n_group, name,max(score) 
FROM student
WHERE score = (SELECT max(score) 
               FROM student) 
Group by n_group, name

