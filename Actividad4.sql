-- Crear tipo objeto tNombre (actividad anterior)
CREATE TYPE tNombre AS OBJECT (
  NOMBRE VARCHAR2(50),
  APELLIDO1 VARCHAR2(50),
  APELLIDO2 VARCHAR2(50)
);
/

-- Crear tipo objeto tDireccion (creado durante el seguimiento de la unidad didáctica)
CREATE TYPE tDireccion AS OBJECT (
  CALLE VARCHAR2(50),
  CIUDAD VARCHAR2(50),
  PAIS VARCHAR2(50)
);
/

-- Crear tipo objeto tVendedor
CREATE TYPE tVendedor AS OBJECT (
  NIF VARCHAR2(9),
  NOMBRECOMPLETO tNombre,
  DIRECCION tDireccion,
  TLF VARCHAR2(25),
  ANTIGUEDAD DATE,
  TIPOCONTRATO VARCHAR2(30),

  -- Método getMeses()
  MEMBER FUNCTION getMeses RETURN NUMBER
);
/

-- Implementar el método getMeses()
CREATE TYPE BODY tVendedor AS
  MEMBER FUNCTION getMeses RETURN NUMBER IS
    meses NUMBER;
  BEGIN
    meses := TRUNC(MONTHS_BETWEEN(SYSDATE, ANTIGUEDAD));
    RETURN meses;
  END;
END;
/

-- Crear tabla VENDEDOR
CREATE TABLE VENDEDOR OF tVendedor;

-- Insertar tres vendedores de ejemplo
INSERT INTO VENDEDOR VALUES (
  '123456789',
  tNombre('Juan', 'Pérez', 'González'),
  tDireccion('Calle Principal', 'Ciudad A', 'País X'),
  '1234567890',
  TO_DATE('2020-01-01', 'YYYY-MM-DD'),
  'Contrato Tipo 1'
);

INSERT INTO VENDEDOR VALUES (
  '987654321',
  tNombre('María', 'López', 'García'),
  tDireccion('Calle Secundaria', 'Ciudad B', 'País Y'),
  '0987654321',
  TO_DATE('2018-06-15', 'YYYY-MM-DD'),
  'Contrato Tipo 2'
);

INSERT INTO VENDEDOR VALUES (
  '456789123',
  tNombre('Pedro', 'Ramírez', 'Martínez'),
  tDireccion('Calle Terciaria', 'Ciudad C', 'País Z'),
  '9876543210',
  TO_DATE('2019-11-30', 'YYYY-MM-DD'),
  'Contrato Tipo 3'
);

-- Ejemplo de sentencias SELECT para obtener diversos datos de los vendedores
-- SELECT para obtener el nombre completo y la antigüedad de todos los vendedores
SELECT v.NOMBRECOMPLETO.NOMBRE || ' ' || v.NOMBRECOMPLETO.APELLIDO1 || ' ' || v.NOMBRECOMPLETO.APELLIDO2 AS NOMBRE_COMPLETO,
       v.ANTIGUEDAD
FROM VENDEDOR v;

-- SELECT para obtener el número de meses que lleva trabajando cada vendedor
SELECT v.NOMBRECOMPLETO.NOMBRE || ' ' || v.NOMBRECOMPLETO.APELLIDO1 || ' ' || v.NOMBRECOMPLETO.APELLIDO2 AS NOMBRE_COMPLETO,
       v.getMeses() AS MESES_TRABAJADOS
FROM VENDEDOR v;

-- SELECT para obtener los vendedores con contrato tipo 2
SELECT v.NOMBRECOMPLETO.NOMBRE || ' ' || v.NOMBRECOMPLETO.APELLIDO1 || ' ' || v.NOMBRECOMPLETO.APELLIDO2 AS NOMBRE_COMPLETO,
       v.TIPOCONTRATO
FROM VENDEDOR v
WHERE v.TIPOCONTRATO = 'Contrato Tipo 2';