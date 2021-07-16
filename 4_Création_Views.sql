-- CREATION DE VM1 ---
CREATE MATERIALIZED VIEW VM1
BUILD IMMEDIATE 
REFRESH COMPLETE ON DEMAND
AS SELECT ID_hospitalisation AS Code_hos, date_hospitalisation AS Date_Hos
FROM Hospitalisation WHERE ID_service=16;

SELECT * FROM VM1;

-- CREATION DE VM2 ---
CREATE MATERIALIZED VIEW LOG ON Hospitalisation;
CREATE MATERIALIZED VIEW VM2
BUILD IMMEDIATE 
REFRESH FAST ON DEMAND
AS SELECT ID_hospitalisation AS Code_hos , date_hospitalisation AS  Date_Hos
FROM Hospitalisation WHERE ID_service=16;

SELECT * FROM VM2;

--Effectuer un ajout
DECLARE
d date; nbj number; tarif number; pat number; serv number; med number;
BEGIN
 FOR i IN 800000.. 910000 LOOP
 SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2014-01-01','J'),TO_CHAR(DATE '2019-12-31','J') )),'J') into d FROM DUAL;
 SELECT trunc(DBMS_RANDOM.VALUE(3, 90 ),2) into nbj FROM DUAL;
 SELECT floor(DBMS_RANDOM.VALUE(1, 3000 ) ) into tarif FROM DUAL;
 SELECT floor(DBMS_RANDOM.VALUE(1, 110080) ) into pat FROM DUAL;
 SELECT floor(DBMS_RANDOM.VALUE(1, 2212) ) into serv FROM DUAL; 
 SELECT floor(DBMS_RANDOM.VALUE(1, 12300) ) into med FROM DUAL;
 INSERT INTO hospitalisation VALUES (i, d,nbj, tarif, pat, serv, med);
 END LOOP;
COMMIT;
END;
/

--Effectuer une suppression
DELETE FROM Hospitalisation WHERE nombre_jours BETWEEN 20 AND 40;

--Effectuer une modification
UPDATE hospitalisation
SET id_service = 40
WHERE id_service BETWEEN 50 AND 70;

--Raffraichir VM1
BEGIN
DBMS_SNAPSHOT.REFRESH('VM1');
END;

--Raffraichir VM2
BEGIN
DBMS_SNAPSHOT.REFRESH('VM2');
END;

--Création de VM3
CREATE MATERIALIZED VIEW VM3
BUILD DEFERRED
REFRESH COMPLETE ON COMMIT
AS SELECT H.ID_hospitalisation AS Code_hos, H.date_hospitalisation AS Date_Hos
FROM Hospitalisation H, Service S WHERE S.CodeService = H.ID_service AND S.CodeHopital=2;

BEGIN
DBMS_SNAPSHOT.REFRESH('VM3');
END;



--Création de VM3 avec FAST
CREATE MATERIALIZED VIEW LOG ON SERVICE WITH ROWID INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON HOSPITALISATION WITH ROWID INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW VM3_2
BUILD DEFERRED 
REFRESH FAST  ON DEMAND
AS SELECT H.ID_hospitalisation AS Code_hos, H.date_hospitalisation AS Date_Hos
FROM Hospitalisation  H, Service S where S.CodeService = H.ID_service AND S.CodeHopital=2;









