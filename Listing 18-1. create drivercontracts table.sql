create table driverconstructors as
with resultrace as
( select rsl.driverid
       , rsl.constructorid
       , rcs.year
       , rcs.round
       , rcs.race_date
  from   f1data.results rsl
  join   f1data.races   rcs
  on     ( rsl.raceid = rcs.raceid )
  where  1 = 1
  and    rcs.race_date > to_date('19650101', 'YYYYMMDD')
)
, contractinfo as
( select rrc.driverid
       , rrc.constructorid
       , rrc.year
       , rrc.round
       , case
           when lag( rrc.constructorid )
             over( partition by rrc.driverid order by year
                    ,round ) = rrc.constructorid
           then
             null
           else
             rrc.race_date
         end begincontract
       , case
           when lead( rrc.constructorid )
             over( partition by rrc.driverid order by year
                    ,round ) = rrc.constructorid
           then
             null
           else
             rrc.race_date
         end endcontract
  from   resultrace rrc
)
, contracts as
( select cif.driverid
       , cif.constructorid
       , cif.year
       , cif.round
       , cif.begincontract
       , cif.endcontract
       , sum( case
                when cif.begincontract is null
                then
                  0
                else
                  1
              end )
              over ( partition by driverid order by year
                                     , round) contractnumber
  from   contractinfo cif
)
, all_contracts as
( select con.contractnumber
       , con.driverid
       , con.constructorid
       , min(con.begincontract) as startcontract
       , max(con.endcontract) as endcontract
  from   contracts con
  group  by con.driverid
          , con.constructorid
          , con.contractnumber)
select act.driverid
     , act.constructorid
     , act.startcontract
     , greatest( act.startcontract + 1 / 24 / 60 / 60
               , act.endcontract) as endcontract
from   all_contracts act 
/
