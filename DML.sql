USE bookrepositorydb
GO
/*1st Insert, Update , Delete Data Authors Table*/
EXEC spInsertAuthor 'A101', 'Hasan'
GO
EXEC spInsertAuthor 'A102', 'Mahmud'
GO
EXEC spInsertAuthor 'A103', 'Jamil'
GO
EXEC spInsertAuthor 'A103', 'Kamil'
GO
EXEC spInsertAuthor 'A104', 'Hasan Mahmud'
GO
EXEC spInsertAuthor 'A105', 'Nakib'
GO
----/*Update Data From Authors Table Using PROCEDURE*/
EXEC spUpdateAuthor @spAuthorId='A104', @spAuthorName = 'kamal'
GO
----/*Delete Data From Authors Table Using PROCEDURE*/
EXEC spDeleteAuthor 'A105'
GO
SELECT * FROM Authors 
GO
--/*Delete Data From Authors Table Using PROCEDURE*/

/*2nd Insert, Update , Delete Data Publisher Table*/
EXEC spInsertPublishers 'P101', 'ANUPAM PROKASHON'
GO
EXEC spInsertPublishers 'P102', 'SHIKHA PROKASHONI'
GO
EXEC spInsertPublishers 'P103', 'SHOVA PROKASH'
GO
EXEC spInsertPublishers 'P104', 'SHUCHIPOTRO'
GO
EXEC spInsertPublishers 'P105', 'SHUDDASHAR'
GO
EXEC spInsertPublishers 'P106', 'PEARL PUBLICATIONS'
GO
EXEC spInsertPublishers 'P107', 'BIDDYAPROKASH'
GO
EXEC spInsertPublishers 'P108', 'ANUPAM PROKASHON'
GO
EXEC spInsertPublishers 'P109', 'ANUPAM PROKASHON'
GO
EXEC spInsertPublishers 'P110', 'ANUPAM PROKASHON'
GO
--Update
EXEC spUpdatePublishers @spPid='P110', @spPname = 'GYANKOSH PRAKASHANI'
GO
SELECT * FROM Publishers
GO
--DELETE
EXEC spDeletePublishers 'P109'
GO
/* 3rd Insert, Update , Delete Data Topics Table*/

SELECT * FROM Topics
GO
EXEC spInsertTopics 'T101', '.NET Framework'
GO
EXEC spInsertTopics 'T102', 'Control Instructions.'
GO
EXEC spInsertTopics 'T103', 'Properties.'
GO
EXEC spInsertTopics 'T104', 'Exception Handling.'
GO
EXEC spInsertTopics 'T105', 'Structures.'
GO
EXEC spInsertTopics 'T106', 'Functions and Subroutines.'
GO
EXEC spInsertTopics 'T107', 'Control Instructions.'
GO
EXEC spInsertTopics 'T108', 'Constructors.'
GO


/* 4th Insert, Update , Delete Data Topics Table*/
SELECT * FROM Books
GO
EXEC spInsertBooks 'B101', 'Java', 'P101'
EXEC spInsertBooks 'B102', 'Rubi', 'P101'
EXEC spInsertBooks 'B103', 'C#', 'P102'
EXEC spInsertBooks 'B104', 'Python', 'P103'
EXEC spInsertBooks 'B105', 'C++', 'P104'
EXEC spInsertBooks 'B106', 'C', 'P105'
EXEC spInsertBooks 'B107', 'SQL', 'P105'
EXEC spInsertBooks 'B108', 'MVC', 'P106'
GO
/* 5th Insert, Update , Delete Data AuthorBooks Table*/

select * From AuthorBooks
GO
EXEC spInsertAuthorBooks 'A101', 'B101'
GO
EXEC spInsertAuthorBooks 'A101', 'B102'
EXEC spInsertAuthorBooks 'A102', 'B103'
EXEC spInsertAuthorBooks 'A103', 'B101'
EXEC spInsertAuthorBooks 'A104', 'B104'
EXEC spInsertAuthorBooks 'A104', 'B102'
EXEC spInsertAuthorBooks 'A105', 'B104'
EXEC spInsertAuthorBooks 'A105', 'B105'

GO

/* 6th Insert, Update , Delete Data Topics Table*/
SELECT * FROM BookTopics
GO
EXEC spInsertBookTopics 'B101', 'T101'
EXEC spInsertBookTopics 'B101', 'T102'
EXEC spInsertBookTopics 'B103', 'T103'
EXEC spInsertBookTopics 'B104', 'T102'
EXEC spInsertBookTopics 'B105', 'T101'
EXEC spInsertBookTopics 'B105', 'T102'
EXEC spInsertBookTopics 'B105', 'T103'
EXEC spInsertBookTopics 'B102', 'T104'
EXEC spInsertBookTopics 'B106', 'T105'
EXEC spInsertBookTopics 'B107', 'T106'
EXEC spInsertBookTopics 'B108', 'T107'


---- JOIN All Table------

--GO
--SELECT * FROM
--Authors a 
--INNER JOIN AuthorBooks ab ON a.authorId=ab.authorId
--INNER JOIN Books b ON ab.bookID = b.bookID
--INNER JOIN Publishers p ON b.publisherid = p.publisherid
--INNER JOIN BookTopics bt ON b.bookID = bt.bookID
--INNER JOIN Topics t ON bt.topicId = t.topicId
--GO
--Show View
SELECT * FROM vInfo
GO
