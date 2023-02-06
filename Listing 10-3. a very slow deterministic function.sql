create or replace function myslowfunction( p_in in number )
return number
deterministic
is
begin
  dbms_session.sleep( 1 );
  return p_in;
end;
/
