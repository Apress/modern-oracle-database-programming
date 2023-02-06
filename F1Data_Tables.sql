/***
 *       __________       __      
 *      / __<  / _ \___ _/ /____ _
 *     / _/ / / // / _ `/ __/ _ `/
 *    /_/  /_/____/\_,_/\__/\_,_/ 
 *     ______     __   __         
 *    /_  __/__ _/ /  / /__ ___   
 *     / / / _ `/ _ \/ / -_|_-<   
 *    /_/  \_,_/_.__/_/\__/___/   
 *                                
 * Filename : F1Data_Tables.sql
 */
clear screen
set serveroutput on size unlimited format wrapped
drop table constructorresults purge;
drop table constructorstandings purge;
drop table driverstandings purge;
drop table laptimes purge;
drop table pitstops purge;
drop table qualifying purge;
drop table results purge;
drop table sprintresults purge;
drop table races purge;
drop table status purge;
drop table seasons purge;
drop table circuits purge;
drop table constructors purge;
drop table drivers purge;


create table status (
  statusid               number  (   11 )  not null
, status                 varchar2(  255 )
, constraint pk_status                            
               primary key (statusid)
)
/

create table circuits (
  circuitid              number  (   11 )  not null
, circuitref             varchar2(  255 ) 
, name                   varchar2(  255 ) 
, location               varchar2(  255 ) 
, country                varchar2(  255 ) 
, lat                    float            
, lng                    float            
, alt                    number  (   11 ) 
, url                    varchar2(  255 ) 
, constraint pk_circuits                          
               primary key (circuitid)
, constraint uk_circuit_url                       
               unique      (url)
)
/

create table constructors (
  constructorid          number  (   11 )  not null
, constructorref         varchar2(  255 ) 
, name                   varchar2(  255 ) 
, nationality            varchar2(  255 ) 
, url                    varchar2(  255 ) 
, constraint pk_constructors                      
               primary key (constructorid)
, constraint uk_constructors_name                 
               unique      (name)
)
/

create table drivers (
  driverid               number  (   11 )  not null
, driverref              varchar2(  255 )  
, driver_number          number  (   11 )  
, code                   varchar2(    3 )  
, forename               varchar2(  255 )  
, surname                varchar2(  255 )  
, dob                    date              
, nationality            varchar2(  255 )  
, url                    varchar2(  255 )  
, constraint pk_drivers 
               primary key (driverid)
--, constraint drivers_url 
--               unique      (url)
)
/

create table seasons (
  year                   number  (   11 )  not null
, url                    varchar2( 1024 ) 
, constraint pk_seasons                           
               primary key (year)
, constraint uk_seasons_url                       
               unique      (url)
)
/

create table races (
  raceid                 number  (   11 )  not null
, year                   number  (   11 )  not null
, round                  number  (   11 )  not null
, circuitid              number  (   11 )  not null
, name                   varchar2(  255 ) 
, race_date              date              not null
, time                   date             
, url                    varchar2(  255 ) 
, fp1_date               date             
, fp1_time               date             
, fp2_date               date             
, fp2_time               date             
, fp3_date               date             
, fp3_time               date             
, quali_date             date             
, quali_time             date             
, sprint_date            date             
, sprint_time            date             
, constraint pk_races                             
               primary key (raceid)
, constraint fk_races_seasons                     
               foreign key (year)                   
               references seasons (year)
, constraint fk_races_circuits                    
               foreign key (circuitid)              
               references circuits (circuitid)
, constraint uk_races_url                         
               unique      (url)
)
/

create table constructorresults (
  constructorresultsid   number  (   11 )  not null
, raceid                 number  (   11 )  not null
, constructorid          number  (   11 )  not null
, points                 float            
, status                 varchar2(  255 ) 
, constraint pk_constructorresults                
               primary key (constructorresultsid)
, constraint fk_constructorresults_races          
               foreign key (raceid)                 
               references races (raceid)
, constraint fk_constructorresults_constructors   
               foreign key (constructorid)          
               references constructors (constructorid)
)
/

create table constructorstandings (
  constructorstandingsid number  (   11 )  not null
, raceid                 number  (   11 )  not null
, constructorid          number  (   11 )  not null
, points                 float             not null
, position               number  (   11 ) 
, positiontext           varchar2(  255 ) 
, wins                   number  (   11 )  not null
, constraint pk_constructorstandings              
               primary key (constructorstandingsid) 
, constraint fk_constructorstandings_races        
               foreign key (raceid)                 
               references races (raceid)
, constraint fk_constructorstandings_constructors 
               foreign key (constructorid)
               references constructors (constructorid)
)
/

