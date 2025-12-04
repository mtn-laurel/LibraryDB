-- MySQL dump 10.13  Distrib 9.5.0, for macos15.7 (arm64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	9.5.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--
--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `ISBN` char(10) NOT NULL,
  `genre` varchar(100) NOT NULL,
  `author` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  `publisher` varchar(100) NOT NULL,
  `department` enum('kids','teens','adults') NOT NULL,
  PRIMARY KEY (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('1338878921','Fiction','J.K. Rowling','Harry Potter and the Sorcerer’s Stone','Scholastic','teens'),('544273443','Fantasy','J.R.R. Tolkien','Lord of the Rings Deluxe Edition','Allen & Unwin','adults');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cd`
--

DROP TABLE IF EXISTS `cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cd` (
  `issn` char(9) NOT NULL,
  `genre` varchar(100) NOT NULL,
  `artist` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  `record_label` varchar(100) NOT NULL,
  `department` enum('kids','teens','adults') NOT NULL,
  PRIMARY KEY (`issn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cd`
--

LOCK TABLES `cd` WRITE;
/*!40000 ALTER TABLE `cd` DISABLE KEYS */;
/*!40000 ALTER TABLE `cd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employee_id` int NOT NULL,
  `email` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `email_format` CHECK (regexp_like(`email`,_utf8mb4'^[[:alnum:]]+@[[:alnum:]]+\\.[[:alnum:]]+$'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `inventory_id` int NOT NULL,
  `book_id` char(10) DEFAULT NULL,
  `cd_id` char(9) DEFAULT NULL,
  PRIMARY KEY (`inventory_id`),
  KEY `inventory_ibfk_2` (`cd_id`),
  KEY `inventory_ibfk_1` (`book_id`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `book` (`ISBN`),
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`cd_id`) REFERENCES `cd` (`issn`),
  CONSTRAINT `inventory_chk_1` CHECK ((((`book_id` is not null) and (`cd_id` is null)) or ((`cd_id` is not null) and (`book_id` is null))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan` (
  `loan_id` int NOT NULL,
  `inventory_id` int NOT NULL,
  `borrow_date` date NOT NULL,
  `return_date` date DEFAULT NULL,
  `due_date` date NOT NULL,
  `member_id` int NOT NULL,
  PRIMARY KEY (`loan_id`),
  KEY `inventory_id` (`inventory_id`),
  KEY `loan_member_fk` (`member_id`),
  CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`),
  CONSTRAINT `loan_member_fk` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `member_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `dob` date NOT NULL,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-03 14:20:19



-- added sample data


-- Books
-- INSERT INTO book (ISBN, genre, author, title, publisher, department)
-- VALUES (1338878921, 'Fiction', 'J.K. Rowling', 'Harry Potter and the Sorcerer’s Stone', 'Scholastic', 'teens');

-- INSERT INTO book (ISBN, genre, author, title, publisher, department)
-- VALUES (0544273443, 'Fantasy', 'J.R.R. Tolkien', 'Lord of the Rings Deluxe Edition', 'Allen & Unwin', 'adults');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (0573702411, 'Mystery', 'Agatha Christie', 'Death on the Nile', 'Collins Crime Club', 'adults');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (1455582875, 'Romance', 'Nicholas Sparks', 'The Notebook', 'Warner Books', 'adults');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (0553382578, 'Sci-Fi', 'Isaac Asimov', 'Foundation', 'Gnome Press', 'adults');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (1501143107, 'Thriller', 'Stephen King', 'Misery', 'Viking', 'adults');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (0553386794, 'Fantasy', 'George R.R. Martin', 'A Game of Thrones', 'Bantam Spectra', 'adults');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (0143039989, 'Horror', 'Shirley Jackson', 'The Haunting of Hill House', 'Viking', 'teens');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (0743270754, 'History', 'Doris Kearns Goodwin', 'Team of Rivals: The Political Genius of Abraham Lincoln', 'Simon & Schuster', 'adults');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (0316017930, 'Non-fiction', 'Malcolm Gladwell', 'Outliers: The Story of Success', 'Little, Brown and Company', 'adults');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (0241265541, 'Fiction', 'Leo Tolstoy', 'War and Peace', 'The Russian Messenger', 'adults');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (1982176865, 'Biography', 'Walter Isaacson', 'Steve Jobs', 'Simon & Schuster ', 'adults');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (0060244887, 'Fantasy', 'C.S. Lewis', 'The Chronicles of Narnia Box Set', 'HarperCollins', 'kids');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (0143107321, 'Adventure', 'Mark Twain', 'The Adventures of Huckleberry Finn', 'Chatto & Windus', 'teens');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (0553897446, 'Mystery', 'Arthur Conan Doyle', 'The Adventures of Sherlock Holmes', 'George Newnes', 'teens');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (0141439513, 'Romance', 'Jane Austen', 'Pride and Prejudice', 'T. Egerton', 'teens');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (0140569324, 'Picture Book', 'Eric Carle', 'The Very Hungry Caterpillar', 'World Publishing Company', 'kids');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (1558585362, 'Picture Book', 'Marcus Pfister', 'The Rainbow Fish', 'NordSüd Verlag', 'kids');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (0385504217, 'Thriller', 'Dan Brown', 'The Da Vinci Code', 'Doubleday', 'adults');

INSERT INTO book (ISBN, genre, author, title, publisher, department)
VALUES (1954839243, 'Fiction', 'F. Scott Fitzgerald', 'The Great Gatsby', 'Charles Scribner’s Sons', 'teens');



-- CDs
INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (546737758, 'Synth-pop', '1989', 'Taylor Swift', 'Big Machine Records', 'teens');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (621371203, 'Pop', 'Divide', 'Ed Sheeran', 'Atlantic Records', 'teens');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (761901941, 'Pop', '21', 'Adele', 'XL Recordings', 'teens');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (992369051, 'Rock', 'Abbey Road', 'The Beatles', 'Apple Records', 'adults');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (757860280, 'Hip-Hop', 'Views', 'Drake', 'Cash Money Records', 'adults');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (674982918, 'R&B', 'Lemonade', 'Beyonce', 'Columbia Records', 'adults');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (438298552, 'Pop', 'Teenage Dream', 'Katy Perry', 'Capitol Records', 'teens');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (940080422, 'Pop', 'Starboy', 'The Weeknd', 'XO Records', 'teens');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (235762481, 'Psychedelic Rock', 'Dark Side of the Moon', 'Pink Floyd', 'Capitol Records', 'adults');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (824538978, 'Pop', 'Thriller', 'Michael Jackson', 'Epic Records', 'adults');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (348638078,'EDM', 'Purpose', 'Justin Bieber', 'Def Jam Recordings', 'teens');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (669080241, 'Soul', 'In the Lonely Hour', 'Sam Smith', 'Capitol Records', 'teens');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (264390199, 'Synth-pop', 'The Fame', 'Lady Gaga', 'Interscope Records', 'teens');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (635100828, 'Rock and Roll', 'Born to Run', 'Bruce Springsteen', 'Columbia Records', 'adults');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (604061697, 'Pop Rock', 'Songs About Jane', 'Maroon 5', 'Octone Records', 'teens');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (586158137, 'Grunge', 'Nevermind', 'Nirvana', 'DGC Records', 'adults');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (666857876, 'Pop', 'Anti', 'Rihanna', 'Westbury Road', 'adults');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (753114630, 'Alt Pop', 'Born to Die', 'Lana Del Rey', 'Interscope Records', 'teens');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (699016854, 'Indie Rock', 'AM', 'Arctic Monkeys', 'Domino Recording', 'teens');

INSERT INTO cd (ISSN, genre, title, artist, record_label, department)
VALUES (276484285, 'Indie Pop', 'Lungs', 'Florence + The Machine', 'Universal Music', 'teens');



-- Members
INSERT INTO member (member_id, name, dob)
VALUES (5001, 'Jill Stoney', 1992-11-14);

INSERT INTO member (member_id, name, dob)
VALUES (5002, 'Robert Robertson', 1990-01-13);

INSERT INTO member (member_id, name, dob)
VALUES (5003, 'Mia Jones', 1983-08-14);

INSERT INTO member (member_id, name, dob)
VALUES (5004, 'Tom Smith', 1987-10-18);

INSERT INTO member (member_id, name, dob)
VALUES (5005, 'Emma Thompson', 1990-04-15);

INSERT INTO member (member_id, name, dob)
VALUES (5006, 'Tom Sutherland', 1996-06-01);

INSERT INTO member (member_id, name, dob)
VALUES (5007, 'Abbie Coleman', 1996-09-01);

INSERT INTO member (member_id, name, dob)
VALUES (5008, 'John Doe', 1963-06-09);

INSERT INTO member (member_id, name, dob)
VALUES (5009, 'Scarlett Black', 1984-11-22);

INSERT INTO member (member_id, name, dob)
VALUES (5010, 'Chris Townsend', 1983-08-11);

INSERT INTO member (member_id, name, dob)
VALUES (5011, 'Natalie Portman', 1981-06-09);

INSERT INTO member (member_id, name, dob)
VALUES (5012, 'Sam Freeman', 1967-11-22);

INSERT INTO member (member_id, name, dob)
VALUES (5013, 'Chris White', 1981-06-13);

INSERT INTO member (member_id, name, dob)
VALUES (5014, 'Jackie Johnson', 1965-04-04);

INSERT INTO member (member_id, name, dob)
VALUES (5015, 'Sammy Jackson', 1948-12-21);

INSERT INTO member (member_id, name, dob)
VALUES (5016, 'Brie Stacy', 1989-10-01);

INSERT INTO member (member_id, name, dob)
VALUES (5017, 'Jameson Parker', 1976-07-19);

INSERT INTO member (member_id, name, dob)
VALUES (5018, 'May Fontenot', 1985-04-30);

INSERT INTO member (member_id, name, dob)
VALUES (5019, 'Hugh Jones', 1968-10-12);

INSERT INTO member (member_id, name, dob)
VALUES (5020, 'Jack Red', 1971-01-07);




-- Employees
INSERT INTO employee (employee_id, email, name)
VALUES (6001, 'ajohnson12@library.gov', "Alice Johnson");

INSERT INTO employee (employee_id, email, name)
VALUES (6002, 'bsmith89@library.gov', "Bob Smith");

INSERT INTO employee (employee_id, email, name)
VALUES (6003, 'cwhite74@library.gov', "Carol White");

INSERT INTO employee (employee_id, email, name)
VALUES (6004, 'dthomas56@library.gov', "David Thomas");

INSERT INTO employee (employee_id, email, name)
VALUES (6005, 'miller22@library.gov', "Emily Miller");


-- inventory, books/cds can have muliple copies

-- books
-- Harry Potter and the Sorcerer’s Stone, 3 copies
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7001, '1338878921', NULL);
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7002, '1338878921', NULL);
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7003, '1338878921', NULL);

