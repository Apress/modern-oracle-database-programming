/***
 *       __________       __                             
 *      / __<  / _ \___ _/ /____ _                       
 *     / _/ / / // / _ `/ __/ _ `/                       
 *    /_/  /_/____/\_,_/\__/\_,_/                        
 *       ____                    __    ___       __      
 *      /  _/_ _  ___  ___  ____/ /_  / _ \___ _/ /____ _
 *     _/ //  ' \/ _ \/ _ \/ __/ __/ / // / _ `/ __/ _ `/
 *    /___/_/_/_/ .__/\___/_/  \__/ /____/\_,_/\__/\_,_/ 
 *             /_/                                       
 * Filename : F1Data_Import_csv.sql
 * Remarks  : Run this script as the f1data user
 */
clear screen
set serveroutput on size unlimited format wrapped

set define on

drop table file_ext purge
/

create table file_ext
( line  varchar2(1000)
) organization external
(
  type oracle_loader
  default directory F1_CSV_DIR
  access parameters
  ( records delimited by newline
    FIELDS TERMINATED BY '||'
    ( line
    )
  )
  location ( 'drivers.csv' )
)
reject limit 0
/

select * from file_ext
/


prompt status
insert into f1data.status
with thefile as (
select line, rownum rn
from   file_ext external modify(location('status.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
where  rn <> 1
order  by rn
)
  select *
    from f1data.separated_fnc(input, columns(statusid, status), 'line', ',')
   where statusid is not null
/

commit
/

prompt seasons
insert into f1data.seasons
with thefile as (
select line, rownum rn
from   file_ext external modify(location('seasons.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
where  rn <> 1
order  by rn
)
select *
from   f1data.separated_fnc(input 
                    , columns( year
                             , url
                             )
                    , 'line'
                    , ','
                    )
where year is not null
/

commit
/


prompt circuits
insert into f1data.circuits
with thefile as (
select line, rownum rn
from   file_ext external modify(location('circuits.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
where  rn <> 1
order  by rn
)
select *
from   f1data.separated_fnc( input 
                    , columns( circuitid
                             , circuitref
                             , name
                             , location
                             , country
                             , lat
                             , lng
                             , alt
                             , url
                             )
                    , 'line'
                    ,  ',')
where circuitid is not null
/

commit
/

prompt constructors
insert into f1data.constructors
with thefile as (
select line, rownum rn
from   file_ext external modify(location('constructors.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
where  rn <> 1
order  by rn
)
  select *
    from f1data.separated_fnc(input
                      ,columns(constructorid
                              ,constructorref
                              ,name
                              ,nationality
                              ,url)
                      ,'line'
                      ,',')
   where constructorid is not null
/

commit
/

prompt drivers
insert into f1data.drivers
with thefile as (
select line, rownum rn
from   file_ext external modify(location('drivers.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
where  rn <> 1
order  by rn
)
  select driverid
                              ,driverref
                              ,drivernumber
                              ,code
                              ,forename
                              ,surname
                              ,to_date(dob, 'YYYY-MM-DD') dob
                              ,nationality
                              ,url
    from f1data.separated_fnc(input
                      ,columns(driverid
                              ,driverref
                              ,drivernumber
                              ,code
                              ,forename
                              ,surname
                              ,dob
                              ,nationality
                              ,url)
                      ,'line'
                      ,',')
   where driverid is not null 
/

commit
/

prompt races
insert into f1data.races
with thefile as (
select line, rownum rn
from   file_ext external modify(location('races.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
where  rn <> 1
order  by rn
)
  select raceid
                              ,year
                              ,round
                              ,circuitid
                              ,name
                              ,to_date(racesdate  , 'YYYY-MM-DD')        racesdate
                              , to_date('01010101 ' || time, 'DDMMYYYY HH24:MI:SS') time
                              ,url
                              ,to_date(fp1_date   , 'YYYY-MM-DD')        fp1_date
                              , to_date('01010101 ' || fp1_time, 'DDMMYYYY HH24:MI:SS') fp1_time
                              ,to_date(fp2_date   , 'YYYY-MM-DD')        fp2_date
                              , to_date('01010101 ' || fp2_time, 'DDMMYYYY HH24:MI:SS') fp2_time
                              ,to_date(fp3_date   , 'YYYY-MM-DD')        fp3_date
                              , to_date('01010101 ' || fp3_time, 'DDMMYYYY HH24:MI:SS') fp3_time
                              ,to_date(quali_date , 'YYYY-MM-DD')        quali_date
                              , to_date('01010101 ' || quali_time, 'DDMMYYYY HH24:MI:SS') quali_time
                              ,to_date(sprint_date, 'YYYY-MM-DD')        sprint_date
                              , to_date('01010101 ' || sprint_time, 'DDMMYYYY HH24:MI:SS') sprint_time
    from f1data.separated_fnc(input
                      ,columns(raceid
                              ,year
                              ,round
                              ,circuitid
                              ,name
                              ,racesdate
                              ,time
                              ,url
                              ,fp1_date
                              ,fp1_time
                              ,fp2_date
                              ,fp2_time
                              ,fp3_date
                              ,fp3_time
                              ,quali_date
                              ,quali_time
                              ,sprint_date
                              ,sprint_time
                              )
                      ,'line'
                      ,',')
   where raceid is not null
/

commit
/

prompt constructorresults
insert into f1data.constructorresults
with thefile as (
select line, rownum rn
from   file_ext external modify(location('constructor_results.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
where  rn <> 1
order  by rn
)
  select *
    from f1data.separated_fnc(input
                      ,columns(constructorresultsid
                              ,raceid
                              ,constructorid
                              ,points
                              ,status)
                      ,'line'
                      ,',')
   where constructorresultsid is not null 
/

commit
/

prompt constructorstandings
insert into f1data.constructorstandings
with thefile as (
select line, rownum rn
from   file_ext external modify(location('constructor_standings.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
where  rn <> 1
order  by rn
)
  select *
    from f1data.separated_fnc(input
                      ,columns(constructorstandingsid
                              ,raceid
                              ,constructorid
                              ,points
                              ,position
                              ,positiontext
                              ,wins)
                      ,'line'
                      ,',')
   where constructorstandingsid is not null
/

commit
/

prompt driverstandings - more than 33K records
insert into f1data.driverstandings
with thefile as (
select line, rownum rn
from   file_ext external modify(location('driver_standings.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
where  rn <> 1
order  by rn
)
  select *
    from f1data.separated_fnc(input
                      ,columns(driverstandingsid
                              ,raceid
                              ,driverid
                              ,points
                              ,position
                              ,positiontext
                              ,wins)
                      ,'line'
                      ,',')
   where driverstandingsid is not null
/

commit
/

prompt laptimes - moren than 500K records
insert into f1data.laptimes
with thefile as (
select line, rownum rn
from   file_ext external modify(location('lap_times.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
     where rn between 2 and 50000)
  select *
    from f1data.separated_fnc(input
                      ,columns(raceid
                              ,driverid
                              ,lap
                              ,position
                              ,time
                              ,milliseconds)
                      ,'line'
                      ,',')
   where raceid is not null
/

commit
/

insert into f1data.laptimes
with thefile as (
select line, rownum rn
from   file_ext external modify(location('lap_times.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
     where rn between 50001 and 100000)
  select *
    from f1data.separated_fnc(input
                      ,columns(raceid
                              ,driverid
                              ,lap
                              ,position
                              ,time
                              ,milliseconds)
                      ,'line'
                      ,',')
   where raceid is not null
/

commit
/

insert into f1data.laptimes
with thefile as (
select line, rownum rn
from   file_ext external modify(location('lap_times.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
     where rn between 100001 and 150000)
  select *
    from f1data.separated_fnc(input
                      ,columns(raceid
                              ,driverid
                              ,lap
                              ,position
                              ,time
                              ,milliseconds)
                      ,'line'
                      ,',')
   where raceid is not null
/

commit
/

insert into f1data.laptimes
with thefile as (
select line, rownum rn
from   file_ext external modify(location('lap_times.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
     where rn between 150001 and 200000)
  select *
    from f1data.separated_fnc(input
                      ,columns(raceid
                              ,driverid
                              ,lap
                              ,position
                              ,time
                              ,milliseconds)
                      ,'line'
                      ,',')
   where raceid is not null
/

commit
/

insert into f1data.laptimes
with thefile as (
select line, rownum rn
from   file_ext external modify(location('lap_times.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
     where rn between 200001 and 250000)
  select *
    from f1data.separated_fnc(input
                      ,columns(raceid
                              ,driverid
                              ,lap
                              ,position
                              ,time
                              ,milliseconds)
                      ,'line'
                      ,',')
   where raceid is not null
/

commit
/

insert into f1data.laptimes
with thefile as (
select line, rownum rn
from   file_ext external modify(location('lap_times.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
     where rn between 250001 and 300000)
  select *
    from f1data.separated_fnc(input
                      ,columns(raceid
                              ,driverid
                              ,lap
                              ,position
                              ,time
                              ,milliseconds)
                      ,'line'
                      ,',')
   where raceid is not null
/

commit
/

insert into f1data.laptimes
with thefile as (
select line, rownum rn
from   file_ext external modify(location('lap_times.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
     where rn between 300001 and 350000)
  select *
    from f1data.separated_fnc(input
                      ,columns(raceid
                              ,driverid
                              ,lap
                              ,position
                              ,time
                              ,milliseconds)
                      ,'line'
                      ,',')
   where raceid is not null
/

commit
/

insert into f1data.laptimes
with thefile as (
select line, rownum rn
from   file_ext external modify(location('lap_times.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
     where rn between 350001 and 400000)
  select *
    from f1data.separated_fnc(input
                      ,columns(raceid
                              ,driverid
                              ,lap
                              ,position
                              ,time
                              ,milliseconds)
                      ,'line'
                      ,',')
   where raceid is not null
/

commit
/

insert into f1data.laptimes
with thefile as (
select line, rownum rn
from   file_ext external modify(location('lap_times.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
     where rn between 400001 and 450000)
  select *
    from f1data.separated_fnc(input
                      ,columns(raceid
                              ,driverid
                              ,lap
                              ,position
                              ,time
                              ,milliseconds)
                      ,'line'
                      ,',')
   where raceid is not null
/

commit
/

insert into f1data.laptimes
with thefile as (
select line, rownum rn
from   file_ext external modify(location('lap_times.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
     where rn between 450001 and 500000)
  select *
    from f1data.separated_fnc(input
                      ,columns(raceid
                              ,driverid
                              ,lap
                              ,position
                              ,time
                              ,milliseconds)
                      ,'line'
                      ,',')
   where raceid is not null
/

commit
/

insert into f1data.laptimes
with thefile as (
select line, rownum rn
from   file_ext external modify(location('lap_times.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
     where rn between 500001 and 550000)
  select *
    from f1data.separated_fnc(input
                      ,columns(raceid
                              ,driverid
                              ,lap
                              ,position
                              ,time
                              ,milliseconds)
                      ,'line'
                      ,',')
   where raceid is not null
/

commit
/

prompt pitstops
insert into f1data.pitstops
with thefile as (
select line, rownum rn
from   file_ext external modify(location('pit_stops.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
where  rn <> 1
order  by rn
)
  select raceid
                              ,driverid
                              ,stop
                              ,lap
                              ,to_date('01010101 ' || time, 'DDMMYYYY HH24:MI:SS') time
                              ,duration
                              ,milliseconds
    from f1data.separated_fnc(input
                      ,columns(raceid
                              ,driverid
                              ,stop
                              ,lap
                              ,time
                              ,duration
                              ,milliseconds)
                      ,'line'
                      ,',')
   where raceid is not null
/

commit
/

prompt qualifying
insert into f1data.qualifying
with thefile as (
select line, rownum rn
from   file_ext external modify(location('qualifying.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
where  rn <> 1
order  by rn
)
  select *
    from f1data.separated_fnc(input
                      ,columns(qualifyid
                              ,raceid
                              ,driverid
                              ,constructorid
                              ,driver_number
                              ,position
                              ,q1
                              ,q2
                              ,q3)
                      ,'line'
                      ,',')
   where qualifyid is not null
/

commit
/

prompt results
insert into f1data.results
with thefile as (
select line, rownum rn
from   file_ext external modify(location('results.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
where  rn <> 1
order  by rn
)
  select resultid
        ,coalesce(raceid, '0') raceid
        ,coalesce(driverid, '0') driverid
        ,coalesce(constructorid, '0') constructorid
        ,coalesce(driver_number, '0') driver_number
        ,coalesce(grid, '0') grid
        ,position position
        ,coalesce(positiontext, '') positiontext
        ,coalesce(positionorder, '0') positionorder
        ,coalesce(points, '0') points
        ,coalesce(laps, '0') laps
        ,time time
        ,milliseconds milliseconds
        ,fastestlap fastestlap
        ,coalesce(rank, '0') rank
        ,fastestlaptime fastestlaptime
        ,fastestlapspeed fastestlapspeed
        ,coalesce(statusid, '0') statusid
    from f1data.separated_fnc(input
                      ,columns(resultid
                              ,raceid
                              ,driverid
                              ,constructorid
                              ,driver_number
                              ,grid
                              ,position
                              ,positiontext
                              ,positionorder
                              ,points
                              ,laps
                              ,time
                              ,milliseconds
                              ,fastestlap
                              ,rank
                              ,fastestlaptime
                              ,fastestlapspeed
                              ,statusid)
                      ,'line'
                      ,',')
   where resultid is not null
/

commit
/

prompt sprintresults
insert into f1data.sprintresults
with thefile as (
select line, rownum rn
from   file_ext external modify(location('sprint_results.csv'))
)
, input as (
select trim(replace(replace(line, '"', ''), '\N','')) line 
from   thefile
where  rn <> 1
order  by rn
)
  select *
    from f1data.separated_fnc(input
                      ,columns(sprintresultid
                              ,raceid
                              ,driverid
                              ,constructorid
                              ,driver_number
                              ,grid
                              ,position
                              ,positiontext
                              ,positionorder
                              ,points
                              ,laps
                              ,time
                              ,milliseconds
                              ,fastestlap
                              ,fastestlaptime
                              ,statusid)
                      ,'line'
                      ,',')
   where sprintresultid is not null
/

commit
/

EXIT
