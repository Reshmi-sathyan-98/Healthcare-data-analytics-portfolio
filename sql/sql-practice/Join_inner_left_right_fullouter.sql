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

select p. id as patients_id, p.first, p. last, p. city, e. id, e. start , e.total_claim_cost, e. encounterclass 
from patients p 
inner join encounters e
on p.id = e.patient
where e. encounterclass = 'emergency' and e.total_claim_cost > '2500'
order by e. total_claim_cost desc;

select count (*)
from encounters e
where e.encounterclass is null;


select 
p. id as patients_id,
p. first as first_name,
p. last as last_name,
p. city as city
from patients p
left join encounters e 
on p. id = e. patient
where e. id is null;

select p.id, p.first, p. last,
count(e. id ) as total_visits,
coalesce(SUM(e.total_claim_cost ), 0.00) as total_billed_amount
from patients p
left join encounters e 
on p. id= e. patient
group by p.id, p.first, p. last
order by total_billed_amount   desc;

select 
p. id,
concat( p. first, ' ' , p. last ) as fullname,
p. gender,
e. encounterclass, e. id, e. total_claim_cost 
from patients p
left join encounters e
on p.id = e. patient
and e.encounterclass = 'emergency'
where p. gender = 'F' ;

select e. id, p. id as patient_id, e.start 
from patients p 
right join encounters e 
on p.id = e. patient
where p. id is not null;

select e. id, p. id as patient_id, e.start 
from  encounters e
left join  patients p
on  e. patient= p.id
where p. id is not null;

select 
count(e. id)
from encounters e 
where encounterclass = 'inpatient'
group by e. patient;


#'Identify patients who have had more than 2 inpatient visits'

select 
p. id, 
concat (p.first, ' ', p. last) as patient_name,
count (p. id) as inpatient_count, e. encounterclass 
from patients p
join encounters e
on p. id = e. patient 
where e. encounterclass = 'inpatient'
group by p. id , e. encounterclass
having count (p. id) > '2'
order by inpatient_count desc ;

select 
p. id as patient_id,
count (p. id),
concat (p. first, ' ' , p. last) as patient_name,
string_agg(distinct e. reasondescription, ','  ) as all_reasons
from patients p 
join encounters e
on p.id = e. patient 
where e.reasondescription is not null
group by p. id
having count (p. id) >= '1';

select 
p.first,
p. last,
p. city, 
e. total_claim_cost,
round(avg(e. total_claim_cost) over (partition by p. city), 2
) as city_avg_cost
from patients p 
join encounters e 
on p.id= e. patient
where p.city is not null;

