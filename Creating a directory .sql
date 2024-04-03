
create table student (
	id SERIAL, 
	name VARCHAR(128) unique, 
	primary KEY(id) 
); 

create table course (
	id SERIAL, 
	title VARCHAR(128) unique, 
	primary key (id)
); 


create table roster (
	id SERIAL,
	student_id INTEGER references student(id) on delete cascade,
	course_id INTEGER references course(id) on delete cascade, 
	role INTEGER, 
	unique (student_id, course_id), 
	primary KEY(id) 
); 

-- Insert data into course table
INSERT INTO course(title) VALUES 
('si106'), -- Note the comma separating each value
('si110'),
('si206');

-- Insert data into student table
INSERT INTO student(name) VALUES
('Ohran'), ('Eroni'), ('Kelam'), ('Shreya'), 
('Valeria'), ('Favour'), ('Aryankhan'),
('Brajan'), ('Minah'), ('Wallace'), ('Kirsteen'),
('Danyal'), ('Gabby'), ('Korben'), ('Marianne');



-- Insert data into the roster table with role encoding
INSERT INTO roster (student_id, course_id, role)
VALUES
-- si106
((SELECT id FROM student WHERE name = 'Ohran'), (SELECT id FROM course WHERE title = 'si106'), 1), -- Instructor
((SELECT id FROM student WHERE name = 'Eroni'), (SELECT id FROM course WHERE title = 'si106'), 0), -- Learner
((SELECT id FROM student WHERE name = 'Kelam'), (SELECT id FROM course WHERE title = 'si106'), 0), -- Learner
((SELECT id FROM student WHERE name = 'Shreya'), (SELECT id FROM course WHERE title = 'si106'), 0), -- Learner
((SELECT id FROM student WHERE name = 'Valeria'), (SELECT id FROM course WHERE title = 'si106'), 0), -- Learner
-- si110
((SELECT id FROM student WHERE name = 'Favour'), (SELECT id FROM course WHERE title = 'si110'), 1), -- Instructor
((SELECT id FROM student WHERE name = 'Aryankhan'), (SELECT id FROM course WHERE title = 'si110'), 0), -- Learner
((SELECT id FROM student WHERE name = 'Brajan'), (SELECT id FROM course WHERE title = 'si110'), 0), -- Learner
((SELECT id FROM student WHERE name = 'Minah'), (SELECT id FROM course WHERE title = 'si110'), 0), -- Learner
((SELECT id FROM student WHERE name = 'Wallace'), (SELECT id FROM course WHERE title = 'si110'), 0), -- Learner
-- si206
((SELECT id FROM student WHERE name = 'Kirsteen'), (SELECT id FROM course WHERE title = 'si206'), 1), -- Instructor
((SELECT id FROM student WHERE name = 'Danyal'), (SELECT id FROM course WHERE title = 'si206'), 0), -- Learner
((SELECT id FROM student WHERE name = 'Gabby'), (SELECT id FROM course WHERE title = 'si206'), 0), -- Learner
((SELECT id FROM student WHERE name = 'Korben'), (SELECT id FROM course WHERE title = 'si206'), 0), -- Learner
((SELECT id FROM student WHERE name = 'Marianne'), (SELECT id FROM course WHERE title = 'si206'), 0); -- Learner


SELECT student.name, course.title, roster.role
    FROM student 
    JOIN roster ON student.id = roster.student_id
    JOIN course ON roster.course_id = course.id
    ORDER BY course.title, roster.role DESC, student.name;
