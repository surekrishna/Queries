-- below query will get the current month and date plus one month including date, for eg:- 23-03 to 23-04
select * from employee where to_char(dob, 'MMDD') between to_char(current_date, 'MMDD') and to_char(current_date + 30, 'MMDD')
