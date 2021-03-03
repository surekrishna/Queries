-- below query will get the current month and date plus one month including date, for eg:- 23-03 to 23-04
select * from employee where to_char(dob, 'MMDD') between to_char(current_date, 'MMDD') and to_char(current_date + 30, 'MMDD')

-- created a function to get the employee details
CREATE OR REPLACE FUNCTION emp_details (employee_id bigint) 
   RETURNS TABLE (
	  emp_id bigint,
	  emp_first_name varchar(50),
	  emp_status varchar(20)
) 
LANGUAGE plpgsql
AS
$func$

BEGIN
RETURN QUERY SELECT id AS emp_id, first_name AS emp_first_name, emp_status AS status FROM employee where id = employee_id;
END; 

$func$

select emp_details(1)
