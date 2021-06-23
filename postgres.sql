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

-- the below query can apply nulls last for multiple columns
SELECT * FROM client ORDER BY CASE WHEN filecount IS NOT NULL THEN 0 ELSE 1 END, ID DESC;
reference -> https://dbfiddle.uk/?rdbms=postgres_9.6&fiddle=4d9e94508dc1348d56f3bd5130b64c33

-- below query will get connections made from particalar ip address
/*pga4dash*/
SELECT
    pid,
    datname,
    usename,
    application_name,
    client_addr,
    to_char(backend_start, 'YYYY-MM-DD HH24:MI:SS TZ') AS backend_start,
    state,
    wait_event_type || ': ' || wait_event AS wait_event,
    pg_blocking_pids(pid) AS blocking_pids,
    query,
    to_char(state_change, 'YYYY-MM-DD HH24:MI:SS TZ') AS state_change,
    to_char(query_start, 'YYYY-MM-DD HH24:MI:SS TZ') AS query_start,
    backend_type
FROM
    pg_stat_activity
WHERE client_addr = '127.0.0.1' and
    datname = (SELECT datname FROM pg_database WHERE oid = 16392)ORDER BY pid
    
-- the below query is used to get the details like did, datname, datallowconn, serverencoding, cancreate, datlastsysold details
SELECT
    db.oid as did, db.datname, db.datallowconn,
    pg_encoding_to_char(db.encoding) AS serverencoding,
    has_database_privilege(db.oid, 'CREATE') as cancreate, datlastsysoid
FROM
    pg_database db
WHERE db.oid = 16392

-- To get the list of indexs
select * from pg_indexes WHERE schemaname = 'hrms_dev'
-- Default index created
CREATE UNIQUE INDEX "employee_leavePK" ON hrms_dev.employee_leave USING btree (id)
--custom index created
CREATE INDEX employee_emp_id_date_idx ON public.employee USING btree (employee_id, date)
