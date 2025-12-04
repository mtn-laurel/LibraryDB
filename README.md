
CSC 4402 Database Project 
-------------------------
Emery Jones, Layla Jones, Julian Madrigal, Katherine Winchester, Taylor Wall, Calvin Gavin

**Library Managment System**

This project is a Library Management System for a Library called Bargain Bins Books Library. 

It allows managing books, CDs, members, inventory, and loans using a MySQL database and a Python CLI application. 

Users can add, update, delete, and view books, CDs, members, inventory items, and loans.

**Requirements:**
-------------
Python 3 (version 3.8 or higher recommended)


MySQL Server (tested on MySQL 8.x)


Python packages:


mysql-connector-python


**Project/File Structure:**
---------------------------

LibraryProject/


├── LibraryProject.sql          # SQL dump of the database


├── library_cli.py              # Python CLI application


├── Library-ER-Diagram.mwb      # MySQL Workbench ER diagram


├── queries.sql                  # Test queries


├── README.md                   # This file



**Setup Instructions:**
-------------------
1. Install Python
Download and install Python 3 from python.org.

    Verify installation in terminal:

        python3 --version

2. Install MySQL Server
  Download and install MySQL Community Server from dev.mysql.com.

    Make note of your root user credentials (username and password).

3. Install Python MySQL Connector

    Open a terminal and run:
   
        pip install mysql-connector-python

5. Set Up Database

   Open your terminal and create the database:
    
           mysql -u root -p
   Then inside MySQL create the database:
    
        CREATE DATABASE mydb;
        EXIT;
    
   Import the database SQL dump:
    
        mysql -u root -p mydb < LibraryProject.sql
    
   Enter your password if prompted.

    This will create all tables (book, cd, member, inventory, loan) and populate sample data.

**Running the Python CLI**
----------------------
1. Make sure MySQL server is running.

   On macOS with MySQL installed via Homebrew:

        brew services start mysql
   
    On Windows, start the MySQL service from the Services app or XAMPP/WAMP control      panel.
   
    On Linux (Ubuntu):

       sudo service mysql start

3. Open a terminal in the project directory.
  
        cd LibraryProject
   
5. Run the CLI script:

        python3 library_cli.py

8. You will be prompted to enter the database name (mydb) and MySQL password.
   
3. Use the numbered menu to:
   
    Manage books
   
    Manage CDs
   
    Manage Members

    Manage Inventory

    Manage Loans

    or

    Exit Program

All actions interact directly with the MySQL database.

**Test queries:**
------------------
To test the queries in the queries.sql file, enter the following command in the terminal (Make sure you are in LibraryProject folder): 

            mysql -u root -p mydb < queries.sql 
            
This command will run the files without entering the MySQL shell.
It will run SELECT queries and print results into the terminal.
