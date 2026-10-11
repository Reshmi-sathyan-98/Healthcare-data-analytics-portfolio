select count (*)
from encounters ;

select 
count (*) as total_count_of_encounters,
count (distinct patient) as unique_encounters,
sum(total_claim_cost ) as billed_amount,
avg(total_claim_cost) as average_amount,
min(total_claim_cost) as minimum_amount,
max(total_claim_cost) as maximum_amount
from encounters ;

select 
city,
count(id) as patient_count
from patients 
group by city
order by patient_count desc;

select 
encounterclass,
count(*) as total_numerber_visits,
avg(base_encounter_cost )as average_cost,
sum(total_claim_cost )as total_claim,
sum(payer_coverage ) as total_payercoverage
from encounters
group by encounterclass
order by total_claim desc;

select 
gender,
avg(healthcare_coverage )as average_coverage,
avg(healthcare_expenses ) as average_expenses
from patients
where healthcare_expenses > '0'
group by gender
;

select 
encounterclass,
count(*) as total_encounters,
round(avg(total_claim_cost ),2) as average_claim_cost
from encounters 
group by encounterclass 
having avg(total_claim_cost ) > '1500';

select city,
count(*) as patient_count,
round(avg(healthcare_expenses ),2) as average_expense
from patients 
group by city
having count(*) >= '2'
and avg(healthcare_expenses ) > '5000'
order by patient_count asc;

select patient,
string_agg(distinct reasondescription, ',') as diagnosis_list
from encounters
where reasondescription is not null 
or reasondescription  = ' '
group by patient;

select patient,
bool_or(encounterclass = 'emergency') as has_emergency_visit
from encounters
group by patient ;

select encounterclass,
round(sum(total_claim_cost ),2) as Total,
round(stddev_samp(total_claim_cost ),2) as STD_DEV,
PERCENTILE_CONT(0.5) within group (order by total_claim_cost ) as median,
var_samp(total_claim_cost ) as RSD
from encounters 
group by encounterclass
order by sum(total_claim_cost ) asc;

