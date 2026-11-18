create database clg;

use clg;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    name       VARCHAR(50) NOT NULL,
    city       VARCHAR(50)
);
 
INSERT INTO Student (student_id, name, city) VALUES
(1, 'Asha',  'Pune'),
(2, 'Ravi',  'Mumbai'),
(3, 'Meera', 'Pune'),
(4, 'Kiran', 'Nagpur'),
(5, 'Sana',  'Mumbai'),
(6, 'Dev',   'Pune');
 

CREATE TABLE Course (
    course_id       VARCHAR(5) PRIMARY KEY,
    course_name     VARCHAR(50) NOT NULL,
    duration_months INT,
    total_fee       INT
);
 
INSERT INTO Course (course_id, course_name, duration_months, total_fee) VALUES
('C1', 'SQL',      2, 15000),
('C2', 'Excel',    1,  8000),
('C3', 'Python',   3, 25000),
('C4', 'Power BI', 2, 18000);
 

CREATE TABLE Enrollment (
    enroll_id   VARCHAR(5) PRIMARY KEY,
    student_id  INT        NOT NULL,
    course_id   VARCHAR(5) NOT NULL,
    enroll_date DATE,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id)  REFERENCES Course(course_id)
);
 
INSERT INTO Enrollment (enroll_id, student_id, course_id, enroll_date) VALUES
('E1', 1, 'C1', '2026-01-10'),
('E2', 1, 'C2', '2026-02-05'),
('E3', 2, 'C1', '2026-01-15'),
('E4', 3, 'C3', '2026-02-01'),
('E5', 3, 'C1', '2026-02-10'),
('E6', 4, 'C2', '2026-03-01'),
('E7', 5, 'C3', '2026-03-05'),
('E8', 2, 'C3', '2026-03-12');
 

CREATE TABLE Fee (
    fee_id       VARCHAR(5) PRIMARY KEY,
    enroll_id    VARCHAR(5) NOT NULL,
    amount_paid  INT,
    payment_date DATE,
    mode         VARCHAR(10),
    FOREIGN KEY (enroll_id) REFERENCES Enrollment(enroll_id)
);
 
INSERT INTO Fee (fee_id, enroll_id, amount_paid, payment_date, mode) VALUES
('F1', 'E1', 15000, '2026-01-10', 'UPI'),
('F2', 'E2',  4000, '2026-02-05', 'Cash'),
('F3', 'E2',  4000, '2026-02-20', 'UPI'),
('F4', 'E3', 10000, '2026-01-15', 'Card'),
('F5', 'E4', 25000, '2026-02-01', 'UPI'),
('F6', 'E5', 15000, '2026-02-10', 'Cash'),
('F7', 'E6',  8000, '2026-03-01', 'Card'),
('F8', 'E7', 12000, '2026-03-05', 'UPI');
 

SELECT * FROM Student;
SELECT * FROM Course;
SELECT * FROM Enrollment;
SELECT * FROM Fee;


-- 4. Show the enroll_id and amount_paid for every payment.
select e.enroll_id , f.amount_paid from enrollment e
inner join fee f 
on e.enroll_id = f.enroll_id;

-- 5. Show the student name and amount_paid for every payment.
select s.name, f.amount_paid from student s
inner join enrollment e
on s.student_id = e.student_id
inner join fee f
on e.enroll_id = f.enroll_id; 

-- 6. Show the course_name and total amount_paid for every payment.
select c.course_name , f.amount_paid from course c
inner join enrollment e 
on c.course_id = e.course_id
inner join fee f
on e.enroll_id = f.enroll_id;

-- 7. Show the student name, course_name and amount_paid for every payment (all four tables).
select s.name, c.course_name,f.amount_paid from student s
inner join enrollment e
on s.student_id = e.student_id
inner join fee f
on e.enroll_id = f.enroll_id
inner join course c
on e.course_id = c.course_id;

-- 8. Show all students with the courses they enrolled in, including students who have not enrolled anywhere.
select s.name,c.course_name from student s
left join enrollment e
on e.student_id = s.student_id
left join course c
on e.course_id = c.course_id;

-- 9. Show all courses with the names of students enrolled, including courses that have no students.
select c.course_name, s.name from course c
left join enrollment e
on e.course_id = c.course_id
left join student s
on s.student_id = e.student_id;

-- 10. Show every enrollment with its payments, including enrollments that have no payment yet.
select e.enroll_id,f.amount_paid from enrollment e
left join fee f
on e.enroll_id = f.enroll_id;

-- 11. Show the names of students from Pune who enrolled in the SQL course.

-- 12. Show the total amount paid by each student, highest first.
-- 13. Show the number of students enrolled in each course, with the most popular course first.
select course_name ,count(*) from student s
inner join enrollment e
on e.student_id = s.student_id
inner join course c
on e.course_id = c.course_id
group by  course_name
order by count(*) desc;

-- 14. Show the names of students who enrolled in more than one course.
select s.name, count(*) from student s
inner join enrollment e
on e.student_id = s.student_id
inner join course c
on e.course_id = c.course_id
group by s.name
having count(*) > 1;

-- 15. Show the total fee collected per course, but only for courses where the total is above 20000.
select course_name, sum(amount_paid) from course c
inner join enrollment e
on c.course_id = e.course_id
inner join fee f
on e.enroll_id = f.enroll_id
group by course_name;

-- 16. Show the total amount collected for each payment mode, from highest to lowest.
-- 17. Show the courses that have no enrollment at all.
-- 18. For each enrollment, show the student name, course_name and balance (course total_fee minus total paid).
--  Keep only enrollments with a balance above 0, largest balance first. Include enrollments with no payment.
-- 19. Show the total fee collected per city, only for cities where the total is above 15000, highest first.
-- 20. Show the top 3 students by total amount paid.