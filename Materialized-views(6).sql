

CREATE MATERIALIZED VIEW user_borrowing_stats AS SELECT  users.id,users.full_name,
COUNT(borrowings.id) AS borrowing_count FROM users 
LEFT JOIN borrowings ON users.id = borrowings.user_id GROUP BY users.id;

SELECT * FROM user_borrowing_stats;

INSERT INTO users (full_name,email,phone) VALUES
('Omar Rajoub','Omar766666666@gmail.com','0912305678');

INSERT INTO borrowings (user_id,book_id,due_date) VALUES
(4,3,'2026-10-5');

SELECT * FROM user_borrowing_stats;

REFRESH MATERIALIZED VIEW user_borrowing_stats;

SELECT * FROM user_borrowing_stats;

--DROP MATERIALIZED VIEW IF EXISTS user_borrowings;

