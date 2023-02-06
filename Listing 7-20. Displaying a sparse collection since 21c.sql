declare
  type num_list is table of int index by pls_integer;

  s2 num_list;
begin

  s2 := num_list(for i in 2 .. 10 by 2 => i * 10);

  for idx in indices of s2
  loop
    dbms_output.put_line(idx || '=' || s2(idx));
  end loop;
end;
/ 
