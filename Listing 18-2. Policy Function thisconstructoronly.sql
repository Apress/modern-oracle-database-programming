create or replace function thisconstructoronly
( schemaname_in in varchar2
, tablename_in  in varchar2
) return varchar2
is
begin
  return q'[constructorid = sys_context
                                    ( 'CONSTRUCTOR_CTX'
                                    , 'CONSTRUCTORID'
                                    )]';
end;
/
