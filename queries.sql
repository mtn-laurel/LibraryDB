-- Looking for copy of Misery book that is avaialable --
SELECT *
FROM inventory
JOIN book ON book.isbn = inventory.book_id
WHERE
NOT EXISTS (
SELECT 1 FROM loan
WHERE loan.inventory_id = inventory.inventory_id
AND loan.return_date IS NULL)
AND book.title = 'Misery'
;

-- Show all outstanding book loans -- 
SELECT 
  inventory.inventory_id,
  member.name AS member_name, 
  book.title,
  loan.borrow_date,
  loan.due_date
FROM loan
LEFT JOIN inventory ON inventory.inventory_id = loan.inventory_id
LEFT JOIN book ON inventory.book_id = book.isbn
LEFT JOIN member ON member.member_id = loan.member_id
WHERE return_date IS NULL;

-- Show all outstanding cd loans --
SELECT 
  inventory.inventory_id,
  member.name,
  cd.title,
  loan.borrow_date,
  loan.due_date
FROM loan
LEFT JOIN inventory ON inventory.inventory_id = loan.inventory_id
LEFT JOIN cd ON inventory.cd_id = cd.issn
LEFT JOIN member ON member.member_id = loan.member_id
WHERE return_date IS NULL;

-- How many members are there --
SELECT count(*) FROM member;

-- Find all books about Mystery genre --
SELECT * FROM book 
WHERE genre = 'Mystery';