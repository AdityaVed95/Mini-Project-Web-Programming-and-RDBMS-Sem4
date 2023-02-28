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
    PRIMARY KEY (textbookId)
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
    VALUES (100,'Data Structures',2,3,'Computer');

INSERT INTO sy_mp.student
    VALUES (5,'Name1','name1@somaiya.edu','pass1',3);

INSERT INTO sy_mp.textbooksReviews
    VALUES (1,'Great Textbook For beginners');

SELECT * FROM sy_mp.student;
SELECT * FROM sy_mp.subject;	
SELECT * FROM sy_mp.textbook;
SELECT * FROM sy_mp.textbooksReviews;



