CREATE DATABASE postgresql;

\c postgresql

CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email  VARCHAR(100) UNIQUE
);

ALTER TABLE users ADD COLUMN phone VARCHAR(10);

ALTER TABLE users RENAME COLUMN name to full_name;

--TRUNCATE TABLE users;
--DROP TABLE users;