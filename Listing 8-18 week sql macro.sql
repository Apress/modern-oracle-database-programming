create or replace function week( date_in in date )
  return varchar2 sql_macro( scalar ) is
begin
  return q'[to_char( date_in, 'IW' )]';
end;
/
