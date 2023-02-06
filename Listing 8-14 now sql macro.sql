create or replace function now
  return varchar2 sql_macro( scalar ) is
begin
  return 'sysdate';
end;
/
