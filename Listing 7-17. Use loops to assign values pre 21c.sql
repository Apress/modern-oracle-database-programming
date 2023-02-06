declare
  type num_list is table of int index by pls_integer;
  s1 num_list;
  s2 num_list;
begin
  for i in 1 .. 10
  loop
    s1(i) := i * 10;
  end loop;

  for i in 1 .. 10
  loop
    if mod(i, 2) = 0
    then
      s2(i) := s1(i);
    end if;
  end loop;
end;
/
