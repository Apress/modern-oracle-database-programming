begin
  for i in 1 .. 20
  loop
    if mod(i, 3) = 1
    then
      dbms_output.put_line(i);
    end if;
  end loop;
end;
/
