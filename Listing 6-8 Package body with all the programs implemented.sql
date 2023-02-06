create or replace package body cctestdemo as
  procedure private_procedure
  is
  begin
    dbms_output.put_line('=> This is the private_procedure <=');
  end private_procedure;
  
  procedure public_procedure
  is
  begin
    dbms_output.put_line('=> This is the public_procedure <=');
  end public_procedure;
end cctestdemo;
