update Wilaya set NomWilaya = 'oran' where CodeWilaya = 31;
update hopital set nom_hopital = 'Mustapha', ID_wilaya = 16 where code_hopital = 5;
update service set NomService = 'Cardiologie' , CodeHopital = 5 where CodeService = 5;


SELECT codepat,nompat FROM Patient p Left outer Join 
      Hospitalisation H ON P.CodePat = H.id_patient
      left outer join service s on s.codeservice = h.id_service
      left outer join hopital ho on s.codehopital = ho.code_hopital
      WHERE h.date_hospitalisation >= '01/01/2015' and h.date_hospitalisation <='30/05/2018'
      and s.nomservice = 'Cardiologie'
      and ho.nom_hopital = 'Mustapha';      
      
SELECT COUNT(*) FROM Patient p Left outer Join 
      Hospitalisation H ON P.CodePat = H.id_patient
      left outer join service s on s.codeservice = h.id_service
      WHERE p.codewilaya = 31 
      and s.codehopital = 4;
      
      
      
      
SELECT h.code_hopital,h.nom_hopital,COUNT(s.codeService) AS nbr
FROM hopital h LEFT JOIN service s ON h.code_hopital = s.codehopital
GROUP BY h.nom_hopital,h.code_hopital
order by h.code_hopital;




