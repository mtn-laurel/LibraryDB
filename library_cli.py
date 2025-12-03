import mysql.connector 
from mysql.connector import errorcode

def connect_db():
    try:
        cnx = mysql.connector.connect(
            host='localhost',
            database='mydb',
            user='root',
            password=input("Enter MySQL password (leave blank if none): ")
        )
        return cnx
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Wrong user ame or password.")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist.")
        else:
            print(err)
    else:
        cnx.close()

# ---------BOOK FUNCTIONS------------------

#-------ADD-------
def add_book(cnx):
    cursor = cnx.cursor()
    isbn = input("Enter ISBN (ex: 1234567890): ")
    title = input("Enter title: ")
    author = input("Enter author: ")
    genre = input("Enter genre: ")
    publisher = input("Enter publisher: ")
    department = input("Enter department (kids/teens/adults): ")

    query = "INSERT INTO book (ISBN, title, author, genre, publisher, department) VALUES (%s, %s, %s, %s, %s, %s)"
    values = (isbn, title, author, genre, publisher, department)

    try:
        cursor.execute(query, values)
        cnx.commit()
        print("Book added successfully")
    except mysql.connector.Error as e:
        print(f"Error: {e}")


#------UPDATE----------
def update_book(cnx):
    cursor = cnx.cursor()
    isbn = input("Enter ISBN of the book to update: ")
    new_title = input("Enter new title: ")
    query = "UPDATE book SET title=%s WHERE ISBN=%s"

    try: 
        cursor.execute(query, (new_title, isbn))
        cnx.commit()
        print("Book updated successfully")
    except mysql.connector.Error as e:
        print(f"Error: {e}")


#--------DELETE--------
def delete_book(cnx):
    cursor = cnx.cursor()
    isbn = input("Enter ISBN of book to delete: ")
    query = "DELETE FROM book WHERE ISBN=%s"

    try:
        cursor.execute(query, (isbn,))
        cnx.commit()
        print("Book deleted successfully")
    except mysql.connector.Error as e:
        print(f"Error: {e}")

#--------VIEW----------
def view_books(cnx):
    cursor = cnx.cursor()
    cursor.execute("SELECT * FROM book")
    rows = cursor.fetchall()
    print("\nAll Books:")
    print("---------------------------------------------------------")
    print("ISBN | Title | Author | Genre | Publisher | Department")
    print("---------------------------------------------------------")
    for row in rows:
        print(" | ".join(str(x) for x in row))


#-----------------CD FUNCTIONS-------------------

#---------ADD----------
def add_cd(cnx):
    cursor = cnx.cursor()
    issn = input("Enter CD ISSN (ex: 123456789) : ")
    title = input("Enter title: ")
    artist = input("Enter artist: ")
    genre = input("Enter genre: ")
    record_label = input("Enter record label: ")
    department = input("Enter department (kids/teens/adults): ")
    
    query = "INSERT INTO cd (issn, genre, artist, title, record_label, department) VALUES (%s, %s, %s, %s, %s, %s)"
    values = (issn, genre, artist, title, record_label, department)

    try:
        cursor.execute(query, values)
        cnx.commit()
        print("CD added successfully")
    except mysql.connector.Error as e:
        print(f"Error: {e}")

#--------UPDATE---------
def update_cd(cnx):
    cursor = cnx.cursor()
    issn = input("Enter ISSN of the CD to update: ")
    new_title = input("Enter new title: ")
    query = "UPDATE cd SET title=%s WHERE issn=%s"

    try:
        cursor.execute(query, (new_title, issn))
        cnx.commit()
        print("CD updated successfully")
    except mysql.connector.Error as e:
        print(f"Error: {e}")

#--------DELETE----------
def delete_cd(cnx):
    cursor = cnx.cursor()
    issn = input("Enter ISSN of the cd to delete: ")
    query = "DELETE FROM cd WHERE issn=%s"

    try: 
        cursor.execute(query, (issn,))
        cnx.commit()
        print("CD deleted successfully")
    except mysql.connector.Error as e:
        print(f"Error: {e}")

#--------VIEW--------------
def view_cds(cnx):
    cursor = cnx.cursor()
    cursor.execute("SELECT * FROM cd")
    rows = cursor.fetchall()
    print("\nAll CDs:")
    print("-------------------------------------------------------------")
    print("ISSN | Genre | Artist | Title | Record Label | Department ")
    print("-------------------------------------------------------------")
    for row in rows:
        print(" | ".join(str(x) for x in row))

#------------------MEMBER FUNCTIONS----------------

#------------ADD--------------
def add_member(cnx):
    cursor = cnx.cursor()
    member_id = int(input("Enter member ID (xxxx): "))
    name = input("Enter name: ")
    dob = input("Enter date of birth (YYYY-MM-DD): ")
    try:
        cursor.execute("INSERT INTO member (member_id, name, dob) VALUES (%s, %s, %s)", (member_id, name, dob))
        cnx.commit()
        print("Member added successfully")
    except mysql.connector.Error as e:
        print(f"Error: {e}")