create table driverstandings (
  driverstandingsid      number  (   11 )  not null
, raceid                 number  (   11 )  not null
, driverid               number  (   11 )  not null
, points                 float             not null
, position               number  (   11 ) 
, positiontext           varchar2(  255 ) 
, wins                   number  (   11 )  not null
, constraint pk_driverstandings                   
               primary key (driverstandingsid)
, constraint fk_driverstandings_races             
               foreign key (raceid)                 
               references races (raceid)
, constraint fk_driverstandings_drivers           
               foreign key (driverid)               
               references drivers (driverid)
)
/


create table laptimes (
  raceid                 number  (   11 ) not null
, driverid               number  (   11 ) not null
, lap                    number  (   11 ) not null
, position               number  (   11 ) 
, time                   varchar2(  255 ) 
, milliseconds           number  (   11 ) 
, constraint pk_laptimes                          
               primary key (raceid,driverid,lap)  
, constraint fk_laptimes_races                    
               foreign key (raceid)                 
               references races (raceid)
, constraint fk_laptimes_drivers                  
               foreign key (driverid)               
               references drivers (driverid)
)
/

create table pitstops (
  raceid                 number  (   11 ) not null
, driverid               number  (   11 ) not null
, stop                   number  (   11 ) not null
, lap                    number  (   11 ) not null
, time                   date             not null
, duration               varchar2(  255 ) 
, milliseconds           number  (   11 ) 
, constraint pk_pitstops                          
               primary key (raceid,driverid,stop) 
, constraint fk_pitstops_races                    
               foreign key (raceid)                 
               references races (raceid)
, constraint fk_pitstops_drivers                  
               foreign key (driverid)               
               references drivers (driverid)
)
/

create table qualifying (
  qualifyid              number  (   11 )  not null
, raceid                 number  (   11 )  not null
, driverid               number  (   11 )  not null
, constructorid          number  (   11 )  not null
, driver_number          number  (   11 )  not null
, position               number  (   11 ) 
, q1                     varchar2(  255 ) 
, q2                     varchar2(  255 ) 
, q3                     varchar2(  255 ) 
, constraint pk_qualifying                        
               primary key (qualifyid)
, constraint fk_qualifying_races                  
               foreign key (raceid)                 
               references races (raceid)
, constraint fk_qualifying_drivers                
               foreign key (driverid)               
               references drivers (driverid)
, constraint fk_qualifying_constructors           
               foreign key (constructorid)          
               references constructors (constructorid)
)
/

create table results (
  resultid               number  (   11 ) not null
, raceid                 number  (   11 )  not null
, driverid               number  (   11 )  not null
, constructorid          number  (   11 )  not null
, driver_number          number  (   11 )  not null
, grid                   number  (   11 )  not null
, position               number  (   11 ) 
, positiontext           varchar2(  255 ) 
, positionorder          number  (   11 )  not null
, points                 float             not null
, laps                   number  (   11 )  not null
, time                   varchar2(  255 ) 
, milliseconds           number  (   11 ) 
, fastestlap             number  (   11 ) 
, rank                   number  (   11 ) 
, fastestlaptime         varchar2(  255 ) 
, fastestlapspeed        varchar2(  255 ) 
, statusid               number  (   11 )  not null
, constraint pk_results                           
               primary key (resultid)
, constraint fk_results_races                     
               foreign key (raceid)                 
               references races (raceid)
, constraint fk_results_drivers                   
               foreign key (driverid)               
               references drivers (driverid)
, constraint fk_results_constructors              
               foreign key (constructorid)          
               references constructors (constructorid)
, constraint fk_results_status                    
               foreign key (statusid)               
               references status (statusid)
)
/

create table sprintresults (
  sprintresultid         number  (   11 ) not null
, raceid                 number  (   11 ) not null
, driverid               number  (   11 ) not null
, constructorid          number  (   11 ) not null
, driver_number          number  (   11 ) not null
, grid                   number  (   11 ) not null
, position               number  (   11 ) 
, positiontext           varchar2(  255 ) 
, positionorder          number  (   11 )  not null
, points                 float             not null
, laps                   number  (   11 )  not null
, time                   varchar2(  255 ) 
, milliseconds           number  (   11 ) 
, fastestlap             number  (   11 ) 
, fastestlaptime         varchar2(  255 ) 
, statusid               number  (   11 )  not null
, constraint pk_sprintresults                     
               primary key (sprintresultid) 
, constraint fk_sprintresults_races               
               foreign key (raceid)                 
               references races (raceid)
, constraint fk_sprintresults_drivers             
               foreign key (driverid)               
               references drivers (driverid)
, constraint fk_sprintresults_constructors        
               foreign key (constructorid)          
               references constructors (constructorid)
, constraint fk_sprintresults_status              
               foreign key (statusid)               
               references status (statusid)
)
/



