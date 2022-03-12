1.
SELECT surname,name,score
FROM student
WHERE score BETWEEN 4 and 4.5;

2.
SELECT *
From student
WHERE CAST (n_group as varchar) LIKE '2281';
3.
SELECT * FROM student ORDER BY n_group DESC,name ASC
4.
SELECT * FROM student WHERE score >= 4 ORDER BY score DESC
5.
SELECT name, risk
FROM hobby
WHERE name = 'football' or name = 'hockey'

6.
select student_id, hobby_id,started_at,finished_at
From student_hobby
where started_at >='2014-01-01' and started_at<='2016-01-01' and finished_at is NULL

7.
SELECT name, score
FROM student
Where  score>=4.5
ORDER BY score DESC

8.
SELECT name,score
FROM student
WHERE score =(
	SELECT MAX(score)
	from student
	)
limit 5


9.
SELECT name, risk,
	CASE 
 		WHEN risk >= 8 THEN 'Очень высокий'
 		WHEN risk >=6 AND risk  <8 THEN 'Высокий'
 		WHEN risk >=4 AND risk <6 THEN 'Средний'
 		WHEN risk >=2 AND risk <4 THEN 'Низкий'
 		WHEN risk < 2 THEN 'Очень низкий'
 		ELSE '---'
	END riskName
from hobby
10.
SELECT name
FROM hobby

Where (risk) IN
(
		SELECT MAX(risk)
		FROM hobby
)
limit 3
