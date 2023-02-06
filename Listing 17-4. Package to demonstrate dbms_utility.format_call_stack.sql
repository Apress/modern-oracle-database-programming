create or replace package call_stack_demo is

  procedure packageprocedure;

end call_stack_demo;
/

create or replace package body call_stack_demo is

  procedure privateprocedure is
  begin
    dbms_output.put_line('-- call stack in PRIVATEPROCEDURE --');
    dbms_output.put_line( dbms_utility.format_call_stack );
    dbms_output.put_line('------------------------------------');
  end privateprocedure;
  
  procedure packageprocedure is
  begin
    dbms_output.put_line('-- call stack in PACKAGEPROCEDURE --');
    dbms_output.put_line( dbms_utility.format_call_stack );
    dbms_output.put_line('------------------------------------');
    privateprocedure;
  end packageprocedure;

end call_stack_demo;
/
