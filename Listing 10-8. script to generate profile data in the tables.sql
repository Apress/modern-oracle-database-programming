declare
  l_trace_id number;
  l_analyze_id number;
begin
  dbms_hprof.create_tables( force_it => true );
  l_trace_id := dbms_hprof.start_profiling
                  ( run_comment => 'HProf Demo' );
  
  f1info.show_season(2022);
  
  dbms_hprof.stop_profiling;
  
  l_analyze_id := dbms_hprof.analyze
                    ( trace_id => l_trace_id 
                    , run_comment => 'HProf Demo' 
                    );
  dbms_output.put_line( l_analyze_id );
end;
/
