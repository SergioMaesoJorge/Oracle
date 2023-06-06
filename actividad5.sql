CREATE OR REPLACE TYPE tDeportes AS VARRAY(15) OF VARCHAR2(50);
ALTER TABLE CLIENTE ADD DEPORTES tDeportes;
UPDATE CLIENTE SET DEPORTES = tDeportes('fútbol', 'tenis') WHERE ID = '123';
CREATE OR REPLACE TYPE tDetalle AS OBJECT (
  idDet NUMBER,
  descripcion VARCHAR2(100),
  metodoInteresante MEMBER FUNCTION nombreMetodo RETURN VARCHAR2
);
/CREATE OR REPLACE TYPE tDetalleTabla AS TABLE OF tDetalle;
/

CREATE TABLE DETALLE (
  id NUMBER PRIMARY KEY,
  detalles tDetalleTabla
) NESTED TABLE detalles STORE AS detalles_tabla;

CREATE OR REPLACE TYPE BODY tDetalle AS
  MEMBER FUNCTION nombreMetodo RETURN VARCHAR2 IS
  BEGIN
    -- Lógica del método
    RETURN 'Resultado del método interesante';
  END;
END;
/
INSERT INTO DETALLE (id, detalles) VALUES (1, tDetalleTabla(tDetalle(1, 'Descripción 1'), tDetalle(2, 'Descripción 2')));
SELECT d.id, d.detalles(i).descripcion, d.detalles(i).nombreMetodo
FROM DETALLE d, TABLE(d.detalles) t
WHERE d.id = 1;

UPDATE TABLE(SELECT detalles FROM DETALLE WHERE id = 1) t
SET t.descripcion = 'Nueva descripción'
WHERE t.idDet = 1;