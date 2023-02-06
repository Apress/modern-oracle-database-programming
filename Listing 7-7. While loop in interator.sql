begin
  for power2 in 1, repeat power2 * 2 while power2 <= 1024
  loop
    dbms_output.put_line(power2);
  end loop;
end;
/
