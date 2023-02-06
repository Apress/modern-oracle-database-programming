create or replace function weekday( date_in in date )
  return varchar2 sql_macro( scalar ) is
begin
  return dayofweek( date_in );
end;
/
