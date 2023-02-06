merge into constructorresults tgt
using (select rsl.raceid          as raceid
            , rsl.constructorid   as constructorid
            , sum( rsl.points )   as points
       from   f1data.results rsl
       where  rsl.raceid = g_raceids(indx).raceid
       and    rsl.constructorid = g_raceids(indx).constructorid
       group  by rsl.raceid
               , rsl.constructorid) src
on (    tgt.raceid = src.raceid 
    and tgt.constructorid = src.constructorid )
when matched
then
  update
  set    tgt.points = src.points
when not matched
then
  insert
    ( constructorresultsid
    , raceid
    , constructorid
    , points)
  values
    ( f1data.constructorresults_seq.nextval
    , src.raceid
    , src.constructorid
    , src.points)
/
