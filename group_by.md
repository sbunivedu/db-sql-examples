# SQL Exercise: Mastering GROUP BY and HAVING Clauses

GROUP BY and HAVING clauses in SQL are essential for performing aggregate operations on grouped data and filtering the results based on group conditions.

## Sample Data

Here's the sample data for this exercise in table format:

### Students Table

| StudentID | Name           | Major             | GPA |
|-----------|----------------|-------------------|-----|
| 1         | Alice Johnson  | Computer Science  | 3.8 |
| 2         | Bob Smith      | Mathematics       | 3.5 |
| 3         | Charlie Brown  | Physics           | 3.2 |
| 4         | Diana Ross     | Computer Science  | 3.9 |
| 5         | Edward Lee     | Mathematics       | 3.6 |

### Courses Table

| CourseID | CourseName                  | Department       | Credits |
|----------|-----------------------------| -----------------|---------|
| 101      | Introduction to Programming | Computer Science | 3       |
| 102      | Data Structures             | Computer Science | 4       |
| 201      | Calculus I                  | Mathematics      | 4       |
| 202      | Linear Algebra              | Mathematics      | 3       |
| 301      | Quantum Mechanics           | Physics          | 4       |

### Enrollments Table

| EnrollmentID | StudentID | CourseID | Semester    | Grade |
|--------------|-----------|----------|-------------|-------|
| 1            | 1         | 101      | Fall 2023   | A     |
| 2            | 1         | 102      | Spring 2024 | B     |
| 3            | 2         | 201      | Fall 2023   | A     |
| 4            | 2         | 202      | Spring 2024 | A     |
| 5            | 3         | 301      | Fall 2023   | B     |
| 6            | 4         | 101      | Fall 2023   | A     |
| 7            | 4         | 102      | Spring 2024 | A     |
| 8            | 5         | 201      | Fall 2023   | B     |
| 9            | 5         | 202      | Spring 2024 | A     |

## Exercise Instructions

1. Read each question carefully.
2. Write a SQL query to answer the question.
3. Test your query against the sample data provided above.
4. Verify that your results match the expected output (if provided).
5. If you're stuck, try breaking down the problem into smaller steps.

## Questions

1. Find the average GPA for each major, but only show majors with an average GPA above 3.5.
   - Hint: Use GROUP BY on the Major column and HAVING with AVG(GPA).
```
Expected Output:
Major            | AverageGPA
-----------------|-----------
Computer Science | 3.85
Mathematics      | 3.55
```
2. List the courses with more than 2 students enrolled, along with the number of students in each course.
   - Hint: Join the Courses and Enrollments tables, then use GROUP BY and HAVING.
```
Expected Output:
CourseID | CourseName                  | StudentCount
---------|-----------------------------|--------------
101      | Introduction to Programming | 3
102      | Data Structures             | 3
```
3. Show the students who have taken courses in more than one department, along with the number of departments they've studied in.
   - Hint: This requires joining Students, Enrollments, and Courses tables, then using GROUP BY and HAVING.
```
Expected Output:
StudentID | Name          | DepartmentCount
----------|---------------|------------------
1         | Alice Johnson | 2
2         | Bob Smith     | 2
4         | Diana Ross    | 2
5         | Edward Lee    | 2
```
4. Find the departments where the average course credits are greater than 3.5.
   - Hint: Group by the Department in the Courses table and use HAVING with AVG(Credits).
```
Expected Output:
Department       | AverageCredits
-----------------|-----------------
Computer Science | 3.5
Mathematics      | 3.5
Physics          | 4.0
```
5. List the students who have received all A grades, along with the number of courses they've taken (minimum 2 courses).
   - Hint: This requires grouping by StudentID and using HAVING with multiple conditions.
```
Expected Output:
StudentID | Name       | CourseCount
----------|------------|-------------
4         | Diana Ross | 2
```
## Tips

- Always start by selecting and examining the relevant columns from the necessary tables.
- Use JOIN operations when you need data from multiple tables.
- The GROUP BY clause should include all non-aggregated columns in your SELECT statement.
- Use aggregate functions (COUNT, AVG, SUM, etc.) in combination with GROUP BY.
- The HAVING clause filters groups, while the WHERE clause filters individual rows.
- Test your queries with smaller parts of the problem before combining them into the final solution.
