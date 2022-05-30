USE master
GO
DROP DATABASE IF EXISTS bookrepositorydb
GO
CREATE DATABASE bookrepositorydb
GO
USE bookrepositorydb
GO


CREATE TABLE Authors(
	authorId NVARCHAR(10) NOT NULL PRIMARY KEY,
	authorname NVARCHAR(30) NOT NULL
)

CREATE TABLE Topics(
	topicId NVARCHAR(10) NOT NULL PRIMARY KEY,
	topicName NVARCHAR(30) NOT NULL
)

CREATE TABLE Publishers(
	publisherid NVARCHAR(10) NOT NULL PRIMARY KEY,
	publisherName NVARCHAR(30) NOT NULL
)

CREATE TABLE Books(
	bookID NVARCHAR(10) NOT NULL PRIMARY KEY,
	bookName NVARCHAR(30) NOT NULL,
	publisherid	NVARCHAR(10) NOT NULL REFERENCES Publishers(publisherid)
)


CREATE TABLE AuthorBooks(
	authorId NVARCHAR(10) NOT NULL REFERENCES Authors(authorId),
	bookID NVARCHAR(10) NOT NULL REFERENCES  Books(bookID),
	PRIMARY KEY (authorId,bookID)
)

CREATE TABLE BookTopics(
	bookID NVARCHAR(10) NOT NULL REFERENCES  Books(bookID),
	topicId NVARCHAR(10) NOT NULL REFERENCES  Topics(topicId),
	PRIMARY KEY (bookID,topicId)
)
GO
/*1st CREATE PROCEDURE Insert Data Autor Table*/
CREATE PROC spInsertAuthor @spAuthorId NVARCHAR(10),
						  @spAuthorName NVARCHAR(30)
AS
BEGIN TRY
	INSERT INTO Authors(authorId, authorname) VALUES(@spAuthorId, @spAuthorName)
END TRY 
BEGIN CATCH
	DECLARE @Message NVARCHAR(1000)
	SELECT @Message = ERROR_MESSAGE()
	;
	THROW 50001 , @Message, 1
END CATCH
GO
/*Update Procedure Authors Table*/
CREATE PROC spUpdateAuthor @spAuthorId NVARCHAR(10),
						  @spAuthorName NVARCHAR(30)
AS
BEGIN TRY
	UPDATE Authors 
	SET authorId = @spAuthorId, authorname = @spAuthorName
	WHERE authorId = @spAuthorId
END TRY 
BEGIN CATCH
	;
	THROW 50002, 'Update Failed' , 1
END CATCH
GO
/*
* Delete Procedure Authors Table
*/
CREATE PROC spDeleteAuthor @spAuthorId NVARCHAR(10)
AS
BEGIN TRY
	DELETE Authors 
	WHERE authorId = @spAuthorId
END TRY 
BEGIN CATCH
	;
	THROW 50002, 'Cannont Delete' , 1
END CATCH
GO

/* 2nd Insert, Update and Delete Data Publishers Table*/

CREATE PROC spInsertPublishers @spPid NVARCHAR(10),
						  @spPname NVARCHAR(30)
AS
BEGIN TRY
	INSERT INTO Publishers(publisherid, publisherName) VALUES(@spPid, @spPname)
END TRY 
BEGIN CATCH
	DECLARE @Message NVARCHAR(1000)
	SELECT @Message = ERROR_MESSAGE()
	;
	THROW 50001 , @Message, 1
END CATCH
GO
--Update
CREATE PROC spUpdatePublishers @spPid NVARCHAR(10),
							@spPname NVARCHAR(30)
AS
BEGIN TRY 
	UPDATE Publishers 
	SET publisherid = @spPid , publisherName =@spPname
	WHERE publisherid = @spPid
END TRY 
BEGIN CATCH
	;
	THROW 50001, 'Update Failed' , 1
END CATCH
GO
--Delete
CREATE PROC spDeletePublishers @spPid NVARCHAR(10)
AS
BEGIN TRY
		DELETE Publishers
		WHERE publisherid = @spPid
END TRY
BEGIN CATCH
	;
	THROW 50001, ' Cannot delete ', 1
END CATCH
GO

--/* 3rd Insert, Update and Delete Data Topics Table*/
--Insert
CREATE PROC spInsertTopics @spTid NVARCHAR(10),
						  @spTname NVARCHAR(30)
AS
BEGIN TRY
	INSERT INTO Topics(topicId,topicName) VALUES(@spTid, @spTname)
END TRY 
BEGIN CATCH
	DECLARE @Message NVARCHAR(1000)
	SELECT @Message = ERROR_MESSAGE()
	;
	THROW 50001 , @Message, 1
END CATCH
GO
----Update
CREATE PROC spUpdateTopics @spTid NVARCHAR(10),
						  @spTname NVARCHAR(30)
AS
BEGIN TRY
	UPDATE BookTopics
	SET bookID = @spTid , topicId =@spTname
	WHERE bookID = @spTid
END TRY 
BEGIN CATCH
	;
	THROW 50001 , 'Update Failed', 1
END CATCH
GO
----Delete
CREATE PROC spDelteTopics @spTid NVARCHAR(10)
AS
BEGIN TRY
	DELETE BookTopics
	WHERE bookID = @spTid
END TRY 
BEGIN CATCH
	;
	THROW 50001 , 'Update Failed', 1
END CATCH
GO

