declare
  type num_list is table of int index by pls_integer;
  
  s2 num_list;
  idx int;
begin

  s2 := num_list(2  => 20
                ,4  => 40
                ,6  => 60
                ,8  => 80
                ,10 => 100);

  idx := s2.first;
  while idx is not null
  loop
    dbms_output.put_line(idx || '=' || s2(idx));
    idx := s2.next(idx);
  end loop;
end;
/
