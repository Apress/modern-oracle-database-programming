create or replace package body error_stack_demo is

  procedure privateprocedure is
  begin
    raise no_data_found;
  end privateprocedure;
  
  procedure packageprocedure is
  begin
    privateprocedure;
  exception
    when others
    then
    dbms_output.put_line('-- error stack in PACKAGEPROCEDURE--');
    dbms_output.put_line( dbms_utility.format_error_stack );
    dbms_output.put_line('------------------------------------');
    dbms_output.put_line('-error backtrace in PACKAGEPROCEDURE');
    dbms_output.put_line( dbms_utility.format_error_backtrace );
    dbms_output.put_line('------------------------------------');
  end packageprocedure;

end error_stack_demo;
/
