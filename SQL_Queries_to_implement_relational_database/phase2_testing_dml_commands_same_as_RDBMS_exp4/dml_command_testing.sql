-- refer to this file as the final relations ka structure are present here 

CREATE TABLE sy_mp.student(
    student_id int,
    student_name varchar(50),
    student_email varchar(50) unique,
    student_password varchar(50),
    student_current_sem int check(student_current_sem > 0 and student_current_sem < 9),
    PRIMARY KEY (student_id)
);

CREATE TABLE sy_mp.subject(
    subject_id int,
    subject_name varchar(100),
    corresponding_year char(2),
--     corresponding_sem int check(corresponding_sem > 0 and corresponding_sem < 9),
    fk_dept_name varchar(50),
	no_of_modules int,
    PRIMARY KEY (subject_id),
    FOREIGN KEY (fk_dept_name) references sy_mp.department (dept_name),
	UNIQUE (subject_name, fk_dept_name)
);

CREATE TABLE sy_mp.department(

	dept_id int,
	dept_name varchar(50) unique,
	PRIMARY KEY (dept_id)
);



CREATE TABLE sy_mp.textbook(
    -- text book always belongs to a particular subject
    fk_subject_name varchar(50),
	fk_dept_name varchar(50),
    textbook_id int,
    textbook_name varchar(50),
--     textbook_avg_rating real, -- refers to avg rating
--     textbook_no_of_ratings int,
--     textbook_author varchar(50),
--     textbook_edition varchar(50),
--     publication_year int,
--     publisher varchar(50),
    -- actualPdf BYTEA,
    textbook_link varchar(400),
    PRIMARY KEY (textbook_id),
    FOREIGN KEY (fk_subject_name,fk_dept_name) references sy_mp.subject(subject_name,fk_dept_name) ON DELETE SET NULL ON UPDATE CASCADE
-- 	FOREIGN KEY (fk_dept_name) references sy_mp.department(dept_name) ON DELETE SET NULL ON UPDATE CASCADE
);

-- since textbookReviews is a multi valued attribute , thus we need to 
-- create a seperate table for it

