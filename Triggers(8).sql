CREATE TABLE users_audit(
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    action  VARCHAR(50) 
);

CREATE OR REPLACE FUNCTION log_user_insert() RETURNS TRIGGER LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO users_audit (user_id, action)
    VALUES (NEW.id, 'INSERT');
    RETURN NEW;
END;
$$;

CREATE TRIGGER after_user_insert AFTER INSERT ON users FOR EACH ROW EXECUTE FUNCTION log_user_insert();

INSERT INTO users (full_name, email, phone)
VALUES ('Khaled', 'khaled@example.com', '0955555555');

-------------------------------------------------------------------------------------------------------------
UPDATE books SET available_copies = books.total_copies - ( SELECT COUNT(*) FROM borrowings
    WHERE borrowings.book_id = books.id AND borrowings.return_date IS NULL
);

CREATE OR REPLACE FUNCTION decrement_available_copies() RETURNS TRIGGER LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE books SET available_copies = available_copies-1  WHERE id = NEW.book_id;
    RETURN NEW;
END;
$$;

CREATE TRIGGER after_borrowing_insert AFTER INSERT ON borrowings FOR EACH ROW EXECUTE FUNCTION decrement_available_copies();

INSERT INTO borrowings (user_id,book_id,due_date) VALUES
(2,3,'2026-10-5');
