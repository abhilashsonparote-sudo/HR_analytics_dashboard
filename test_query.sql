create table hrdata
(
	emp_no int8 PRIMARY KEY,
	gender varchar(50) NOT NULL,
	marital_status varchar(50),
	age_band varchar(50),
	age int8,
	department varchar(50),
	education varchar(50),
	education_field varchar(50),
	job_role varchar(50),
	business_travel varchar(50),
	employee_count int8,
	attrition varchar(50),
	attrition_label varchar(50),
	job_satisfaction int8,
	active_employee int8
);



select *
from hrdata;




--Employee Count:
select sum(employee_count) as Employee_Count from hrdata;

--Attrition Count:
select count(attrition) from hrdata where attrition='Yes';



--count based on department
select sum(employee_count)
from hrdata
where department = 'Sales'; 
 
select sum(employee_count)
from hrdata
where department = 'R&D'; 



--count based on education
select sum(employee_count)
from hrdata
where education = 'High School'; 

select sum(employee_count)
from hrdata
where education_field = 'Medical'; 




select count(attrition)
from hrdata
where attrition = 'Yes';


select count(attrition)
from hrdata
where attrition = 'Yes' and education = 'Doctoral Degree';


select count(attrition)
from hrdata
where   attrition = 'Yes'
	and education_field = 'Medical' 
	and department = 'R&D'
	and education = 'High School';



--Attrition Rate
select round (
   ((select count(attrition) 
    from hrdata 
    where attrition = 'Yes') / sum(employee_count) * 100), 2
)
from hrdata;


--Department wise Attrition:
select department, count(attrition), round((cast (count(attrition) as numeric) / 
(select count(attrition) from hrdata where attrition= 'Yes')) * 100, 2) as pct from hrdata
where attrition='Yes'
group by department 
order by count(attrition) desc;

--active emlpoyees
select sum(employee_count) - (select count(attrition)
							  from hrdata
							  where attrition = 'Yes' and
							  gender = 'Male')
from hrdata
where gender = 'Male';							  



--Average Age:
select round(avg(age),0) from hrdata;

--Attrition by Gender
select gender, count(attrition),
(count(attrition)/(select count(attrition) from hrdata where attrition = 'Yes'))* 100
from hrdata
where attrition='Yes'
group by gender
order by count(attrition) desc;


select department, 
	   count(attrition),
	   round((cast(count(attrition) as numeric)/(select count(attrition) from hrdata where attrition = 'Yes'))* 100,2)
from hrdata
where attrition='Yes'
group by department
order by count(attrition) desc;



--Job Satisfaction Rating

CREATE EXTENSION IF NOT EXISTS tablefunc;


SELECT *
FROM crosstab(
  'SELECT job_role, job_satisfaction, sum(employee_count)
   FROM hrdata
   GROUP BY job_role, job_satisfaction
   ORDER BY job_role, job_satisfaction'
	) AS ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role;



