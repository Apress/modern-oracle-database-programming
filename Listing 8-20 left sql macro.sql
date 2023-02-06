create or replace function left
(
  string_in in varchar2
, left_in   in number
) return varchar2 sql_macro( scalar ) is
  l_sql varchar2( 64 );
begin
  l_sql := 'substr( string_in, 1, left_in )';
  return l_sql;
end left;
/
