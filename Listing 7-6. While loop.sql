declare
  power2 number;
begin
  power2 := 1;
  while power2 <= 1024 loop
    dbms_output.put_line( power2 );
    power2 := power2 * 2;
  end loop;
end;
/
