use [Universitys]
GO

SELECT * FROM Fakultys
/*insert-запрос для проверки внешнего ключа*/
INSERT INTO Student 
VALUES  ('Гукун','Яна','Евгеньевна',228,82,CAST(N'20160827' as date)), ('Иванова','Елизавета','Сергеевна',168, 65,CAST(N'20150829' as date))

/*insert-запрос для проверки значения по умолчанию*/
INSERT INTO University
VALUES  ('ВШЭ',DEFAULT)
SELECT * FROM University

SELECT * FROM University
/*insert-запрос для проверки уникальности значения */
INSERT INTO University
VALUES  ('ПГНИУ',DEFAULT)


/*1*/
SELECT ID, Surname, Name, Patronymic , Exam_score, FakultyID, Date_of_admission
FROM Student

/*2*/
SELECT ID, Fakulty, UniversityID
FROM Fakultys

/*3*/
SELECT ID, University
FROM University

/*0.1*/
SELECT *
FROM Student,Fakultys
WHERE Student.FakultyID = Fakultys.ID 
ORDER BY Surname DESC

/*4*/
SELECT Student.ID, Surname, Name, Patronymic, Exam_score, Date_of_admission, Fakulty, University
FROM Student,Fakultys,University
WHERE Student.FakultyID = Fakultys.ID AND Fakultys.UniversityID = University.ID
ORDER BY Surname DESC

/*5*/
SELECT Student.ID, Surname, Name, Patronymic, Exam_score, Date_of_admission, Fakulty, University
FROM (Student FULL OUTER JOIN Fakultys
      ON  Fakultys.ID = Student.FakultyID)
         FULL OUTER JOIN  University
		   ON  University.ID = Fakultys.UniversityID
