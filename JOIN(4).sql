CREATE TABLE books(
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE CHECK (title ~ '^[\u0621-\u064A\s]+$'),
    author  VARCHAR(100) NOT NULL CHECK (author ~ '^[\u0621-\u064A\s]+$'),
    total_copies  INTEGER NOT NULL CHECK (total_copies > 0),
    available_copies  INTEGER NOT NULL CHECK (available_copies > 0)
);

INSERT INTO books (title,author,total_copies,available_copies) VALUES
('تاريخ سوريا','عبد الكريم بكار',300,300),
('نظم المعلومات','أسامة الزيرو',200,200),
('هندسة البرمجيات','راما الرفاعي',250,250);


CREATE TABLE borrowings (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    book_id INTEGER REFERENCES books(id),
    borrow_date DATE DEFAULT CURRENT_DATE,
    due_date DATE CHECK (due_date >= borrow_date),
    return_date DATE DEFAULT NULL CHECK (return_date >= due_date),
    fine  INTEGER DEFAULT 0
);

INSERT INTO borrowings (user_id,book_id,due_date) VALUES
(1,1,'2026-10-5'),
(2,1,'2026-10-10');

--INER JOIN
SELECT users.full_name,books.title FROM users 
INNER JOIN borrowings ON users.id = borrowings.user_id
INNER JOIN books ON books.id = borrowings.book_id;

--LEFT JOIN
SELECT users.full_name,books.title FROM users 
LEFT JOIN borrowings ON users.id = borrowings.user_id
LEFT JOIN books ON books.id = borrowings.book_id;

--RIGHT JOIN
SELECT users.full_name,borrowings.book_id FROM users 
RIGHT JOIN borrowings ON users.id = borrowings.user_id;

--FULL JOIN
SELECT users.full_name,borrowings.book_id FROM users 
FuLL JOIN borrowings ON users.id = borrowings.user_id;


--CROSS JOIN
SELECT users.full_name,books.title FROM users 
CROSS JOIN books;