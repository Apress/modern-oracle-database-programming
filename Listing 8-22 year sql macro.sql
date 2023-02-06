create or replace function year( date_in in date )
  return varchar2 sql_macro( scalar ) is
begin
  return q'[extract( year from date_in )]';
end;
/
