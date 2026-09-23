CREATE DATABASE postgresql_remote;

\c postgresql_remote

CREATE TABLE remote_users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);

INSERT INTO remote_users (full_name, email) VALUES
('Lina', 'lina@example.com'),
('Khaled', 'khaled@example.com'),
('Nour', 'nour@example.com');

\c postgresql

CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER remote_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (
    host 'localhost',
    port '5432',
    dbname 'postgresql_remote'
);

CREATE USER MAPPING FOR CURRENT_USER
SERVER remote_server
OPTIONS (
    user 'postgres',
    password '1234'
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

SELECT *
FROM remote_users;