insert into sy_mp.department 
    values(1,'Computer Engineering'),
          (2,'Information Technology'),
          (3,'Mechanical Engineering'),
          (4,'Electronics & Telecommunication Engineering'),
          (5,'Computer & Communication Engineering'),
          (6,'Artificial Intelligence and Data Science'),
          (7,'Electronics & Computer Engineering'),
          (8,'Robotics & Artificial Intelligence'),
		  (9,'Science and Humanities Department');
	
insert into sy_mp.subject 
    values(1,'Applied Mathematics I',1,null,9),
          (2,'Engineering Chemistry',1,null,9),
          (3,'Engineering Drawing',1,null,9),
          (4,'Elements of Electrical and Electronics Engineering',1,null,9),
          (5,'Programming in C',1,null,9),
          (6,'Applied Mathematics II',1,null,9),
          (7,'Engineering Physics',1,null,9),
          (8,'Engineering Mechanics',1,null,9),
          (9,'Python Programming',1,null,9),
          (10,'Environment and Technology',1,null,9),
          (11,'Engineering Exploration',1,null,9),
          (12,'Biology for Engineers',1,null,9),

        --   SY COMP :
          (13,'Integral Transform and Vector Calculus',2,3,1),
          (14,'Data Structures',2,3,1),
          (15,'Computer Organization & Architecture',2,3,1),
          (16,'Object Oriented Programming Methodology',2,3,1),
          (17,'Discrete Mathematics',2,3,1),
          (18,'Digital Design Laboratorys',2,3,1), 
          (19,'Probability, Statistics and Optimization Techniques',2,4,1),
          (20,'Analysis of Algorithms',2,4,1),
          (21,'Relational Database Management Systems',2,4,1),
          (22,'Theory of Automata with Compiler Design',2,4,1),
          (23,'Web Programming Laboratory',2,4,1),
          (24,'Mini Project',2,4,1);


-- testing : 

select * from sy_mp.subject where corresponding_year = 1;
select * from sy_mp.student

select * from sy_mp.department

insert into sy_mp.student values(10,208,'Aditya','aditya.ved@somaiya.edu','my_pass',5,1);

INSERT INTO sy_mp.textbook (fk_subject_id,textbook_id, textbook_name, textbook_avg_rating, textbook_no_of_ratings, textbook_author, textbook_edition, publication_year,publisher,textbook_link)
    VALUES (21,1, 'Intro to DBMS Korth', 5, 10 , 'Korth', 7, 2022 , 'McGraww Hill','link1'),
		   (22,2,'Intro to TACD',4.5,10,'GK Gupta',4,2021,'Pearson','link2'),
		   (22,3,'Intermediate TACD',7,10,'GK Gupta',4,2021,'Penguin','link3'),
		   (14,4,'Data Structures using C',7,10,'Reema Thareja',4,2021,'Penguin','link4');

select * from sy_mp.textbook
select * from sy_mp.textbook where fk_subject_id =22