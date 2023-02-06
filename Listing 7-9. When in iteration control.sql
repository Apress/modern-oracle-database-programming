begin
  for i in 1 .. 100 when is_prime(i) and i not in (19, 37)
  loop
    dbms_output.put_line(i);
  end loop;
end;
/
