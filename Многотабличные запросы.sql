1.
Select student.name,student.surname, hobby.name
From student, hobby, student_hobby
Where student.id = student_hobby.student_id and hobby.id = student_hobby.hobby_id
2.
select student.name,student.surname,
	   CASE 
		when student_hobby.finished_at is null then CURRENT_TIMESTAMP
		else student_hobby.finished_at
		end :: date - student_hobby.started_at as time 
from student

inner join student_hobby on student.id = student_hobby.student_id
order by time DESC
limit 1
3.
Select student.name, student.surname,student.id,student.birthday,
student.score,sum(hobby.risk) as sum_risk
From student, hobby,student_hobby
Where student.id = student_hobby.student_id 
and hobby.id = student_hobby.hobby_id and score >= (
	select AVG(score)
	from student
)  
group by student.id
having sum(hobby.risk) > 9
4.
select student.surname, student.name,student.id,student.birthday,
hobby.name,student_hobby.finished_at - student_hobby.started_at as time
from student,hobby,student_hobby
where student.id = student_hobby.student_id and hobby.id = student_hobby.hobby_id 
and student_hobby.finished_at is not null
5.
select student.surname, student.name,student.id,extract (year from age(CURRENT_TIMESTAMP, student.birthday)) as Ages
from student,hobby,student_hobby
where  student.id = student_hobby.student_id and hobby.id = student_hobby.hobby_id
and extract (year from age(CURRENT_TIMESTAMP, student.birthday)) = 20
and student_hobby.finished_at is NULL
group by student.id
6.
select AVG(student.score), student.n_group
from student
group by n_group
7.
select hobby.name,hobby.risk, 12 * extract(year from age(CURRENT_TIMESTAMP, student_hobby.started_at))+ extract(month from age(CURRENT_TIMESTAMP, student_hobby.started_at)) as time,student.id
from student_hobby
inner join student on student_hobby.student_id = student.id
inner join hobby on student_hobby.hobby_id = hobby.id
order by time DESC
limit 1
8.
select hobby.name, student.score, student.name
from student, hobby, student_hobby
where student.id = student_hobby.student_id and hobby.id = student_hobby.hobby_id and score =
(select Max(score)
from student) 
9.
select hobby.name, student.score, student.name, student.n_group
from student, hobby, student_hobby
where student.id = student_hobby.student_id and hobby.id = student_hobby.hobby_id and score >=3 and score < 3.5
and CAST(n_group AS varchar) LIKE '2%'
10.
select substr(student.n_group::varchar,1,1),
count(Distinct(student_hobby.student_id))as one,
count(student_hobby.student_id) as two

from student_hobby
inner join student on student_hobby.student_id = student.id
inner join hobby on student_hobby.hobby_id = hobby.id
 
group by substr(student.n_group::varchar,1,1)
having  (count(student_hobby.student_id) - count(Distinct(student_hobby.student_id))) / count(student_hobby.student_id) > 0.5


11.
select student.n_group,
count(student.id) as kolvo,
Fours.kolvofour
from student,
(
	select n_group, count(student.id) as kolvofour
	from student
	where score > 4
	group by n_group
) Fours
where Fours.n_group = student.n_group 
group by student.n_group, Fours.kolvofour
having kolvofour/count(student.id) > 0.6



select count(student.n_group)
from student_hobby
inner join student on student_hobby.student_id = student.id
inner join hobby on student_hobby.hobby_id = hobby.id
group by student.n_group
12.
select count(hobby.id),substr(student.n_group::varchar,1,1) as course
from student_hobby
inner join student on student_hobby.student_id = student.id
inner join hobby on student_hobby.hobby_id = hobby.id
where student_hobby.finished_at is null
group by substr(student.n_group::varchar,1,1)
13.
select DISTINCT (student.id), student.name, student.surname,
student.birthday,substr(student.n_group::varchar,1,1) as course 
from student_hobby
inner join student on student_hobby.student_id = student.id
inner join hobby on student_hobby.hobby_id = hobby.id
where student.score = 5 and student_hobby.started_at is null
order by substr(student.n_group::varchar,1,1) ASC,
student.birthday DESC
14.

15.
select hobby.name, count(hobby.name) as kolvo
from student_hobby
inner join student on student_hobby.student_id = student.id
inner join hobby on student_hobby.hobby_id = hobby.id
group by hobby.name
16. 
select hobby.id 
from student_hobby
inner join student on student_hobby.student_id = student.id
inner join hobby on student_hobby.hobby_id = hobby.id
group by hobby.id
order by count(hobby.id) DESC
limit 1

17.
select *
from student_hobby
inner join student on student_hobby.student_id = student.id
inner join hobby on student_hobby.hobby_id = hobby.id
where hobby.id = (
	select hobby.id 
	from student_hobby
	inner join student on student_hobby.student_id = student.id
	inner join hobby on student_hobby.hobby_id = hobby.id
	group by hobby.id
	order by count(hobby.id) DESC
	limit 1
)

18.
select hobby.id
from  hobby
where risk >= 9
ORDER BY risk DESC
limit 3

19.
select tbl.name, tbl.surname, max(time) as Time
from (select distinct student.name,student.surname,hobby.name as Hobby,
CASE 
	when student_hobby.finished_at is null then CURRENT_TIMESTAMP
	else student_hobby.finished_at
	end :: date - student_hobby.started_at as time 
from student, hobby, student_hobby 
where student.id = student_hobby.student_id and hobby.id = student_hobby.hobby_id and student_hobby.finished_at is null) tbl
group by name,surname
ORDER BY Time DESC
limit 10
20.

21.
CREATE VIEW Student_score_desc
as
	select id,name,surname,score
	from student
	Order by score DESC


select * 
from Student_score_desc

22.
CREATE VIEW PopularHobbyCourse
as
	select DISTINCT ON (1) substr(student.n_group::varchar,1,1),count(hobby.name), hobby.name
	from student_hobby
	inner join student on student_hobby.student_id = student.id
	inner join hobby on student_hobby.hobby_id = hobby.id

	group by substr(student.n_group::varchar,1,1),hobby.name
	order by substr DESC, count DESC


select * 
from PopularHobbyCourse
23.
CREATE VIEW PopularHobbyCourse2Risk
as
	select substr(student.n_group::varchar,1,1),count(hobby.name),hobby.risk, hobby.name
	from student_hobby
	inner join student on student_hobby.student_id = student.id
	inner join hobby on student_hobby.hobby_id = hobby.id
	
	group by substr(student.n_group::varchar,1,1),hobby.name,hobby.risk
	having substr(student.n_group::varchar,1,1) = '2'
	order by risk DESC, count DESC
	limit 1
	

select * 
from PopularHobbyCourse2Risk
24.
CREATE VIEW TablStudOtl
as
	select substr(n_group::varchar,1,1),count(id),count(id) filter (where score = 5) five
	from student
	group by substr(student.n_group::varchar,1,1)

select * 
from TablStudOtl
25.
CREATE VIEW PopHobby
as
	select count(hobby.name),hobby.name
	from student_hobby
	inner join student on student_hobby.student_id = student.id
	inner join hobby on student_hobby.hobby_id = hobby.id
	group by hobby.name
	order by count DESC
	limit 1

select * 
from PopHobby
26.

27.

28.

29.

30.

31.

32.

33.

34.

35.

36.

37.

38.

39.

40.

41.

42.??????????????
select Distinct(ROUND(student.score)),student.n_group, count(student.id) 
from student
pivot
(
	
)
piv
group by ROUND(student.score), student.n_group
order by ROUND(student.score) ASC