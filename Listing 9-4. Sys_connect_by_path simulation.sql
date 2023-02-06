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
union  all
select 'champ'||to_char (min (dsg.driverstandingsid))
     , to_char (rce.year)||' (' 
     || to_char (max (dsg.points)|| ' points)') as points
     , 'd'||to_char (max (dsg.driverid) keep (dense_rank first order  by dsg.points desc)) as driver
from   f1data.races rce
join   f1data.driverstandings dsg
  on   rce.raceid = dsg.raceid
group  by rce.year
)
, hierarchy (pk, name, fk, lvl, scbp, cbr)
as (
select pk
     , name
     , fk
     , 1    as lvl
     , name as scbp
     , name as cbr
from   constructor_drivers
where  fk is null
union  all
select cdv.pk
     , lpad ('.', hier.lvl * 2, '.')||cdv.name
     , cdv.fk
     , hier.lvl + 1
     , hier.scbp ||', '||cdv.name
     , hier.cbr
from   constructor_drivers cdv
join   hierarchy hier
  on   hier.pk = cdv.fk
) search depth first by name set seq
select lvl
     , scbp
     , cbr
     , case 
       when lvl >= lead ( lvl, 1, 1 )
                   over ( order by seq )
       then 'Y' 
       else 'N' 
       end as leaf
from   hierarchy
/
