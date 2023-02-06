create or replace trigger tr_results_ariu
  after insert or update on f1data.results
  for each row
begin
  merge into f1data.constructorresults tgt
  using (select rsl.raceid        as raceid
              , rsl.constructorid as constructorid
              , sum( rsl.points ) as points
         from   f1data.results rsl
         where  rsl.raceid        = :new.raceid
         and    rsl.constructorid = :new.constructorid
         group  by rsl.raceid
                 , rsl.constructorid) src
  on (    tgt.raceid        = src.raceid 
      and tgt.constructorid = src.constructorid)
  when matched then
    update
    set    tgr.points = src.points
  when not matched then
    insert
      ( constructorresultsid
      , raceid
      , constructorid
      , points)
    values
      ( f1data.constructorresults_seq.nextval
      , src.raceid
      , src.constructorid
      , src.points);
end tr_results_ariu;
/