-- Lord of the Rings Deluxe Edition, 1 copy
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7004, '0544273443', NULL);

-- Death on the Nile, 1 copy
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7005, '0573702411', NULL);

-- Misery, 1 copy
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7006, '1501143107', NULL);

-- The Notebook, 2 copies
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7007, '1455582875', NULL);
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7008, '1455582875', NULL);

-- A Game of Thrones, 1 copy
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7009, '0553386794', NULL);

-- Foundation, 1 copy
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7010, '0553382578', NULL);

-- The Great Gatsby, 1 copy
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7011, '1954839243', NULL);

-- The Haunting of Hill House, 2 copies
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7012, '0143039989', NULL);
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7013, '0143039989', NULL);


-- cds
-- 1989 - Taylor Swift, 2 copies
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7014, NULL, '546737758');
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7015, NULL, '546737758');

-- Divide - Ed Sheeran, 1 copy
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7016, NULL, '621371203');

-- Abbey Road - The Beatles, 1 copy
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7017, NULL, '992369051');

-- Dark Side of the Moon - Pink Floyd, 1 copy
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7018, NULL, '235762481');

-- 21, 2 copies
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7019, NULL, '761901941');
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7020, NULL, '761901941');

-- Teenage Dream, 1 copy
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7021, NULL, '438298552');

