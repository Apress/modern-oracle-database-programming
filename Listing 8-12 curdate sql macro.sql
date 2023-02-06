create or replace function curdate
  ( format_in in varchar2 default 'DD/MM/YYYY' )
  return varchar2 sql_macro( scalar ) is
begin
  return 'to_char( sysdate, format_in )';
end;
/
