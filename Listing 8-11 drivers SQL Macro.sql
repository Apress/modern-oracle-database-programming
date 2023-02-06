create or replace
function drivers( code            in varchar2 default null
                , givenName       in varchar2 default null
                , familyName      in varchar2 default null
                , nationality     in varchar2 default null
                ) return varchar2 sql_macro( table )
is
begin
  return q'[
select f1d.permanentnumber
     , f1d.code
     , f1d.givenname
     , f1d.familyname
     , f1d.dateofbirth
     , f1d.nationality
from   v_f1drivers                 f1d
where  (   drivers.code            is null
        or f1d.code                like drivers.code)
and    (   drivers.givenname       is null
        or f1d.givenname           like drivers.givenname)
and    (   drivers.familyname      is null
        or f1d.familyname          like drivers.familyname)
and    (   drivers.nationality     is null
        or f1d.nationality         like drivers.nationality)
]';
end;
/
