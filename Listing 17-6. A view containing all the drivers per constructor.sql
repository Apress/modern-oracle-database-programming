create or replace view drivers_for_constructors
as
select dcr.constructorid                         as constructorid
     , ctr.name                                  as name
     , listagg( distinct( drv.driverref ), ',' ) as drivers
from   driverconstructors  dcr
join   f1data.constructors ctr
  on ( dcr.constructorid = ctr.constructorid )
join   f1data.drivers      drv
  on ( dcr.driverid      = drv.driverid )
group  by dcr.constructorid
        , ctr.name
/
