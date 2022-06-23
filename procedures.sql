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
