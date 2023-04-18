-- insert into sy_mp.department 
--     values(1,'Computer Engineering'),
--           (2,'Information Technology'),
--           (3,'Mechanical Engineering'),
--           (4,'Electronics & Telecommunication Engineering'),
--           (5,'Computer & Communication Engineering'),
--           (6,'Artificial Intelligence and Data Science'),
--           (7,'Electronics & Computer Engineering'),
--           (8,'Robotics & Artificial Intelligence'),
-- 		  (9,'Science and Humanities Department');

insert into sy_mp.department 
    values(1,'COMPS'),
          (2,'IT'),
          (3,'MECH'),
          (4,'EXTC'),
          (5,'EXCP');
		
truncate sy_mp.subject
		
insert into sy_mp.subject 
    values(1,'Applied Mathematics I','FY',null,5),
          (2,'Engineering Chemistry','FY',null,5),
          (3,'Engineering Drawing','FY',null,5),
          (4,'Elements of Electrical and Electronics Engineering','FY',null,5),
          (5,'Programming in C','FY',null,5),
          (6,'Applied Mathematics II','FY',null,5),
          (7,'Engineering Physics','FY',null,5),
          (8,'Engineering Mechanics','FY',null,5),
          (9,'Python Programming','FY',null,6),
          (10,'Environment and Technology','FY',null,5),
          (11,'Engineering Exploration','FY',null,5),
          (12,'Biology for Engineers','FY',null,4),

        --   SY COMP :
          (13,'Integral Transform and Vector Calculus','SY','COMPS',5),
          (14,'Data Structures','SY','COMPS',6),
          (15,'Computer Organization & Architecture','SY','COMPS',5),
          (16,'Object Oriented Programming Methodology','SY','COMPS',4),
          (17,'Discrete Mathematics','SY','COMPS',6),
          (18,'Digital Design Laboratorys','SY','COMPS',5),
          (19,'Probability, Statistics and Optimization Techniques','SY','COMPS',4),
          (20,'Analysis of Algorithms','SY','COMPS',4),
          (21,'Relational Database Management Systems','SY','COMPS',6),
          (22,'Theory of Automata with Compiler Design','SY','COMPS',5),
          (23,'Web Programming Laboratory','SY','COMPS',4),
          (24,'Mini Project','SY','COMPS',5);


-- testing : 

select no_of_modules from sy_mp.subject where subject_name = 'Data Structures'

select subject_name from sy_mp.subject where corresponding_year='FY';
select * from sy_mp.student

select * from sy_mp.department

insert into sy_mp.student values(10,208,'Aditya','aditya.ved@somaiya.edu','my_pass',5,1);

-- INSERT INTO sy_mp.textbook (fk_subject_id,textbook_id, textbook_name, textbook_avg_rating, textbook_no_of_ratings, textbook_author, textbook_edition, publication_year,publisher,textbook_link)
--     VALUES (21,1, 'Intro to DBMS Korth', 5, 10 , 'Korth', 7, 2022 , 'McGraww Hill','link1'),
-- 		   (22,2,'Intro to TACD',4.5,10,'GK Gupta',4,2021,'Pearson','link2'),
-- 		   (22,3,'Intermediate TACD',7,10,'GK Gupta',4,2021,'Penguin','link3'),
-- 		   (14,4,'Data Structures using C',7,10,'Reema Thareja',4,2021,'Penguin','link4');


INSERT INTO sy_mp.textbook 
	VALUES('Data Structures','COMPS',1,'Data Structures using C','https://raw.githubusercontent.com/riti2409/Programming_with_C_and_Cplus-plus/main/Data%20Structures%20Using%20C%20Reema%20thareja.pdf'),
		  ('Applied Mathematics I',null,2,'Applied Mathematics GV Kumbhojkar Sem 1','https://www.pdfdrive.com/applied-mathematics-i-for-first-year-engineering-e158347771.html')

truncate sy_mp.textbook 

select textbook_name,textbook_link,fk_dept_name from sy_mp.textbook where fk_subject_name ='Data Structures' and fk_dept_name is 'COMPS';
select * from sy_mp.textbook 


INSERT INTO sy_mp.online_courses 
	VALUES('Data Structures','COMPS',1,'Code with Harry : DSA','https://www.codewithharry.com/videos/data-structures-and-algorithms-in-hindi-1/'),
		   ('Programming in C',null,2,'Bharatacharya C Programming','https://bharatacharya.graphy.com/courses/C-Programming-63c7a1e4e4b05998900b494e');


INSERT INTO sy_mp.online_courses 
	VALUES('Applied Mathematics I',null,3,'MIT Open Courseware Eigen Values and Eigen Vectors','https://ocw.mit.edu/courses/18-06-linear-algebra-spring-2010/resources/lecture-21-eigenvalues-and-eigenvectors/')
		   
select * from sy_mp.online_courses 

TRUNCATE sy_mp.online_courses



select * from sy_mp.textbook
select * from sy_mp.textbook where fk_subject_id =22



select * from sy_mp.kjsce_notes
INSERT INTO sy_mp.kjsce_notes values('Applied Mathematics I',null,'1','0.COMPLEX NUMBERS- REVIEW','./study_resource/kjsce_notes/FY/Applied Mathematics I/module1/0.COMPLEX NUMBERS- REVIEW.pdf',1)

INSERT INTO sy_mp.kjsce_notes values('Applied Mathematics I',null,'2','1.DE-MOIVRES THEOREM-1.pdf','./study_resource/kjsce_notes/FY/Applied Mathematics I/module1/1.DE-MOIVRES THEOREM-1.pdf',1)

INSERT INTO sy_mp.kjsce_notes values('Applied Mathematics I',null,'3','2.DE-MOIVRES THEOREM-2.pdf','./study_resource/kjsce_notes/FY/Applied Mathematics I/module1/2.DE-MOIVRES THEOREM-2.pdf',1)
-- INSERT INTO sy_mp.kjsce_notes values('Applied Mathematics I',null,'1','','',1)
-- INSERT INTO sy_mp.kjsce_notes values('Applied Mathematics I',null,'1','','',1)


INSERT INTO sy_mp.student_notes values('Applied Mathematics I',null,'1','Demoivre_compiled.pdf','./study_resource/student_notes/FY/Applied Mathematics I/module1/Demoivre_compiled.pdf',1)



