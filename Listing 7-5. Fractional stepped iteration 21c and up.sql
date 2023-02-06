begin
  for i number(3, 1) in 1 .. 10 by 0.5
  loop
    dbms_output.put_line(i);
  end loop;
end;
/
