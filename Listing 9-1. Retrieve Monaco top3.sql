with monaco as (
select rsl.driverid
     , rsl.position
     , rcs.year
from   f1data.circuits cct
join   f1data.races rcs
  on   cct.circuitid = rcs.circuitid
join   f1data.results rsl
  on   rcs.raceid = rsl.raceid
where  cct.circuitref = 'monaco'
and    rsl.position <= 3
)
, motorists as (
select drv.driverid
     , drv.forename
       || ' ' ||
       drv.surname as driver
from   f1data.drivers drv
)
,monaco_podiums as (
select mon.year
     , mon.position
     , mtt.driver
from   monaco mon
join   motorists mtt
  on   mon.driverid = mtt.driverid
)
select year
     , first
     , second
     , third
from   monaco_podiums
pivot  (
        min(driver)
        for position in ( 1 as first
                        , 2 as second
                        , 3 as third
                        )
       )
order by year
/
