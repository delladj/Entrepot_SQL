create table Specialite (
ID_spec int primary key, 
Nom_specialite varchar(40)
);

create table Grade (
Titre varchar(20) primary key, 
description varchar(100)
);

create table Wilaya (
CodeWilaya int primary key check (CodeWilaya <49 and CodeWilaya > 0), 
NomWilaya varchar(10)
);

create table Ville (
CodeVille number Primary key, 
nom_ville varchar(10), 
ID_willaya number
);

create table TypeAnalyse ( 
TypeAnalyse varchar(10) primary key, 
description varchar(50)
);

create table Analyse (
ID_analyse int primary key, 
Nom_analyse varchar(15)
);

create table Patient (
CodePat number primary key, 
NomPat varchar (10), 
SexePat varchar (1) check (SexePat='f' or SexePat='m'), 
CodeVille number, 
NomVille varchar (10), 
CodeWilaya number, 
NomWilaya varchar (10)
);

create table Medecin(
CodeMedecin int primary key, 
NomMedecin varchar(10), 
CodeGrade varchar(20), 
LibelleGrade varchar(100), 
CodeSpec number, 
LibelleSpec varchar(40)
);

create table Hopital (
code_hopital number primary key, 
nom_hopital varchar(50), 
ID_wilaya number,
constraint fk_hopital_wilaya foreign key (ID_wilaya) references Wilaya (CodeWilaya) 
);
create table Service(
CodeService int primary key, 
NomService varchar (100), 
CodeHopital number,
constraint fk_service_hopital foreign key (CodeHopital) references Hopital (code_hopital) 
);

create table hospitalisation( 
ID_hospitalisation number primary key, 
date_hospitalisation date, 
nombre_jours number, 
tarif number, 
ID_patient number, 
ID_service  number, 
ID_medecin number,
constraint fk_hospitalisation_patient foreign key  (ID_patient) references Patient (CodePat),
constraint fk_hospitalisation_service foreign key  (ID_service) references Service (CodeService),
constraint fk_hospitalisation_medecin foreign key  (ID_medecin) references Medecin (CodeMedecin)
);