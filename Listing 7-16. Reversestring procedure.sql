create or replace procedure
  reversestring(string_inout in out varchar2)
is
  l_reversed varchar2( 32767 );
  l_strlen number;
begin
  l_strlen := length( string_inout );
  for i in reverse 1..l_strlen
  loop
    l_reversed := l_reversed || substr( string_inout, i, 1 );
  end loop;
  string_inout := l_reversed;
end;
/
