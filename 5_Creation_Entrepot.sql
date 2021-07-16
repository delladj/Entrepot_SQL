create table DPatient (
CodePat number primary key, 
NomPat varchar (10), 
SexePat varchar (1) check (SexePat='f' or SexePat='m'), 
CodeVille number, 
NomVille varchar (10), 
CodeWilaya number, 
NomWilaya varchar (10)
);

create table DService(
CodeService int primary key, 
NomService varchar (100), 
CodeHopital number,
NomHopital varchar (100), 
CodeWilaya number, 
NomWilaya varchar (10)
);

create table DMedecin(
CodeMedecin int primary key, 
NomMedecin varchar(10), 
CodeGrade varchar(20), 
LibelleGrade varchar(100), 
CodeSpec number, 
LibelleSpec varchar(40)
);

create table DTemps(
CodeTemps number primary key,
Jour varchar(20),
Mois varchar(20),
LibMois varchar(20),
Trimestre varchar(20),
Annee varchar(20)
);

create table Fhospitalisation( 
NbHospitalisation number primary key,  
CA number, 
ID_Temps int ,
ID_patient number, 
ID_service  number, 
ID_medecin number,
constraint fk_hospitalisation_dpatient foreign key  (ID_patient) references DPatient (CodePat),
constraint fk_hospitalisation_dtemps foreign key  (ID_Temps) references DTemps (CodeTemps),
constraint fk_hospitalisation_dservice foreign key  (ID_service) references DService (CodeService),
constraint fk_hospitalisation_dmedecin foreign key  (ID_medecin) references DMedecin (CodeMedecin)
);