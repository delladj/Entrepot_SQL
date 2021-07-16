-- DPatient -
DECLARE
CURSOR x is select * from patient;
begin
for i in x loop
  insert into DPatient values i;
end loop; commit; end;

SELECT * FROM DPatient;

-- DService -
DECLARE
CURSOR x is select * from Service;
wilaya number;
hopi varchar(100);
nomwil varchar(10);
begin
for i in x loop
  SELECT nom_hopital,ID_wilaya into hopi,wilaya from Hopital where
     code_hopital = i.CodeHopital;
  SELECT NomWilaya into nomwil from Wilaya where codewilaya = wilaya;
  insert into DService values (i.CodeService , i.NomService , i.CodeHopital , hopi , wilaya , nomwil);
end loop; commit; end;

SELECT * FROM DService;

-- DMedecin -
DECLARE
CURSOR x is select * from Medecin;
begin
for i in x loop
  insert into DMedecin values i;
end loop; commit; end;

SELECT * FROM DMedecin;

-- DTemps -
DECLARE
CURSOR x is select ID_hospitalisation,date_hospitalisation,nombre_jours from hospitalisation ;
Jour varchar(20);
Mois varchar(20);
LibMois varchar(20);
Trimestre varchar(20);
Annee varchar(20);
libm date;
begin
for i in x loop
  Jour := TO_CHAR(i.date_hospitalisation,'DD/MM/YYYY');
  Mois := TO_CHAR(i.date_hospitalisation,'MM/YYYY');
  libm := i.date_hospitalisation + i.nombre_jours;
  LibMois := TO_CHAR(libm ,'MM/YYYY');
  Trimestre := TO_CHAR(i.date_hospitalisation,'Q');
  Annee :=  TO_CHAR(i.date_hospitalisation,'YYYY');
  
  insert into DTemps values (i.ID_hospitalisation,Jour,Mois,LibMois,Trimestre,Annee);
end loop; commit; end;

SELECT * from Dtemps;

--  Fhospitalisation -
DECLARE
CURSOR x is select * from Hospitalisation;
begin
for i in x loop

  insert into  Fhospitalisation values(i.ID_hospitalisation,i.tarif,i.ID_hospitalisation,i.ID_patient,i.ID_service,i.ID_medecin);
end loop; commit; end;

SELECT * FROM  Fhospitalisation;

SELECT SUM(CA) FROM Fhospitalisation f left join Dservice d  on f.id_service = d.codeservice  
               left join DTemps t on f.nbhospitalisation = t.codetemps 
                    where d.codewilaya=16 and t.annee='2016' ;
