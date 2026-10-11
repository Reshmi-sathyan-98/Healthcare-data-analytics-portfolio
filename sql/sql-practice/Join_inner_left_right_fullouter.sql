select *
from patients 
join encounters 
on patients.id = encounters.patient;

SELECT p.id, p.first, e.encounterclass, e. id  
FROM patients p
LEFT JOIN encounters e 
    ON p.id = e.patient
   AND e.encounterclass = 'wellness';

SELECT p.id, p.first, e.encounterclass, e. id as encounter_id
FROM patients p
LEFT JOIN encounters e 
    ON p.id = e.patient
  where e.encounterclass = 'wellness';