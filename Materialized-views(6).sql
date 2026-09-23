CREATE MATERIALIZED VIEW user_borrowings AS SELECT users.full_name,books.title FROM users 
INNER JOIN borrowings ON users.id = borrowings.user_id
INNER JOIN books ON books.id = borrowings.book_id;

SELECT * FROM user_borrowings;

INSERT INTO users (full_name,email,phone) VALUES
('Omar Rajoub','Omar766666666@gmail.com','0912305678');

INSERT INTO borrowings (user_id,book_id,due_date) VALUES
(8,3,'2026-10-5');

REFRESH MATERIALIZED VIEW user_borrowings;

DROP MATERIALIZED VIEW IF EXISTS user_borrowings;

CREATE MATERIALIZED VIEW user_borrowing_stats AS SELECT  users.id,users.full_name,
COUNT(borrowings.id) AS borrowing_count FROM users 
LEFT JOIN borrowings ON users.id = borrowings.user_id GROUP BY users.id;

SELECT * FROM user_borrowing_stats;