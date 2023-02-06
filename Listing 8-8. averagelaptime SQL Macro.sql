create or replace 
function averagelaptime( raceid_in   in number
                       , driverid_in in number ) 
  return varchar2 sql_macro( table ) is
begin
  return q'[
select ltm.raceid              as raceid
     , ltm.driverid            as driverid
     , sum( ltm.milliseconds ) as totalmilliseconds
     , count( ltm.lap )        as lapcount
     , avg( ltm.milliseconds ) as averagemilliseconds
from   f1data.laptimes ltm
where  ltm.raceid   = raceid_in
and    ltm.driverid = driverid_in
group  by ltm.raceid
        , ltm.driverid
]';
end;
/
