declare
  type num_list is table of int index by pls_integer;
  s1 num_list;
  s2 num_list;
begin
  s1 := num_list(10, 20, 30, 40, 50, 60, 70, 80, 90, 1000);
  s2 := num_list(for i in 2 .. 10 by 2 => s1(i));

  for x, y in pairs of s2
  loop
    dbms_output.put_line(x || ',' || y);
  end loop;
end;
/
