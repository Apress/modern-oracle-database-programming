with constructor_drivers as
(
select 'c'||to_char (ctr.constructorid) as pk
     , ctr.name
     , null as fk
from   f1data.constructors ctr
where  ctr.constructorref in ('ferrari', 'mercedes')
union  all
select distinct
       'd'||to_char (drv.driverid)
     , drv.surname as driver
     , 'c'||to_char (rst.constructorid) ctr_id
from   f1data.results rst
join   f1data.drivers drv
  on   drv.driverid = rst.driverid
)
, hierarchy (pk, name, fk)
as (
select pk
     , name
     , fk
from   constructor_drivers
where  fk is null
union  all
select cdv.pk
     , cdv.name
     , cdv.fk
from   constructor_drivers cdv
join   hierarchy hier
  on   hier.pk = cdv.fk
)
select pk
     , name
     , fk
from   hierarchy
/
