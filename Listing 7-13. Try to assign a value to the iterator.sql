begin
  for i in 1 .. 10
  loop
    dbms_output.put_line(i);
    i := i + 3;
  end loop;
end;
/
