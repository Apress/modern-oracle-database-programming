create or replace function fullname_udf
( forename_in in varchar2
, surname_in  in varchar2 )
return varchar2
is
  pragma udf;
  l_returnvalue varchar2( 32767 );
begin
  l_returnvalue := initcap( forename_in )
                || ' '
                || initcap( surname_in );
  return l_returnvalue;
end;
/
