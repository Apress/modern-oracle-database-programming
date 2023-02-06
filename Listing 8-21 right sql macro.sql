create or replace function right
(
  string_in in varchar2
, right_in  in number
) return varchar2 sql_macro( scalar ) is
  l_sql varchar2( 32767 );
begin
  l_sql := '
case
  when right_in <= 0 then null
  when right_in > length( string_in ) then  string_in
  else substr( string_in, -right_in )
end
';
  return l_sql;
end right;
/
