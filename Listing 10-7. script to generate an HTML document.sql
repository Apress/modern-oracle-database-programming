create table profiler
( reports clob )
/

declare
  l_trace_id number;
  l_clob clob;
begin
  dbms_hprof.create_tables( force_it => true );
  l_trace_id := dbms_hprof.start_profiling
                  ( run_comment => 'HProf Demo' );
  
  f1info.show_season(2022);
  
  dbms_hprof.stop_profiling;
  
  dbms_hprof.analyze( trace_id => l_trace_id
                    , report_clob => l_clob
                    );
  insert into profiler(reports) values (l_clob);
end;
/