--/* 4th Insert, Update and Delete Data Books Table*/
--Insert
CREATE PROC spInsertBooks @spBid NVARCHAR(10),
						  @spBname NVARCHAR(30),
						  @spPid NVARCHAR(10)
AS
BEGIN TRY
	INSERT INTO Books(bookID, bookName, publisherid) VALUES(@spBid, @spBname,@spPid )
END TRY 
BEGIN CATCH
	DECLARE @Message NVARCHAR(1000)
	SELECT @Message = ERROR_MESSAGE()
	;
	THROW 50001 , @Message, 1
END CATCH
GO
--Update
CREATE PROC spUpdateBooks @spBid NVARCHAR(10),
						  @spBname NVARCHAR(30),
						  @spPid NVARCHAR(10)
AS
BEGIN TRY
	UPDATE Books
	SET bookID = @spBid,  bookName = @spBname,  publisherid = @spPid
END TRY 
BEGIN CATCH
	DECLARE @Message NVARCHAR(1000)
	SELECT @Message = ERROR_MESSAGE()
	;
	THROW 50001 , @Message, 1
END CATCH
GO
--Delete
CREATE PROC spDeleteBooks @spBid NVARCHAR(10)
AS
BEGIN TRY
	DELETE Books
	WHERE bookID = @spBid
END TRY 
BEGIN CATCH
	DECLARE @Message NVARCHAR(1000)
	SELECT @Message = ERROR_MESSAGE()
	;
	THROW 50001 , 'Dont Delete', 1
END CATCH
GO
--/* 5th Insert, Update and Delete Data AuthorBook Table*/
--Insert
CREATE PROC spInsertAuthorBooks @spAid NVARCHAR(10),
								@spBid NVARCHAR(10)
AS
BEGIN TRY
	INSERT INTO AuthorBooks (authorId, bookID) VALUES (@spAid,@spBid)
END TRY
BEGIN CATCH
	DECLARE @msg NVARCHAR(1000)
	SELECT @msg = ERROR_MESSAGE()
	;
	THROW 50001, @msg, 1
END CATCH 
GO
--UPDATE 
CREATE PROC spUpdateAuthorBooks @spAid NVARCHAR(10),
								@spBid NVARCHAR(10)
AS
BEGIN TRY
	UPDATE AuthorBooks 
	SET authorId = @spAid,bookID = @spBid 
END TRY
BEGIN CATCH
	;
	THROW 50001, 'Dont Update', 1
END CATCH 
GO
--/* 6th Insert, Update and Delete Data BookTopics Table*/
--Insert
CREATE PROC spInsertBookTopics @spBid NVARCHAR(10),
								@sTBid NVARCHAR(10)
AS
BEGIN TRY
	INSERT INTO BookTopics(bookID, topicId) VALUES (@spBid,@sTBid)
END TRY
BEGIN CATCH
	DECLARE @msg NVARCHAR(1000)
	SELECT @msg = ERROR_MESSAGE()
	;
	THROW 50001, @msg, 1
END CATCH 
GO
--UPDATE 
CREATE PROC spUpdateBookTopics @spBid NVARCHAR(10),
								@sTBid NVARCHAR(10)
AS
BEGIN TRY
	UPDATE BookTopics
	SET bookID = @spBid,  topicId = @sTBid
	WHERE bookID = @spBid
END TRY
BEGIN CATCH
	;
	THROW 50001, 'Dont Update', 1
END CATCH 
GO

CREATE NONCLUSTERED INDEX ixBookName 
ON Books (bookName)
GO

--/*  Create Function: A scalar valued function*/
--Insert	
GO
CREATE FUNCTION fnScalar(@publisherid NVARCHAR(10) ) RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @n NVARCHAR(10) 
	SELECT @n = COUNT(*) FROM books
	WHERE @publisherid =@publisherid
	RETURN @n
END
GO
--SELECT dbo.fnScalar 
CREATE FUNCTION fnAuthor(@authorid NVARCHAR(10)) returns NVARCHAR(10)
AS
BEGIN
DECLARE @i NVARCHAR(10)
SELECT @i = COUNT(*) from AuthorBooks
WHERE authorId= @authorid
RETURN @i
END
GO
--b. A table valued function
CREATE FUNCTION fnTable(@publisherid NVARCHAR(10)) RETURNS TABLE
AS
RETURN
(
SELECT b.bookid, bookname, a.authorname, b.publisherid
FROM Books b
INNER JOIN AuthorBooks ab
ON ab.bookid = b.bookid
INNER JOIN Authors a
ON ab.authorid = a.authorid
WHERE publisherid =@publisherid
)
GO
--View 
CREATE VIEW vInfo
AS
SELECT b.bookid, bookname, a.authorname, b.publisherid
FROM books b
INNER JOIN AuthorBooks ab
ON ab.bookid = b.bookid
INNER JOIN Authors a
ON ab.authorid = a.authorid
GO
--TRIGGER
CREATE TRIGGER trauthorbooks
ON AuthorBooks 
AFTER INSERT 
AS 
BEGIN
DECLARE @t_id NVARCHAR(10)
SELECT @t_id=authorid FROM inserted
	IF exists
		(
			SELECT count(*), authorId FROM AuthorBooks
			WHERE authorId =@t_id
			GROUP BY authorid
			HAVING COUNT(*) >3
		)
		BEGIN
			ROLLBACK TRANSACTION
			; 
			THROW 50001,'Author already have three books',1
		END
END 
GO
