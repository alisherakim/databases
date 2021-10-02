SELECT * FROM course WHERE credits > 3;
SELECT * FROM classroom WHERE building = 'Watson' OR building = 'Packard';
SELECT * FROM course WHERE dept_name = 'Comp.Sci.';
SELECT * FROM section WHERE semester = 'Fall';
SELECT * FROM `student` WHERE tot_cred >45 AND tot_cred<90;
SELECT * FROM student WHERE name REGEXP '[aeiou]$';
SELECT * FROM prereq WHERE prereq_id = 'CS-101';

SELECT dept_name, AVG (salary) FROM instructor GROUP BY dept_name ORDER BY AVG(salary);--a
SELECT building, count(*) c FROM section GROUP BY course_id ORDER BY c DESC LIMIT 1;--b
SELECT building, count(*) c FROM section GROUP BY course_id ORDER BY c ASC LIMIT 1;--c
SELECT ID, count(*) c FROM (SELECT * FROM takes WHERE course_id REGEXP '^[C]') c GROUP BY ID ORDER BY c DESC LIMIT 1;--d
SELECT * FROM instructor WHERE dept_name = 'Biology' OR dept_name = 'Philosophy' OR dept_name = 'Music';--e
SELECT DISTINCT id FROM teaches WHERE year = 2018 AND id NOT IN (SELECT id FROM teaches WHERE year = 2017);--f

SELECT distinct name from student as s, takes as t WHERE dept_name = 'Comp. Sci.' and (t.id = s.id and grade LIKE 'A%') ORDER BY name; --a
SELECT distinct name FROM takes, advisor, instructor WHERE NOT grade LIKE 'A%' and takes.id = advisor.s_id and advisor.i_id = instructor.id; --b

