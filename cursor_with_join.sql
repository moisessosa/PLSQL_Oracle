SET SERVEROUTPUT ON
--select FIRST_NAME, LAST_NAME,DEPARTMENT_NAME, JOB_TITLE from employees e
--            inner join DEPARTMENTS d on d.DEPARTMENT_ID = e.DEPARTMENT_ID
--            inner join jobs j on j.JOB_ID = e.JOB_ID;
-- este es el select que sera el cursor
declare

cursor c is select e.FIRST_NAME as nombre, e.LAST_NAME as apellido,d.DEPARTMENT_NAME as dept, j.JOB_TITLE as titulo 
            from employees e
            inner join DEPARTMENTS d on d.DEPARTMENT_ID = e.DEPARTMENT_ID
            inner join jobs j on j.JOB_ID = e.JOB_ID;
begin

    for i in c loop
        dbms_output.put_line(i.nombre || ' '|| i.apellido || ' ' || i.dept || ' '|| i.titulo);
    end loop;
    
end;
/

-- version 2
-- esta segunda version usa el atributo c%rowcount y un record tipo rowtype con los tipos del cursor
declare
cursor c is select e.FIRST_NAME as nombre, e.LAST_NAME as apellido,d.DEPARTMENT_NAME as dept, j.JOB_TITLE as titulo 
            from employees e
            inner join DEPARTMENTS d on d.DEPARTMENT_ID = e.DEPARTMENT_ID
            inner join jobs j on j.JOB_ID = e.JOB_ID;
emple_info c%rowtype;

begin
    open c;
loop
    fetch c into emple_info;
    exit when c%notfound;
    dbms_output.put_line(emple_info.nombre || ' '|| emple_info.apellido || ' ' || emple_info.dept || ' '|| emple_info.titulo);
end loop;
    dbms_output.put_line('encontre: '|| c%rowcount || ' Empleados');
    close c;
end;
/

    
