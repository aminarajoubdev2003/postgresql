CREATE TABLE employees(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    manager_id INTEGER REFERENCES employees(id)
);

INSERT INTO employees (name, manager_id) VALUES
('Ahmed', NULL),('Sara', 1),
('Lina', 1),('Omar', 2),
('Noor', 2);

WITH RECURSIVE employees_tree AS (
    SELECT id,name,manager_id FROM employees WHERE id = 1
    UNION ALL 
    SELECT employees.id,employees.name,employees.manager_id FROM employees INNER JOIN 
    employees_tree  ON  employees.manager_id = employees_tree.id
)
SELECT * FROM employees_tree;