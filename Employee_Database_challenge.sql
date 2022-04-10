-- DELIVERABLE 1

-- creating the retirement_titles table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;
-- Show the table
SELECT * FROM retirement_titles;

-- remove the duplicate employees and create a unique titles table
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	ti.title
INTO unique_titles
FROM employees as e
JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
	AND (ti.to_date = '9999-01-01')
ORDER BY emp_no ASC, to_date DESC;
-- Show the table 
SELECT * FROM unique_titles;

-- retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.emp_no) DESC;
-- Show the table
SELECT * FROM retiring_titles;


-- DELIVERABLE 2

-- create the mentor_eligible table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentor_eligible
FROM employees as e
JOIN dept_emp as de
ON e.emp_no = de.emp_no
JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no ASC;
-- show the table
SELECT * FROM mentor_eligible;