CREATE TABLE sy_mp.textbook_reviews(
    fk_textbook_id int,
    textbook_review varchar(300),
    PRIMARY KEY (fk_textbook_id,textbook_review),
    FOREIGN KEY (fk_textbook_id) references sy_mp.textbook(textbook_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE sy_mp.kjsce_notes(
--     fk_subject_id int,
	fk_subject_name varchar(50),
	fk_dept_name varchar(50),
    kjsce_note_id int,
    kjsce_note_name varchar(50),
	-- path_of_note varchar(200),
    -- actualNote BYTEA,
    kjsce_note_path varchar(200),
	module_number int,
    PRIMARY KEY (kjsce_note_id),
    FOREIGN KEY (fk_subject_name,fk_dept_name) references sy_mp.subject(subject_name,fk_dept_name) ON DELETE SET NULL ON UPDATE CASCADE

);

CREATE TABLE sy_mp.student_notes(
    fk_subject_id int,
    student_note_id int,
    student_note_name varchar(50),
	-- path_of_note varchar(200),
    -- actualNote BYTEA,
    student_note_link varchar(200),
	module_number int,
    PRIMARY KEY (student_note_id),
    FOREIGN KEY (fk_subject_id) references sy_mp.subject(subject_id) ON DELETE SET NULL ON UPDATE CASCADE

);

CREATE TABLE sy_mp.past_year_papers(
    fk_subject_id int,
    kjsce_past_year_paper_id int,
    kjsce_past_year_paper_note_name varchar(50),
    kjsce_past_year_paper_year_of_conduction int,
	-- path_of_paper varchar(50),
    kjsce_past_year_paper_link varchar(200),
	-- kjscePastYearPaper BYTEA,
    PRIMARY KEY (kjsce_past_year_paper_id),
    FOREIGN KEY (fk_subject_id) references sy_mp.subject(subject_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE sy_mp.guidlines(
    fk_subject_id int,
    guidline_id int,
    guidline_heading varchar(100),
    guidline_description varchar(1000),
    guidline_year_of_post int,
    guidline_avg_rating real,
    guidline_no_of_ratings int,
    PRIMARY KEY (guidline_id),
    FOREIGN KEY (fk_subject_id) references sy_mp.subject(subject_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREATE TABLE sy_mp.online_courses(
--     fk_subject_id int,
--     referencelink_id int,
--     referencelink_heading varchar(50),
--     referencelink_avg_rating real,
--     referencelink_no_of_ratings int,
--     referencelink_no_of_reviews int,
--     referencelink_course_description varchar(300),
--     PRIMARY KEY (referencelink_id),
--     FOREIGN KEY (fk_subject_id) references sy_mp.subject(subject_id) ON DELETE CASCADE ON UPDATE CASCADE

-- );

CREATE TABLE sy_mp.online_courses(
    fk_subject_name varchar(50),
	fk_dept_name varchar(50),
    course_id int,
    course_name varchar(50),
    course_link varchar(200),
    PRIMARY KEY (course_id),
    FOREIGN KEY (fk_subject_name,fk_dept_name) references sy_mp.subject(subject_name,fk_dept_name) ON DELETE SET NULL ON UPDATE CASCADE
-- 	FOREIGN KEY (fk_dept_name) references sy_mp.department(dept_name) ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE sy_mp.reference_links_reviews(
    fk_referencelink_id int,
    referencelink_review varchar(300),
    PRIMARY KEY (fk_textbook_id,referencelink_review),
    FOREIGN KEY (fk_referencelink_id) references sy_mp.referenceLinks(referencelink_id) ON DELETE CASCADE ON UPDATE CASCADE
);




INSERT INTO sy_mp.subject 
    VALUES (100,'Data Structures',2,3,'Computer'),
 		   (200,'TACD',2,3,'Computer'),
		   (300,'Modern OS',3,5,'Computer'),
		   (400,'Flight Dynamics',3,6,'Mechanical'),
		   (500,'Automobile Design',3,5,'Mechanical'),
		   (600,'VLSI Technology',4,7,'Electronics');
		   

INSERT INTO sy_mp.student
    VALUES (5,'Name1','name1@somaiya.edu','pass1',3);

INSERT INTO sy_mp.textbooks_reviews
VALUES (1,'Great Textbook For beginners');


UPDATE sy_mp.subject SET subjectname = 'Analysis of Algorithms' WHERE subjectid= 100;
SELECT * FROM sy_mp.subject;


DELETE FROM sy_mp.subject WHERE subjectid = 100;
SELECT * FROM sy_mp.subject;


SELECT correspondingDepartment,COUNT(subjectid) FROM sy_mp.subject GROUP BY correspondingDepartment;


SELECT * FROM sy_mp.subject WHERE subjectid IN (100,200,300);
SELECT * FROM sy_mp.subject WHERE subjectid BETWEEN 100 AND 300;

(SELECT * FROM sy_mp.subject WHERE subjectname LIKE '%s') UNION (SELECT * FROM sy_mp.subject WHERE subjectname LIKE '%S');




SELECT * FROM sy_mp.student;
SELECT * FROM sy_mp.subject;	
SELECT * FROM sy_mp.textbook;
SELECT * FROM sy_mp.textbooksReviews;

DELETE FROM sy_mp.textbook 

INSERT INTO sy_mp.textbook (fksubjectid,textbookId, textbookName, textbookAvgRating, textbookNoOfRatings, textbookAuthor, textbookEdition, publication_year,publisher)
    VALUES (100,1, 'Intro to DBMS Korth', 5, 10 , 'Korth', 7, 2022 , 'McGraww Hill'),
		   (200,2,'Intro to TACD',4.5,10,'GK Gupta',4,2021,'Pearson'),
		   (200,3,'Intermediate TACD',7,10,'GK Gupta',4,2021,'Penguin'),
		   (300,4,'Modern OS Intro',7,10,'GK Gupta',4,2021,'Penguin');
		   

-- inner query gives subjectid of textbooks whose publication year is 2021
-- outer query prints details of the subjects whose subjectid is given by inner query

SELECT * FROM sy_mp.subject WHERE subjectid = ANY(SELECT fksubjectid FROM sy_mp.textbook WHERE publication_year=2021);

SELECT * FROM sy_mp.subject WHERE subjectid = ALL(Select fksubjectid from sy_mp.textbook WHERE publisher = 'Pearson');

SELECT * FROM sy_mp.subject WHERE NOT EXISTS (SELECT subjectid FROM sy_mp.subject WHERE subjectid>100 and correspondingyear = 3 );

-- print max avg rating 
SELECT MAX(textbookAvgRating) FROM sy_mp.textbook;


-- print the textbook details of the textbook with max avg rating
SELECT * FROM sy_mp.textbook WHERE textbookAvgRating = (SELECT MAX(textbookAvgRating) FROM sy_mp.textbook);

