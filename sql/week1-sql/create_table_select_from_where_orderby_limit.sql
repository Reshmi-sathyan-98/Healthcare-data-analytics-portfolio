create table patients (
id			varchar(64) primary key ,
birthdat	date ,
deathdate	date ,
ssn			varchar(32),
drivers		varchar(32),
passport	varchar(32),
prefix		varchar(16),
first		varchar(64),
last		varchar(64),
suffix		varchar(16),
maiden		varchar(64),
marital		varchar(8),
race		varchar(32),
ethinicity	varchar(32),
gender		varchar(8),
birthplace	varchar(128),
address		varchar(128),
city		varchar(64),
state		varchar(64),
county		varchar(64),
zip			varchar(16),
lat			numeric(10, 6),
lon			numeric(10, 6),
healthcare_expenses	numeric(12, 2),
healthacre_coverage	numeric(12, 2),
income		numeric(12, 2)
);
select count(*) from patients p ;

create table encounters (
id		varchar(64) primary key ,
start_date	timestamp ,
stop_date	timestamp ,
patient_id	varchar(64) references patients(id),
oraganization_id	varchar(64),
provider_id		varchar(64),
payer_id	varchar(64),
encounterclass	varchar(64),
code	varchar(32),
description		varchar(255),
base_encounter_cost	numeric(10, 2),
total_claim_cost	numeric(10, 2),
payer_coverage	numeric(10, 2),
reasoncode		varchar(32),
reasondescription	varchar(255)
);

select count(*) from encounters e ;

select first, last
from patients;

select first
from patients
where city = 'Boston';

select first as first_name
from patients
where race ='white';

CREATE INDEX idx_encounters_patient_id ON encounters(patient_id);
CREATE INDEX idx_encounters_class ON encounters(encounterclass);


select id, first, last, city 
from patients
where deathdate is null
order by last asc;

drop table if exists encounters cascade;

create table encounters(
id                  VARCHAR(64) PRIMARY KEY,
start               TIMESTAMP,
stop                TIMESTAMP,
patient             VARCHAR(64) REFERENCES patients(id),
organization        VARCHAR(64),
provider            VARCHAR(64),
payer               VARCHAR(64),
encounterclass      VARCHAR(64),
code                VARCHAR(32),
description         VARCHAR(255),
base_encounter_cost NUMERIC(10, 2),
total_claim_cost    NUMERIC(10, 2),
payer_coverage      NUMERIC(10, 2),
reasoncode          VARCHAR(32),
reasondescription   VARCHAR(255)
);

create index idx_encounters_patient on encounters(patient);
create index idx_encounters_class on encounters(encounterclass);

select id, patient, start, total_claim_cost, encounterclass
from encounters
where encounterclass = 'emergency';

select id, first, gender, income, city
from patients
where city ilike 'boston';

select id, encounterclass, reasondescription
from encounters
where encounterclass in ('inpatient','urgentcare','emergency');

select id, reasoncode, reasondescription
from encounters
where reasondescription ilike '%bronchitis%';

select id, healthcare_expenses, healthcare_coverage
from patients
where healthcare_expenses > '10000'
and (healthcare_coverage < '2000') and (healthcare_coverage > '0');

drop table if exists patients cascade;
drop table if exists encounters cascade;

create table patients (
id			varchar(64) primary key ,
birthdate	date ,
deathdate	date ,
ssn			varchar(32),
drivers		varchar(32),
passport	varchar(32),
prefix		varchar(16),
first		varchar(64),
last		varchar(64),
suffix		varchar(16),
maiden		varchar(64),
marital		varchar(8),
race		varchar(32),
ethnicity	varchar(32),
gender		varchar(8),
birthplace	varchar(128),
address		varchar(128),
city		varchar(64),
state		varchar(64),
county		varchar(64),
zip			varchar(16),
lat			numeric(10, 6),
lon			numeric(10, 6),
healthcare_expenses	numeric(12, 2),
healthcare_coverage	numeric(12, 2),
income		numeric(12, 2)
);

create table encounters(
id                  VARCHAR(64) PRIMARY KEY,
start               TIMESTAMP,
stop                TIMESTAMP,
patient             VARCHAR(64) REFERENCES patients(id),
organization        VARCHAR(64),
provider            VARCHAR(64),
payer               VARCHAR(64),
encounterclass      VARCHAR(64),
code                VARCHAR(32),
description         VARCHAR(255),
base_encounter_cost NUMERIC(10, 2),
total_claim_cost    NUMERIC(10, 2),
payer_coverage      NUMERIC(10, 2),
reasoncode          VARCHAR(32),
reasondescription   VARCHAR(255)
);

create index idx_encounters_patient on encounters(patient);
create index idx_encounters_class on encounters(encounterclass);

select count(*) from patients;
select count(*) from encounters;

select id, patient, encounterclass, total_claim_cost, e.payer_coverage, e.total_claim_cost 
from encounters e 
where payer_coverage = '0'
and total_claim_cost > '1000';

select id, first, last, birthdate
from patients p 
where birthdate >= '01-01-2010'
order by birthdate desc;

select id, first, last, city 
from patients 
where gender = 'M'
and city in ('Boston', 'Cambridge', 'Somerville');

select id, patient, reasondescription 
from encounters
where reasondescription ilike '%diabetes%' ;

select id, encounterclass, start, base_encounter_cost 
from encounters
where encounterclass = 'wellness' or encounterclass = 'ambulatory';

select id, patient, start, total_claim_cost, encounterclass
from encounters 
where encounterclass= 'inpatient'
and start between '01-01-2023' and '31-12-2023'
order by start desc;

select id, total_claim_cost, payer_coverage 
from encounters
where total_claim_cost > '5000' 
and (payer_coverage < '1000' or payer_coverage = '0')
order by payer_coverage desc;

select id, first, last, maiden, marital 
from patients
where gender ='F'
and marital is not null and marital != ''
and maiden = '' or maiden is null
;

select id, encounterclass, reasondescription, base_encounter_cost 
from encounters
where encounterclass != 'wellness'
order by base_encounter_cost asc
limit 3;

select last, first, city, birthdate, deathdate
from patients 
where city = 'Boston'
and deathdate is null 
and birthdate < ' 01-01-1960'
order by last asc, first asc
limit 5;

