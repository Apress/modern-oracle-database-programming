declare
  type num_list is table of int index by pls_integer;
  s1 num_list;
  s2 num_list;
begin
  s1 := num_list( for i in 1 .. 10 => i );
  s2 := num_list( for i in 2 .. 10 by 2 => s1( i ) );
end;
/
