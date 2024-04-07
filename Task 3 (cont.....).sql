create database TASK3;
use TASK3;

#	Table 1 Users:
create table Users (
user_id int,
created_at varchar(100),
company_id int,
language varchar(50),
activated_at varchar(100),
state varchar(50));

SHOW variables LIKE 'secure_file_priv';

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv"
INTO TABLE Users
fields terminated by ','
enclosed by '"'
LINES terminated by '\n'
ignore 1 rows;

select * from Users;
select * from job_data;

alter table users add column temp_created_at datetime;
UPDATE users set temp_created_at = str_to_date(created_at, '%d-%m-%Y %H:%i');
ALTER TABLE users drop column created_at;
ALTER TABLE users CHANGE COLUMN temp_created_at created_at DATETIME;
drop table Users;

alter table users add column temp_activated_at datetime;
UPDATE users set temp_activated_at = str_to_date(activated_at, '%d-%m-%Y %H:%i');
ALTER TABLE users drop column activated_at;
ALTER TABLE users CHANGE COLUMN temp_activated_at activated_at DATETIME;
drop table Users;

##TABLE 2 EVENTS:
CREATE table events (
user_id int null ,
occured_at varchar(100) ,
event_type varchar(50) ,
event_name varchar(100),
location varchar(50) ,
device varchar(50) ,
user_type int 
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv"
INTO TABLE events
fields terminated by ','
enclosed by '"'
LINES terminated by '\n'
ignore 1 rows;

desc events;
select * from events;


alter table events add column temp_occured_at datetime;
UPDATE events set temp_occured_at = str_to_date(occured_at, '%d-%m-%Y %H:%i');
ALTER TABLE events drop column occured_at;
ALTER TABLE events CHANGE COLUMN temp_occured_at occured_at DATETIME;

#Table3 email-events:

create table emailEvents(
user_id int,
occured_at varchar(100),
action varchar(100),
user_type int
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv"
INTO TABLE emailEvents
fields terminated by ','
enclosed by '"'
LINES terminated by '\n'
ignore 1 rows;

select * from emailEvents;

alter table emailEvents add column temp_occured_at datetime;
UPDATE emailEvents set temp_occured_at = str_to_date(occured_at, '%d-%m-%Y %H:%i');
ALTER TABLE emailEvents drop column occured_at;
ALTER TABLE emailEvents CHANGE COLUMN temp_occured_at occured_at DATETIME;
show tables;


CREATE TABLE jobData(
ds varchar(50),
job_id int,
actor_id int,
event varchar(100),
language varchar(50),
time_spent int,
org char);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/job_data.csv"
INTO TABLE jobData
fields terminated by ','
enclosed by '"'
LINES terminated by '\n'
ignore 1 rows;

select * from jobData;

alter table jobData add column temp_ds date;
UPDATE jobData set temp_ds= str_to_date(ds, '%m/%d/%Y');
ALTER TABLE jobData drop column ds;
ALTER TABLE jobData CHANGE COLUMN temp_ds ds DATE;
show tables;

#TASKS 1:

SELECT 
    ds AS Date,
    COUNT(job_id) AS Jobs_Count_per_day,
    sum(time_spent) / 3600 AS Hours_Spent_per_day
FROM
    jobData
WHERE
    ds >= '2020-11-01'
        AND ds <= '2020-11-30'
GROUP BY ds;





