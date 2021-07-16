-- Grade --
insert into Grade values('generaliste', 'generaliste');
insert into Grade values('chef de bloc', 'chef de bloc');
insert into Grade values('assistant', 'assistant');
insert into Grade values('maitre assistant', 'maitre assistant');
insert into Grade values('professeur', 'professeur');

SELECT * FROM Grade;

-- Specialite --
insert into Specialite values(1,'Cardiologue');
insert into Specialite values(2,'Psychiatrue');
insert into Specialite values(3,'Urologue');
insert into Specialite values(4,'Ophtalmologue');
insert into Specialite values(5,'Gastrologue');
insert into Specialite values(6,'Pneumologue');
insert into Specialite values(7,'Dermatologue');
insert into Specialite values(8,'Endocrinologue');
insert into Specialite values(9,'Pediatre');
insert into Specialite values(10,'Neurologue');

SELECT * FROM Specialite;

-- Wilaya --
DECLARE
nom char(10); m number; i number; 
begin
for i in 1..48 loop
Select dbms_random.string('U', 10) into nom from dual; 
insert into Wilaya values(i,nom);
end loop; commit; end;

SELECT * from Wilaya ;

-- Ville --
DECLARE
l char(10); m number; i number; 
begin
for i in 1..330 loop
Select dbms_random.string('U', 8) into l from dual;
Select floor(dbms_random.value(1, 48)) into m from dual; 
insert into Ville values(i,l,m);
end loop; commit; end;

SELECT * FROM Ville;

-- TypeAnalyse --
DECLARE
typeanal char(10);  descrip char(50); 
begin
for i in 1..4000 loop
Select dbms_random.string('U', 10) into typeanal from dual; 
Select dbms_random.string('U', 50) into descrip from dual; 
insert into TypeAnalyse values(typeanal,descrip);
end loop; commit; end;

SELECT * FROM typeanalyse;

-- Analyse --
DECLARE
nom char(15); i number; 
begin
for i in 1..400325 loop
Select dbms_random.string('U', 15) into nom from dual; 
insert into Analyse values(i,nom);
end loop; commit; end;

SELECT * FROM analyse;

-- Patient -
DECLARE
t number; nompat char(8); SexePat char(1); v_NomVille char(10);
v_CodeVille number; i number; v_CodeWilaya number; v_NomWilaya Varchar(10);
begin
for i in 1..110080 loop
Select dbms_random.string('U', 8) into nompat from dual;
Select floor(dbms_random.value(1, 330)) into v_CodeVille from dual;
SELECT Nom_Ville into v_NomVille from Ville where CodeVille=v_CodeVille;
Select floor(dbms_random.value(1, 48)) into v_CodeWilaya from dual;
SELECT NomWilaya into v_NomWilaya from Wilaya where CodeWilaya=v_CodeWilaya;
Select dbms_random.value(0, 2) into t from dual; 
IF t>1 THEN SexePat := 'm';
else SexePat := 'f'; END If;
insert into Patient values(i, Nompat, SexePat, v_CodeVille, v_NomVille, v_CodeWilaya, v_NomWilaya);
end loop; commit; end;

SELECT * FROM Patient;

-- Medecin --
DECLARE
nom char(10); CodeGrade varchar(20); LibellGrade char(100); CodeSpec number; LibellSpec char(40); id_hopital number; i number; 
BEGIN
FOR i IN 1.. 12300 LOOP
Select dbms_random.string('U', 10) into nom from dual;
SELECT titre,description into codegrade,libellGrade FROM ( SELECT titre,description FROM grade ORDER BY dbms_random.value ) WHERE rownum = 1;
SELECT floor(DBMS_RANDOM.VALUE(1, 10 ) ) into CodeSpec FROM DUAL;
Select Nom_Specialite into LibellSpec from specialite where id_spec = codeSpec;
INSERT INTO medecin VALUES (i, nom,CodeGrade, LibellGrade, CodeSpec,LibellSpec); 
END LOOP;COMMIT;END;

SELECT * from MEDECIN;

-- Hopital --
DECLARE
nom char(10); id_wilaya number; i number; 
BEGIN
FOR i IN 1.. 113 LOOP
Select dbms_random.string('U', 10) into nom from dual;
SELECT floor(DBMS_RANDOM.VALUE(1, 48 ) ) into id_wilaya FROM DUAL; 
INSERT INTO hopital VALUES (i, nom,id_wilaya); 
END LOOP;COMMIT;END;

SELECT * FROM HOPITAL;

-- Service --
DECLARE
nom char(10); id_hopital number; i number; 
BEGIN
FOR i IN 1.. 2212 LOOP
Select dbms_random.string('U', 10) into nom from dual;
SELECT floor(DBMS_RANDOM.VALUE(1, 113 ) ) into id_hopital FROM DUAL; 
INSERT INTO service VALUES (i, nom,id_hopital); 
END LOOP;COMMIT;END;

SELECT * FROM Service;
-- Hospialisation --
DECLARE
d date; nbj number; tarif number; pat number; serv number; med number; i number; 
BEGIN
FOR i IN 1.. 710314 LOOP
SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2014-01-01','J')
,TO_CHAR(DATE '2019-12-31','J') )),'J') into d FROM DUAL;
SELECT trunc(DBMS_RANDOM.VALUE(1, 90),0) into nbj FROM DUAL; 
SELECT floor(DBMS_RANDOM.VALUE(1, 3000 ) ) into tarif FROM DUAL; 
SELECT floor(DBMS_RANDOM.VALUE(1, 110080) ) into pat FROM DUAL; 
SELECT floor(DBMS_RANDOM.VALUE(1, 2212) ) into serv FROM DUAL;
SELECT floor(DBMS_RANDOM.VALUE(1, 12300) ) into med FROM DUAL;
INSERT INTO Hospitalisation VALUES (i, d,nbj, tarif, pat, serv, med); 
END LOOP;COMMIT;END;

select * from hospitalisation;