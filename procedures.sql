set serveroutput on
create or replace procedure VISUALIZAR(DEPT EMPLOYEES.DEPARTMENT_ID%TYPE) is

cursor empleado is select first_name, last_name, salary from EMPLOYEES WHERE DEPARTMENT_ID = DEPT; 
begin
-- select first_name, last_name, salary from EMPLOYEES;
for i in empleado loop

    dbms_output.put_line(i.first_name || ' '|| i.last_name || ' ' ||i.salary);
end loop;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        
        dbms_output.put_line('NO EXISTE EL DEPARTAMENTO');
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR ');

end VISUALIZAR;
/
EXECUTE VISUALIZAR(110);
-- version 2
-- tieme parameto tipo out para el total de empleados
create or replace procedure VISUALIZAR(DEPT EMPLOYEES.DEPARTMENT_ID%TYPE, t out number) is

cursor empleado is select first_name, last_name, salary from EMPLOYEES WHERE DEPARTMENT_ID = DEPT; 
begin
t:=0;
for i in empleado loop
    t := t+1;
    dbms_output.put_line(i.first_name || ' '|| i.last_name || ' ' ||i.salary);
end loop;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        
        dbms_output.put_line('NO EXISTE EL DEPARTAMENTO');
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR ');

end VISUALIZAR;
/
declare
total number;
depart number:=100;
begin
VISUALIZAR(depart, total);
dbms_output.put_line('Total de empleados en el departamento '||depart|| ' es de: '|| total); 
end;
/
