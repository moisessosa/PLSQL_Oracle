CREATE OR REPLACE PACKAGE regiones IS
PROCEDURE alta_region(codigo NUMBER,nombre VARCHAR2 );
PROCEDURE baja_region(codigo NUMBER );
PROCEDURE mod_region(codigo NUMBER,nombre VARCHAR2 );
FUNCTION con_region(codigo NUMBER) RETURN VARCHAR2;
--FUNCTION existe_region(codigo NUMBER ) RETURN boolean;
END regiones;
/
CREATE OR REPLACE PACKAGE BODY regiones IS

FUNCTION existe_region(codigo NUMBER) RETURN BOOLEAN IS

reg number;
begin
    
    select region_id into reg from regions where region_id=codigo;
    --dbms_output.put_line(reg);
    return true;
    EXCEPTION
        when NO_DATA_FOUND THEN
        --dbms_output.put_line('***');
        return false;
end existe_region;
PROCEDURE alta_region(codigo NUMBER,nombre VARCHAR2 ) is
existe boolean;
Begin --alta_region
    existe:= existe_region(codigo);
    if existe = true then
        dbms_output.put_line('La región ya existe.');
    else
        INSERT INTO regions VALUES (codigo,nombre);
        commit;
    end if;
    exception
    when others then
        dbms_output.put_line('ERROR AL GUARDAR EN LA TABLA');
END alta_region;

PROCEDURE baja_region(codigo NUMBER )IS
existe boolean;
BEGIN
    EXISTE := existe_region(codigo);
    IF existe = true then
        delete from regions where region_id = codigo;
        commit;
        dbms_output.put_line('se borro');
    else
        dbms_output.put_line('Nada que borra porque la region no existe');
    end if;
    exception
    when others then
        dbms_output.put_line('ERROR AL BORRAR EN LA TABLA');
END baja_region;

PROCEDURE mod_region(codigo NUMBER,nombre VARCHAR2) IS
existe boolean;
BEGIN --mod_region
    EXISTE := existe_region(codigo);
    IF existe = true then
        UPDATE regions SET REGION_NAME = nombre where region_id = codigo;
        commit;
        dbms_output.put_line('se MODIFICO');
    else
        dbms_output.put_line('Nada que modificar porque la region no existe');
    end if;
    exception
    when others then
        dbms_output.put_line('ERROR AL MODIFICAR EN LA TABLA');
END mod_region;

FUNCTION con_region(codigo NUMBER ) RETURN VARCHAR2 IS
reg varchar2(25);
BEGIN --con_region
    select region_NAME into reg from regions where region_id=codigo;
    --dbms_output.put_line(reg);
    return reg;
    EXCEPTION
        when NO_DATA_FOUND THEN
        --dbms_output.put_line('***');
        return 'Region no existe';

END con_region;

end regiones;
/

-- PRUEBAS
SELECT * FROM REGIONS;

begin
    dbms_output.put_line(REGIONES.con_region(2)); --PROBAMOS OBTENER UNA REGION PASANDO EL ID
    REGIONES.ALTA_REGION(6,'vALCANES'); -- ADICIONAMOS UNA NUEVA REGION
    
    dbms_output.put_line(REGIONES.con_region(6)); -- PROBAMOS SI LA ADICIONO A LA BASE DE DATOS
    REGIONES.MOD_REGION(6,'BALCANES');-- MODIFICAMOS LA REGION CORRIGIENDO EL NOMBRE
    
    dbms_output.put_line(REGIONES.con_region(6)); -- PROBAMOS SI LA MODIFICO A LA BASE DE DATOS
    REGIONES.BAJA_REGION(6);--ELIMINAMOS LA REGION

REGIONES.MOD_REGION(6,'BALCANES');--QUE PASA AL ELIMINAR UNA REGION QUE NO EXITE, DA UN MENSAJE 
REGIONES.ALTA_REGION(5,'LOQUE SEA');--QUE PASA SI ADICCIONAMOS REGION CON CODIGO QUE YA EXISTE, NO DEJA
END;
/

SELECT * FROM REGIONS;

-- paquetes de funciones

CREATE OR REPLACE PACKAGE NOMINA as
Function CALCULAR_NOMINA(SALARIO NUMBER) RETURN NUMBER;
Function CALCULAR_NOMINA(SALARIO NUMBER, PORCENTAJE NUMBER) RETURN NUMBER;
Function CALCULAR_NOMINA(SALARIO NUMBER, PORCENTAJE NUMBER, V VARCHAR2) RETURN NUMBER;
END NOMINA;
/
CREATE OR REPLACE PACKAGE BODY NOMINA as
Function CALCULAR_NOMINA(SALARIO NUMBER) RETURN NUMBER AS
salario_neto number:=0;
BEGIN --CALCULAR_NOMINA(SALARIO NUMBER) 
    salario_neto:=salario * 0.85;
    return salario_neto;

END CALCULAR_NOMINA;

Function CALCULAR_NOMINA(SALARIO NUMBER, PORCENTAJE NUMBER)  RETURN NUMBER AS
salario_neto number:=0;
BEGIN --CALCULAR_NOMINA(SALARIO NUMBER) 
    return salario * ((100-porcentaje)/100);

END CALCULAR_NOMINA;

Function CALCULAR_NOMINA(SALARIO NUMBER, PORCENTAJE NUMBER, V VARCHAR2) RETURN NUMBER AS
salario_neto number:=0;
sal number :=0;
BEGIN --CALCULAR_NOMINA(SALARIO NUMBER) 
    if V = 'V' then
        sal := SALARIO * 1.2;
    end if;
    salario_neto := salario * (porcentaje/100);
    salario_neto := sal - salario_neto;
    return salario_neto;

END CALCULAR_NOMINA;

END NOMINA;
/
-- pruebas de funciones dentro del paquete
select FIRST_NAME, LAST_NAME, nomina.CALCULAR_NOMINA(salary, 50, 'V') from employees;
select FIRST_NAME, LAST_NAME, nomina.CALCULAR_NOMINA(salary, 20) from employees;
select FIRST_NAME, LAST_NAME, nomina.CALCULAR_NOMINA(salary) from employees;

