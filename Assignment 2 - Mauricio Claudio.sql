--------DATA 607 - Data Acquisition and Management
--------Assignemt #2 - CLAUDIO, Mauricio


----First, we create a database, MovieReviews, to house the tables
----needed to store movie review data...
CREATE DATABASE MovieReviews


----Second, within MovieReviews, we create three normalized tables
----to store constituent movie review data
CREATE TABLE Movies (
	MovieId int IDENTITY(1,1) PRIMARY KEY,
	MovieTitle varchar(50)
)
CREATE TABLE Reviews (
	ReviewId int IDENTITY(1,1) PRIMARY KEY,
	MovieId int,
	MovieRating int,
	ReviewerId int,
)
CREATE TABLE Reviewers (
	ReviwerId int IDENTITY(1,1) PRIMARY KEY,
	ReviwerName varchar(50),
)


----Third, we insert review data from a few of my friends
----into each of the three constituent tables
INSERT INTO Movies (MovieTitle)
VALUES('Twin Falls Idaho'),
		('Animal House'),
		('Das Boot'),
		('The Hunt for the Red October'),
		('Terminator'),
		('Thelma and Louise')
INSERT INTO Reviewers (ReviwerName)
VALUES('Benito Juarez'),
		('Vicente Guerrero'),
		('Xanana Gusmao'),
		('Tunku Abdul Rahman'),
		('Ho Chi Minh'),
		('Lee Kuan Yew')
INSERT INTO Reviews (MovieId,MovieRating,ReviewerId)
VALUES	(3,3,3),(3,5,1),(5,3,1),(3,4,2),(2,1,4),(3,4,5),(6,3,1),
		(4,2,1),(1,3,NULL),(3,NULL,5),(2,2,2),(NULL,3,1),(6,1,3),
		(NULL,1,4),(1,2,4),(2,5,3),(5,1,3),(2,1,5),(2,5,1),(6,4,NULL)


----Fourth, we join the three tables, eliminating NULL values in the movie title
----or the rating fields since NULL values in those two fields renders
----the review nonsensical. Anonymous reviews are allowed by changing NULL values
----in the name of the reviewer are changed to "(anonymous)". The resulting query is
----stored in a new table 'report'.
SELECT MO.MovieTitle [Movie Title],ISNULL(RS.ReviwerName,'(anonymous)') [Reviewer], RE.MovieRating [Rating]
INTO report
FROM Movies AS MO JOIN Reviews AS RE ON MO.MovieId=RE.MovieId
		LEFT JOIN Reviewers AS RS ON RS.ReviwerId=RE.ReviewerId
 WHERE RE.MovieRating IS NOT NULL


 ----Five, we check and sort the 'report' table, and then
 ----export it to Excel format via the Export Wizard.
 ----The three-line query below can also be using with R
 ----to import the table using R's RODBC package.
SELECT *
FROM report
ORDER BY [Movie Title],Rating DESC

--------END OF ASSIGNMENT
