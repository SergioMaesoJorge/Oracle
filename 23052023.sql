CREATE TYPE tNombre AS OBJECT (
  nombre VARCHAR2(50),
  apellido1 VARCHAR2(50),
  apellido2 VARCHAR2(50),
  MEMBER FUNCTION getApellidosNombre RETURN VARCHAR2,
  MEMBER FUNCTION getNombreApellidos RETURN VARCHAR2
);
/

CREATE TYPE BODY tNombre AS
  MEMBER FUNCTION getApellidosNombre RETURN VARCHAR2 IS
  BEGIN
    RETURN apellido1 || ' ' || apellido2 || ', ' || nombre;
  END;

  MEMBER FUNCTION getNombreApellidos RETURN VARCHAR2 IS
  BEGIN
    RETURN nombre || ' ' || apellido1 || ' ' || apellido2;
  END;
END;
/

ALTER TABLE cliente ADD nombrecompleto tNombre;



UPDATE cliente SET nombrecompleto = tNombre('Juan', 'Pérez', 'García') WHERE nif = '12345678A';
UPDATE cliente SET nombrecompleto = tNombre('María', 'López', 'Gómez') WHERE nif = '87654321B';
UPDATE cliente SET nombrecompleto = tNombre('Pedro', 'Sánchez', 'Rodríguez') WHERE nif = '98765432C';
UPDATE cliente SET nombrecompleto = tNombre('Ana', 'Martínez', 'Fernández') WHERE nif = '34567891D';


ALTER TABLE cliente DROP COLUMN nombre;

SELECT nif, nombrecompleto.getApellidosNombre(), telefono FROM cliente;