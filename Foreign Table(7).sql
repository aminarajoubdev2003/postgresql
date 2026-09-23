CREATE DATABASE postgresql_remote;

CREATE TABLE remote_users(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email  VARCHAR(100) UNIQUE NOT NULL
);

ALTER TABLE remote_users RENAME COLUMN name to full_name;

INSERT INTO remote_users (full_name, email) VALUES
('Lina', 'lina676@gmail.com'),
('Khaled', 'khaled@gmail.com'),
('Nour', 'nour@gmail.com');

--In postgresql
CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER remote_server FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (
    host 'localhost',
    port '5432',
    dbname 'postgresql_remote'
);

CREATE USER MAPPING FOR CURRENT_USER
SERVER remote_server
OPTIONS (
    user 'postgres',
    password ''
);

CREATE FOREIGN TABLE remote_users (
    id INTEGER,
    full_name VARCHAR(100),
    email VARCHAR(150)
)
SERVER remote_server
OPTIONS (
    schema_name 'public',
    table_name 'remote_users'
);

SELECT * FROM remote_users;
SELECT * FROM remote_users WHERE id = 1;
SELECT * FROM remote_users ORDER BY full_name DESC;

SELECT users.full_name,remote_users.email FROM users 
INNER JOIN remote_users ON users.full_name = remote_users.full_name

