--plsql study
--1.命名块
create or replace procedure show_avgsal(p_deptno number)
	as 
		v_sal number(6,2)
	begin
		select avg(salary) into v_sal from hr.employees
		where department_id = p_deptnol
		DBMS_OUTPUT.PUT_LINE(v_sal);
	end show_avgsal;

	--调用命名快
	begin
	show_avgsal(50);
	end;
--2.函数
create or replace function return_avgsal(p_deptno number)
return employees.salary%type
as
	v_sal number(6,2);
begin
	select avg(salary) into v_sal from employees
	where department_id = p_deptno;
	return(v_sal);
end return_avgsal;
	--调用函数
	begin
	DBMS_OUTPUT.PUT_LINE(return_avgsal(50));
	end;
--3.匿名块
declare
	v_sal employees.salary%type;
begin
	select salary into v_sal from employees
	where employees_id = 110;
	DBMS_OUTPUT.PUT_LINE(v_sal);
exception
	when no_data_found then
	DBMS_OUTPUT.PUT_LINE('There is not such an employee!');
end;
--4.触发器
create or replace trigger trg_example
after insert or update or delete
on employees
begin
if inserting then
DBMS_OUTPUT.PUT_LINE('The operation is inserting.');
elsif updating then
DBMS_OUTPUT.PUT_LINE('The operation is updating.');
else
DBMS_OUTPUT.PUT_LINE('The operation is deleting.');
end if;
end


--区分大小写的标识符
declare
"HELLO" varchar2(10):='hello1';
begin
	DBMS_OUTPUT.PUT_LINE("HELLO");
	DBMS_OUTPUT.PUT_LINE(hello);
	DBMS_OUTPUT.PUT_LINE('hello2');

end;

--rowid p55
select rowid,employee_id,first_name,last_name from employees;

--date
declare
v_dt date :=sysdate();
begin
DBMS_OUTPUT.PUT_LINE(v_dt);
end;

--nls param setting
select * from nls_session_parameters;
select * from nls_database_parameters;
select sysdate from dual;

--timestamp
declare
	v_tdt timestamp:=systimestamp();
begin
	DBMS_OUTPUT.PUT_LINE(v_tdt);
end;

--timestamp with time zone
declare
	 v_dtzl1 timestamp with time zone:=systimestamp;
	 v_dtzl2 timestamp(3) with time zone:=systimestamp;
begin
	DBMS_OUTPUT.PUT_LINE(v_dtzl1);
	DBMS_OUTPUT.PUT_LINE(v_dtzl2);
end;

--interval year to month
declare
	v_start_date timestamp := systimestamp();
	v_end_date timestamp := to_timestamp('2012-3-9','YYYY-MM-DD');
	v_result_date timestamp;
	v_interval1 interval year to month;
	v_interval2 interval year to month := interval '-2-4' year to month;
begin
	v_interval1 := (v_end_date-v_start_date) year to month;
	v_result_date := v_start_date+v_interval2;
	DBMS_OUTPUT.PUT_LINE(v_interval1);
	DBMS_OUTPUT.PUT_LINE(v_result_date);
end;

--interval day to second
declare
	v_start_date timestamp:=systimestamp;
	v_end_date timestamp:=to_timestamp('2012-9-3','YYYY-MM-DD');
	v_result_date timestamp;
	v_interval1 interval day(9) to second;
	v_interval2 interval day to second:=
				interval '2 10:30:30' day to second;
begin
	v_interval1 := (v_end_date-v_start_date) day to second;
	v_result_date := v_start_date+v_interval2;
	DBMS_OUTPUT.PUT_LINE(v_interval1);
	DBMS_OUTPUT.PUT_LINE(v_result_date);	
end;

--print boolean p63
create or replace procedure print_boolean(b boolean)
as
begin
	DBMS_OUTPUT.PUT_LINE(
		case when b is null then 'Unknown'
			 when b then 'Yes'
			 when not b then 'No'
		   end);
end;

begin
print_boolean(true);
print_boolean(false);
print_boolean(null);
end;

--bool2 p63

create or replace function f(x boolean, y pls_integer)
  return employees.employee_id%type as
begin
  if x then
    return y;
  else
    return 2 * y;
  end if;
end;

commit;

declare
  name employees.last_name%type;
  b boolean := TRUE;
begin
  select last_name into name from employees where employee_id = f(b,100);
  DBMS_OUTPUT.PUT_LINE(name);
  b := false;
  select last_name into name  from employees where employee_id = f(b,100);
  DBMS_OUTPUT.PUT_LINE(name);
end;
