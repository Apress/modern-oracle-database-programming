begin
  $if dbms_db_version.version >= 21 $then
  -- code using the iterators available from 21c
  for n in 2 .. 10 by 2 loop
    dbms_output.put_line(n);
  end loop;
  $else
  -- code using the iterators as available before 21c
  for n in 2 .. 10 loop
    if mod(n, 2) = 0 then
      dbms_output.put_line(n);
    end if;
  end loop;
  $end
end;
