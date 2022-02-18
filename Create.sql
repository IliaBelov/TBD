
Create TABLE student(
id Serial Primary Key,
name varchar(255) NOT NULL,
surname varchar(255) NOT NULL,
address varchar(3000),
n_group int CHECK (n_group >= 1000 and n_group <= 9999),
score real CHECK (score >= 2 and score <= 5)
);

-- Таблица с Хобби

Create TABLE hobby(
id Serial Primary Key,
name varchar(255)  NOT NULL,
risk int CHECK (risk >=0 and risk <= 10)
); 

-- Таблица Студент_Хобби

Create TABLE student_hobby(
student_id int REFERENCES student(id),
hobby_id int REFERENCES hobby(id),
	-- задаём первичный ключ являющийся пересечением двух id композиционный ключ
CONSTRAINT student_hobby_pk PRIMARY KEY(student_id, hobby_id)

/*started_at DATE NOT NULL,
finished_at DATE*/
);
