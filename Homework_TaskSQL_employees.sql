CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE,
    manager_id INT,
    status VARCHAR(20) -- e.g. 'active', 'resigned'
);

CREATE TABLE managers (
    manager_id INT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO managers (manager_id, name) VALUES
(1, 'Anna Miller'),
(2, 'Lukas Becker'),
(3, 'Sandra Mahno');

INSERT INTO employees (emp_id, name, department, salary, hire_date, manager_id, status) VALUES
(101, 'Tom Schneider', 'IT', 5500, '2022-03-15', 1, 'active'),
(102, 'Julia Meier', 'HR', 4200, '2021-07-01', 2, 'active'),
(103, 'Mark Weber', 'IT', 5800, '2023-01-20', 1, 'active'),
(104, 'Nina Hofmann', 'Marketing', 4700, '2020-11-10', 2, 'resigned'),
(105, 'Paul Braun', 'Finance', 6300, '2022-06-01', 3, 'active'),
(106, 'Laura Vogel', 'Finance', 6300, '2023-02-12', 3, 'active'),
(107, 'Felix Hartmann', 'IT', 5800, '2023-09-01', 1, 'active'),
(108, 'Emma König', 'HR', 3900, '2024-02-15', NULL, 'active');



-- Task 1: Select all data from table (Task: Retrieve all columns from the employees table)
-- Завдання 1: Вибрати всі дані з таблиці (Отримати всі стовпці з таблиці employees)
SELECT * FROM employees;

-- Task 2: Filtering with WHERE (Task: Get all employees who work in the 'IT' department)
-- Завдання 2: Фільтрація за допомогою WHERE (Отримати всіх працівників, які працюють у відділі 'IT')
SELECT * FROM employees
WHERE department = 'IT';

-- Task 3: Use of ORDER BY (Task: Show employees ordered by salary in descending order)
-- Завдання 3: Сортування з ORDER BY (Показати працівників у порядку спадання зарплати)
SELECT name, salary FROM employees
ORDER BY salary DESC;

-- Task 4: Aggregate Function (COUNT) (Task: Count the number of employees in the company)
-- Завдання 4: Агрегатна функція COUNT (Порахувати кількість працівників у компанії)
SELECT COUNT(*) AS total_employees FROM employees;

-- Task 5: GROUP BY (Task: Show the number of employees in each department)
-- Завдання 5: Групування (Показати кількість працівників у кожному відділі)
SELECT department, COUNT(*) AS total
FROM employees
GROUP BY department;

-- Task 6: JOIN two tables (Task: Show employee names and their manager names)
-- Завдання 6: Об’єднання двох таблиць (Показати імена працівників і їхніх менеджерів)
SELECT e.name AS employee_name, m.name AS manager_name
FROM employees e
JOIN managers m ON e.manager_id = m.manager_id;

-- Task 7: Subquery (Task: Get employees who earn more than the average salary)
-- Завдання 7: Підзапит (Отримати працівників, які заробляють більше за середню зарплату)
SELECT * FROM employees
WHERE salary > (
    SELECT AVG(salary) FROM employees
);

-- Task 8: UPDATE (Task: Increase the salary of all IT employees by 10%)
-- Завдання 8: Оновлення даних (Підвищити зарплату всім працівникам IT-відділу на 10%)
UPDATE employees
SET salary = salary * 1.1
WHERE department = 'IT';

-- Task 9: DELETE (Task: Delete all employees who have left the company)
-- Завдання 9: Видалення записів (Видалити всіх працівників, які залишили компанію)
DELETE FROM employees
WHERE status = 'resigned';

-- Task 10: INSERT (Task: Add a new employee to the employees table)
-- Завдання 10: Додавання нового запису (Додати нового працівника до таблиці employees)
INSERT INTO employees (name, department, salary)
VALUES ('John Doe', 'Marketing', 4500);

-- Task 11: Find the 2nd highest salary in the company
-- Завдання 11: Знайти другу за величиною зарплату в компанії
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (
    SELECT MAX(salary) FROM employees
);

-- Task 12: Get departments with average salary above 5000
-- Завдання 12: Отримати відділи зі середньою зарплатою вище 5000
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 5000;

-- Task 13: List employees who don’t have a manager
-- Завдання 13: Список працівників без менеджера
SELECT name
FROM employees
WHERE manager_id IS NULL;

-- Task 14: Find the number of employees hired in each year
-- Завдання 14: Кількість працівників, прийнятих на роботу щороку
SELECT YEAR(hire_date) AS year_hired, COUNT(*) AS total
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY year_hired;

-- Task 15: List employees hired more recently than their managers
-- Завдання 15: Працівники, яких найняли пізніше, ніж їх менеджерів
SELECT e.name AS employee, m.name AS manager
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id
WHERE e.hire_date > m.hire_date;

-- Task 16: List departments with more than 3 employees
-- Завдання 16: Відділи з більше ніж 3 працівниками
SELECT department, COUNT(*) AS emp_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 3;

-- Task 17: Find employees with the same salary
-- Завдання 17: Знайти працівників із однаковою зарплатою
SELECT e1.name, e1.salary
FROM employees e1
JOIN employees e2 ON e1.salary = e2.salary AND e1.emp_id <> e2.emp_id;

-- Task 18: Show all managers and their team size
-- Завдання 18: Показати всіх менеджерів і розмір їхніх команд
SELECT m.name AS manager_name, COUNT(e.emp_id) AS team_size
FROM managers m
LEFT JOIN employees e ON m.manager_id = e.manager_id
GROUP BY m.name;

-- Task 19: Employees who earn above the average of their department
-- Завдання 19: Працівники, які заробляють більше за середнє по відділу
SELECT e.name, e.department, e.salary
FROM employees e
JOIN (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
) d_avg ON e.department = d_avg.department
WHERE e.salary > d_avg.avg_salary;

-- Task 20: Find the highest paid employee in each department
-- Завдання 20: Найвисокооплачуваніший працівник у кожному відділі
SELECT e.name, e.department, e.salary
FROM employees e
JOIN (
    SELECT department, MAX(salary) AS max_salary
    FROM employees
    GROUP BY department
) d_max ON e.department = d_max.department AND e.salary = d_max.max_salary;

