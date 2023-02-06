create or replace function month( date_in in date )
  return varchar2 sql_macro( scalar ) is
begin
  return q'[extract( month from date_in )]';
end;
/
