select ltm.lap
     , ltm.milliseconds
     , sum (ltm.milliseconds) over (
         order by ltm.lap
         rows between unbounded preceding
                  and current row
       ) as running_total
from   f1data.laptimes ltm
join   f1data.races rcs
  on   rcs.raceid = ltm.raceid
where  rcs.race_date between trunc (sysdate, 'yy') and sysdate
and    ltm.driverid = 844 -- Charles Leclerc
and    rcs.raceid = 1074 -- Bahrain Grand Prix
and    ltm.lap between 1 and 10
order  by ltm.lap
/
