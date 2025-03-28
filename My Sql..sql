create schema LIBRARY
use LIBRARY
create table Books(
BooksID int,
Title varchar(50),
Author varchar(50),
Category varchar(50),
PublicationYear int,
CopiesAvailable int)

select * from Books

insert into Books values (1001,"The Alchemist","Paulo coelho","Fiction",1988,5),(1002,"Becoming","Michelle Obama","Autobiography",2018,3),
                         (1003,"Sapiens","Yuval Noah Harari","History",2011,8),(1004,"To Kill a Mockingbird","Harper Lee","Fiction",1960,5),
                         (1005,"Pride and Prejudice","Jane Austen","Romance",1813,7),(1006,"Dune","Frank Herbert","Sci-Fi",1965,6),
                         (1007,"The Hobbit","J.R.R.Tolkien","Fantasy",1937,6),(1008,"The Midnight Library","Matt Haig","Fantasy",2020,5),
                         (1009,"The Silent Patient","Alex Michaelides","Thriller",2019,3),(1010,"The Catcher in the Rye","J.D.Salinger","Fiction",1951,4),
                         (1011,"The Great Gatsby","F.Scott Fitzgerald","Classic",1925,6),(1012,"Atomic Habits","James Clear","Self-help",2018,10),
                         (1013,"Educated","Tara Westover","Memoir",2018,5),(1014,"The Diary of a Young Girl","Anne Frank","Autobiography",1947,6),
                         (1015,"Me Before You","Jojo Moyes","Romance",2012,5)
						
create table Members(
MembersID int,
FirstName varchar(50),
LastName varchar(50),
Email varchar(255),
JoinDate date )

select * from Members

insert into Members values (001,"John","Smith","john.smith@email.com",'2023-01-15'),(002,"Emily","Johnson","emily.j@email.com",'2022-07-20'),
                           (003,"Micheal","Brown","michael.b@email.com",'2021-05-10'),(004,"Sarah","Thomas","sarah.t@email.com",'2023-09-12'),
                           (005,"Sam","Martinez","sam.m@email.com",'2020-11-30'),(006,"Jessica","Taylor","jessica.t@email.com",'2022-03-25'),
                           (007,"Laura","Anderson","laura.t@email.com",'2023-05-05'),(008,"Robert","White","robert.a@email.com",'2021-08-14'),
                           (009,"Olivia","Harris","olivia.h@email.com",'2022-12-01'),(010,"Adam","Pearson","adam.p@email.com",'2024-05-12')

create table BorrowTransactions(
TransactionID int,
BookID int,
MemberID int,
BorrowDate date,
ReturnDate date)                   

select * from BorrowTransactions

insert into BorrowTransactions values(101, 1006, 003, '2024-01-10', '2024-01-24'),(102, 1003, 009, '2024-12-01', '2025-2-01'),
                                         (103, 1010, 001, '2024-01-14', '2024-01-26'),(104, 1014, 004, '2024-01-24', '2024-01-28'),
                                         (105, 1013, 001, '2024-01-15', '2024-01-29'),(106, 1015, 007, '2024-02-02', '2024-05-03'),  
                                         (107, 1012, 010, '2024-08-02', '2024-09-01'),(108, 1002, 102, '2024-02-14', '2024-02-28'),
                                         (109, 1006, 104, '2024-09-19', '2024-10-02'),(110, 1007, 105, '2024-02-07', '2024-02-21'),  
                                         (111, 1007, 108, '2024-03-31', '2024-04-15'),(112, 1002, 109, '2024-05-22', '2024-06-10'),
                                         (113, 1015, 106, '2024-07-08', '2024-07-14'),(114, 1013, 108, '2024-06-25', '2024-07-10'),
                                         (115, 1010, 104, '2024-12-28', '2025-01-12'),(116, 1014, 105, '2024-02-03', '2024-04-13'),
                                         (117, 1005, 101, '2024-03-03', '2024-04-03'),(118, 1002, 104, '2024-02-16', '2024-02-29'),
                                         (119, 1007, 107, '2024-01-18', '2024-02-20'),(120, 1003, 106, '2024-06-22', '2024-07-05');

create table Fines(
FineID int,
TransactionID int,
FineAmount decimal(10,2),
PaidStatus varchar(50))

select * from Fines

insert into Fines values (1,101,5,"unpaid"),
                         (2,102,10.50,"paid"),
                         (3,103,7.25,"unpaid"),
                         (4,104,8,"paid"),
                         (5,105,9.75,"paid")
                         
SELECT 
    t.TransactionID, 
    t.BookID, 
    t.MemberID, 
    t.BorrowDate
FROM borrowtransactions t
WHERE t.BorrowDate >= CURDATE() - INTERVAL 30 DAY
ORDER BY t.BorrowDate DESC;                        


SELECT CONCAT(m.FirstName, ' ', m.LastName) AS MemberName, 
       COUNT(b.TransactionID) AS TotalBooksBorrowed
FROM Members m
LEFT JOIN BorrowTransactions b ON m.MembersID = b.MemberID
GROUP BY m.MembersID, MemberName;




SELECT m.MembersID, m.FirstName, m.LastName, m.Email, m.JoinDate, COUNT(b.TransactionID) AS TotalBooksBorrowed
FROM members m
JOIN borrowtransactions b ON m.MembersID = b.MemberID
GROUP BY m.MembersID, m.FirstName, m.LastName, m.Email, m.JoinDate
ORDER BY TotalBooksBorrowed DESC
LIMIT 1;