    -- 1. Crear una función que tenga como parámetro un número de departamento y 
    -- que devuelve la suma de los salarios de dicho departamento. La imprimimos por pantalla.
    -- • Si el departamento no existe debemos generar una excepción con dicho mensaje
 create or replace function SUMA_SALARIO_DEPT(n_dept number) return number is
 total number;
 dept DEPARTMENTS.department_id%TYPE;
 begin
    SELECT DEPARTMENT_ID INTO DEPT FROM DEPARTMENTS WHERE DEPARTMENT_ID=n_dept;
    select sum(salary) into total from employees where department_id = n_dept group by department_id;
    
    return total;
    exception
        when no_data_found then
        RAISE_APPLICATION_ERROR(-20001,'ERROR, DEPARTAMENTO '||n_dept|| ' NO EXISTE');
end;
/
declare
t number;
dep number:=100;
begin
    dbms_output.put_line('Total de salarios del departamento '||dep||' = '||SUMA_SALARIO_DEPT(dep));
end;
/

-- Modificar el programa anterior para incluir un parámetro de tipo OUT por el que vaya el número de empleados afectados por la query.
-- Debe ser visualizada en el programa que llama a la función. De esta forma vemos que se puede usar este tipo de parámetros también en una función
    
 create or replace function SUMA_SALARIO_DEPT(n_dept number, num_empl out number) return number is
  total number;
 dept DEPARTMENTS.department_id%TYPE;
 begin
    SELECT DEPARTMENT_ID INTO DEPT FROM DEPARTMENTS WHERE DEPARTMENT_ID=n_dept;
    select sum(salary), count(salary) into total, num_empl from employees where department_id = n_dept group by department_id;
    
    return total;
    exception
        when no_data_found then
        RAISE_APPLICATION_ERROR(-20001,'ERROR, DEPARTAMENTO '||n_dept|| ' NO EXISTE');
end;
/

declare
t_empl number;
dep number:=100;
begin
    dbms_output.put_line('Total de salarios del departamento '||dep||' = '||SUMA_SALARIO_DEPT(dep,t_empl));
    dbms_output.put_line('Numero de empleados: '||t_empl);
end;
/
--/**/
create or replace function CREAR_REGION(n_region varchar2) return number is


nombre_r VARCHAR2(100);
numero_reg number;
begin
    select REGION_NAME into nombre_r from regions where REGION_NAME= n_region;
    -- si la encuentra paramos el programa lanzando una exceptions
    raise_application_error(-20321,'Esta región ya existe!');
    exception
        when no_data_found then
        select max(REGION_ID) into numero_reg from regions;
        insert into REGIONS values(numero_reg+1, n_region);
        return numero_reg+1;
end;
/
declare
num number;
begin
num:=CREAR_REGION('Las Malvinas');
dbms_output.put_line('el numero assignado a la nueva region es: ',num);
end;
/
