create or replace view v_averagelaptime as 
select ltm.raceid              as raceid
     , ltm.driverid            as driverid
     , sum( ltm.milliseconds ) as totalmilliseconds
     , count( ltm.lap )        as lapcount
     , avg( ltm.milliseconds ) as averagemilliseconds
from   f1data.laptimes ltm
group  by ltm.raceid
        , ltm.driverid
/
