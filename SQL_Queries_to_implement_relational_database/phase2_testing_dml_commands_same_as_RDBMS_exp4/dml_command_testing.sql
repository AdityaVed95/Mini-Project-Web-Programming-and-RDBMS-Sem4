CREATE TABLE sy_mp.student(
    rollNo int,
    studentName varchar(50),
    studentEmail varchar(50),
    studentPassword varchar(50),
    studentCurrentSem int,
    PRIMARY KEY (rollNo)
);

CREATE TABLE sy_mp.subject(
    subjectId int,
    subjectName varchar(50),
    correspondingYear int,
    correspondingSem int,
    correspondingDepartment varchar(50),
    PRIMARY KEY (subjectId)
);

CREATE TABLE sy_mp.textbook(
    -- text book always belongs to a particular subject
    fkSubjectId int,
    textbookId int,
    textbookName varchar(50),
    textbookAvgRating real, -- refers to avg rating
    textbookNoOfRatings int,
    textbookAuthor varchar(50),
    textbookEdition varchar(50),
    publication_year int,
    publisher varchar(50),
    actualPdf BYTEA,
    PRIMARY KEY (textbookId),
    FOREIGN KEY (fkSubjectId) references sy_mp.subject(subjectId) ON DELETE SET NULL ON UPDATE CASCADE
);

-- since textbookReviews is a multi valued attribute , thus we need to 
-- create a seperate table for it

CREATE TABLE sy_mp.textbooksReviews(
    fkTextbookId int,
    textbookReview varchar(300),
    PRIMARY KEY (fkTextbookId,textbookReview),
    FOREIGN KEY (fkTextbookId) references sy_mp.textbook(textbookId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE sy_mp.officialKjsceNotes(
    fkSubjectId int,
    kjsceNoteId int,
    kjsceNoteName varchar(50),
    actualNote BYTEA,
	moduleNumber int,
    PRIMARY KEY (kjsceNoteId),
    FOREIGN KEY (fkSubjectId) references sy_mp.subject(subjectId) ON DELETE SET NULL ON UPDATE CASCADE

);

CREATE TABLE sy_mp.pastYearPapers(
    fkSubjectId int,
    kjscePastYearPaperId int,
    kjscePastYearPaperNoteName varchar(50),
    kjscePastYearPaperYearOfConduction int,
    kjscePastYearPaper BYTEA,
    PRIMARY KEY (kjscePastYearPaperId),
    FOREIGN KEY (fkSubjectId) references sy_mp.subject(subjectId) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE sy_mp.guidlines(
    fkSubjectId int,
    guidlineId int,
    guidlineHeading varchar(100),
    guidlineDescription varchar(1000),
    guidlineYearOfPost int,
    guidlineAvgRating real,
    guidlineNoOfRatings int,
    PRIMARY KEY (guidlineId),
    FOREIGN KEY (fkSubjectId) references sy_mp.subject(subjectId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE sy_mp.referenceLinks(
    fkSubjectId int,
    referenceLinkId int,
    referenceLinkHeading varchar(50),
    referenceLinkAvgRating real,
    referenceLinkNoOfRatings int,
    referenceLinkNoOfReviews int,
    referenceLinkCourseDescription varchar(300),
    PRIMARY KEY (referenceLinkId),
    FOREIGN KEY (fkSubjectId) references sy_mp.subject(subjectId) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE sy_mp.referenceLinksReviews(
    fkTextbookId int,
    referenceLinkReview varchar(300),
    PRIMARY KEY (fkTextbookId,referenceLinkReview),
    FOREIGN KEY (fkTextbookId) references sy_mp.textbook(textbookId) ON DELETE CASCADE ON UPDATE CASCADE
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

INSERT INTO sy_mp.textbooksReviews
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