-- Starboy, 1 copy
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7022, NULL, '940080422');

-- Thriller, 3 copies
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7023, NULL, '824538978');
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7024, NULL, '824538978');
INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (7025, NULL, '824538978');


-- loans
-- --- Active Loans (return_date IS NULL) ---
-- Jill Stoney (5001) borrows Harry Potter Copy 1 (7001)
INSERT INTO loan (loan_id, inventory_id, borrow_date, due_date, member_id, return_date)
VALUES (8001, 7001, '2025-11-20', '2025-12-11', 5001, NULL);

-- Robert Robertson (5002) borrows The Notebook Copy 1 (7005)
INSERT INTO loan (loan_id, inventory_id, borrow_date, due_date, member_id, return_date)
VALUES (8002, 7005, '2025-11-25', '2025-12-16', 5002, NULL);

-- Mia Jones (5003) borrows 1989 CD Copy 2 (7010)
INSERT INTO loan (loan_id, inventory_id, borrow_date, due_date, member_id, return_date)
VALUES (8003, 7010, '2025-11-28', '2025-12-19', 5003, NULL);

-- --- Completed Loans (return_date IS NOT NULL) ---
-- Tom Smith (5004) borrowed and returned Lord of the Rings (7003)
INSERT INTO loan (loan_id, inventory_id, borrow_date, due_date, member_id, return_date)
VALUES (8004, 7003, '2025-10-01', '2025-10-22', 5004, '2025-10-18');

-- Emma Thompson (5005) borrowed and returned Abbey Road CD (7012)
INSERT INTO loan (loan_id, inventory_id, borrow_date, due_date, member_id, return_date)
VALUES (8005, 7012, '2025-10-15', '2025-11-05', 5005, '2025-11-05');