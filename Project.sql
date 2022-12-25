create database if not exists project; -- i already inserted csv file in the project database

--  how to add new column and delete it
 alter table projone
 add column location varchar(50);
 alter table projone
 drop column location;

-- how to change column name
alter table projtwo
change Population populations int;
alter table projtwo
change populations Population int;

-- how to change data type 
alter table projone
modify District varchar(100); 

-- Find the maximum literacy from projone and maximum population from projtwo
select max(Literacy) from projone;
select max(Population) from projtwo;

-- Find the minimum growth from projone and minimum population from projtwo
select min(Growth) from projone;
select min(Population) from projtwo;

-- show growth in percentage
select id, District,State,Sex_Ratio,Growth,Growth*100 as growth_percentage from projone;

-- find the state wich have less than 500 sex_ratio
select * from projone
where Sex_Ratio < 500;

-- find the state that we need to open more school
select * from projone
where Literacy = (select min(Literacy) from projone);

-- find the details sex ratio whose under 500 or literacy under 60
select * from projone 
where Sex_Ratio <= 500 or Literacy <= 60;

-- find the details having sex ration between 900 to 1000
select * from projone
where Sex_Ratio between 900 and 1000;

-- find the details having sex ratio between 900 to 1000 using in operator
select * from projone 
where Sex_Ratio in (900,1000);

-- find the only district start with 'a' end with 'd'
select * from projone where District like 'a%d';

-- find the only district start with 'a' contain 3 character and end with 'd'
select * from projone where District like '___d';

-- arrange all records according to literacy rate 
select * from projone order by Literacy;

-- arrange all records according to literacy rate by descending
select * from projone order by Literacy desc;

-- Find top 5 records having according to sex ratio
select * from projone 
order by Sex_Ratio desc
limit 5;

-- find the 3rd highest record according to sex ratio
select * from projone 
order by Sex_Ratio desc
limit 2,1;

-- add district and state acccording to state
select concat(State,'   ',District)as 'State and District',Growth, Sex_ratio, Literacy from projone
order by State; 

-- show only state this table contain
select distinct state from projone; 

-- show only district count in the table 
select count(distinct District)as 'District' from projone;

-- find the avg literacy > 70 according to state
select * from projone
group by  State
having avg(Literacy) > 70;

-- find the maximum literacy details 
select * from projone
where Literacy = (select max(Literacy) from projone);

-- find the second maximum literacy details using subquery
select * from projone 
where Literacy  = (select max(Literacy) from projone 
where literacy != (select max(Literacy) from projone));

-- find population wise sex ratio
select o.District, o.State, o.literacy , t.Population from projone as o
inner join projtwo as t on
o.id = t.pid ;

-- find the population wise growth, sex_ratio, Literacy according to state
select o.District,o.State,o.Growth,o.Sex_ratio,o.Literacy,t.Population
from projone as o 
left join projtwo as t
on o.id = t.Pid
group by State ;

-- find all the details from the two table
select * from projone as o
inner join projtwo as t on 
o.id = t.Pid; 

-- how many population do we have and state both side
select * from projone as o
inner join projtwo as t
on o.id = t.Pid ;

-- show table of all details having growth 0.01  
select * from projone as o
inner join projtwo as t
on o.id = t.pid
where Growth = 0.01
order by id;

-- create virtual table of population having details only for orissa
create view orissa_population as
select * from projtwo 
where state = 'Orissa';

-- show your resident state as my home state otherwise non-resident state
select * , State  ,
case 
  when State = 'Maharashtra' then  'My Home State'
  else 'Non-Resident State'
  end as Homestate
from projone;  

-- show your resident state as my home state otherwise null and your resident district as my city otherwise null
select * ,
case 
 when District = 'Mumbai City' then 'My City'
 when State = 'Maharashtra' then 'My home State'
 else null
 end as My_city
from projone
order by My_City desc; 
















 












