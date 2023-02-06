create or replace trigger f1data.tr_results_cti
  for insert or update or delete on f1data.results
  compound trigger
-- declarative section (optional)
  type raceid_t is record
   ( raceid        number
   , constructorid number);
  type raceids_tt is table of raceid_t
    index by pls_integer;
  -- variables declared here have firing-statement duration.
  g_raceids raceids_tt;
  --executed before dml statement
  before statement is
  begin
    null;
  end before statement;

  --executed aftereach row change- :new, :old are available
  after each row is
  begin
    g_raceids(:new.constructorid).raceid := 
                             :new.raceid;
    g_raceids(:new.constructorid).constructorid := 
                             :new.constructorid;
  end after each row;

  --executed after dml statement
  after statement is
  begin
    forall indx in indices of g_raceids
      merge into f1data.constructorresults tgt
      using (select rsl.raceid
                  , rsl.constructorid
                  , sum( rsl.points ) as points
             from   f1data.results rsl
             where  rsl.raceid = 
                       g_raceids( indx ).raceid
             and    rsl.constructorid = 
                       g_raceids(indx).constructorid
             group  by rsl.raceid
                      ,rsl.constructorid) src
      on (    tgt.raceid        = src.raceid
          and tgt.constructorid = src.constructorid)
      when matched then
        update
        set    tgt.points = src.points
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
  end after statement;

end tr_results_cti;
/
