with 
function fullname( forename_in    in varchar2
                 , surname_in     in varchar2
                 , constructor_in in varchar2 )
return varchar2
is
begin
  return forename_in
         || ' ' || surname_in
         || ' (' || constructor_in || ')';
end fullname;
function formattop3( pos1 in varchar2
                   , pos2 in varchar2
                   , pos3 in varchar2 )
return varchar2
is
begin
  return '1) ' || pos1 || chr(10)
      || '2) ' || pos2 || chr(10)
      || '3) ' || pos3 || chr(10);
end formattop3;
monaco as (
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
     , fullname ( drv.forename
                , drv.surname
                , ctr.name
                ) as driver
from   f1data.drivers      drv
join   f1data.results      rsl
  on   drv.driverid = rsl.driverid
join   f1data.constructors ctr
  on   rsl.constructorid = ctr.constructorid
)
, monaco_podiums as (
select mon.year
     , mon.position
     , mtt.driver
from   monaco mon
join   motorists mtt
  on   mon.driverid = mtt.driverid
)
, monaco_pivot as (
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
)
select year
     , formattop3 ( first
                  , second
                  , third
                  ) as formatted
from   monaco_pivot
where  year < 1958
order by year
/