#----------DELETE-------------
def delete_member(cnx):
    cursor = cnx.cursor()
    member_id = int(input("Enter member ID to delete (xxxx): "))
    try:
        cursor.execute("DELETE FROM member WHERE member_id=%s", (member_id))
        cnx.commit()
        print("Member deleted successfully")
    except mysql.connector.Error as e:
        print(f"Error: {e}")

#-----------VIEW-------------
def view_members(cnx):
    cursor = cnx.cursor()
    cursor.execute("SELECT * FROM member")
    rows = cursor.fetchall()
    print("-------------------------")
    print("Member ID | Name | DOB")
    print("-------------------------")
    for row in rows:
        print(" | ".join(str(x) for x in row))

#------------------INVENTORY FUNCTIONS-----------------

#-----------ADD-------------
def add_inventory(cnx):
    cursor = cnx.cursor()
    inventory_id = int(input("Enter inventory ID: "))
    book_id = input("Enter book ISBN (ex: 1234567890)(leave blank if CD): ").strip()
    cd_id = input("Enter CD ISSN (ex: 123456789)(leave blank if book): ").strip()
    book_id = book_id if book_id else None
    cd_id = cd_id if cd_id else None
    try:
        cursor.execute(
            "INSERT INTO inventory (inventory_id, book_id, cd_id) VALUES (%s,%s,%s)",
            (inventory_id, book_id, cd_id)
        )
        cnx.commit()
        print("Inventory item added successfully")
    except mysql.connector.Error as e:
        print(f"Error: {e}")

#-----------VIEW-------------
def view_inventory(cnx):
    cursor = cnx.cursor()
    cursor.execute("SELECT * FROM inventory")
    rows = cursor.fetchall()
    print("-------------------------------------")
    print("Inventory ID | Book ISBN | CD ISSN")
    print("-------------------------------------")
    for row in rows:
        print(" | ".join(str(x) for x in row))

#------------------LOAN FUNCTIONS-----------------

#----------ADD--------------
def issue_loan(cnx):
    cursor = cnx.cursor()
    loan_id = int(input("Enter loan ID: "))
    inventory_id = int(input("Enter inventory ID: "))
    member_id = int(input("Enter member ID: "))
    borrow_date = input("Enter borrow date (YYYY-MM-DD): ")
    due_date = input("Enter due date (YYYY-MM-DD): ")
    try:
        cursor.execute(
            "INSERT INTO loan (loan_id, inventory_id, member_id, borrow_date, due_date) VALUES (%s,%s,%s,%s,%s)",
            (loan_id, inventory_id, member_id, borrow_date, due_date)
        )
        cnx.commit()
        print("Loan issued successfully")
    except mysql.connector.Error as e:
        print(f"Error: {e}")

#---------RETURN----------
def return_loan(cnx):
    cursor = cnx.cursor()
    loan_id = int(input("Enter loan ID to return: "))
    return_date = input("Enter return date (YYYY-MM-DD): ")
    try:
        cursor.execute("UPDATE loan SET return_date=%s WHERE loan_id=%s", (return_date, loan_id))
        cnx.commit()
        print("Loan returned successfully")
    except mysql.connector.Error as e:
        print(f"Error: {e}")

#------------VIEW----------
def view_loans(cnx):
    cursor = cnx.cursor()
    cursor.execute("SELECT * FROM loan")
    rows = cursor.fetchall()
    print("---------------------------------------------------------------------------")
    print("Loan ID | Inventory ID | Member ID | Borrow Date | Return Date | Due Date")
    print("---------------------------------------------------------------------------")
    for row in rows:
        print(" | ".join(str(x) for x in row))


#--------------------------------MAIN MENU-------------------------------
def main():
    cnx = connect_db()
    if not cnx:
        return
    
    while True:
        print("\n\n--------------------------")
        print("Library Management CLI")
        print("--------------------------")
        print("BOOKS")
        print("1. Add book")
        print("2. Update book")
        print("3. Delete book")
        print("4. View all books")
        print("-------------------")
        print("CDS")
        print("5. Add CD")
        print("6. Update CD")
        print("7. Delete CD")
        print("8. View all CDs")
        print("-------------------")
        print("MEMBERS")
        print("10. Delete member")
        print("11. View members")
        print("-------------------")
        print("INVENTORY")
        print("12. Add inventory item")
        print("13. View inventory")
        print("-------------------")
        print("LOANS")
        print("14. Issue loan")
        print("15. Return loan")
        print("16. View loans")
        print("-------------------")
        print("EXIT")
        print("17. Exit Program\n\n")

        choice = input("Choose an option: ")
        menu_map = {
            '1': add_book, '2': update_book, '3': delete_book, '4': view_books,
            '5': add_cd, '6': update_cd, '7': delete_cd, '8': view_cds,
            '9': add_member, '10': delete_member, '11': view_members,
            '12': add_inventory, '13': view_inventory,
            '14': issue_loan, '15': return_loan, '16': view_loans
        }
        if choice == '17':
            print("Exiting CLI.")
            break
        elif choice in menu_map:
            menu_map[choice](cnx)
        else:
            print("Invalid choice. Try again.")

    cnx.close()

if __name__ == "__main__":
    main()