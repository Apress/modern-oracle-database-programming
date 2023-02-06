create or replace function day( date_in in date )
  return varchar2 sql_macro( scalar ) is
begin
  return q'[extract( day from date_in )]';
end;
/
