CREATE VIEW user_borrowed_books AS SELECT users.full_name,books.title FROM users 
INNER JOIN borrowings ON users.id = borrowings.user_id
INNER JOIN books ON books.id = borrowings.book_id;

CREATE OR REPLACE VIEW user_borrowed_books AS SELECT users.full_name,books.title,borrowings.borrow_date FROM users 
INNER JOIN borrowings ON users.id = borrowings.user_id
INNER JOIN books ON books.id = borrowings.book_id;

SELECT * FROM user_borrowed_books;

SELECT * FROM user_borrowed_books WHERE full_name = 'Amina Rajoub';

DROP VIEW IF EXISTS user_borrowed_books;

