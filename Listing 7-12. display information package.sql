create or replace package information is
  procedure display(refcursor_in in sys_refcursor);
end information;
/

create or replace package body information is
  type rec_t is record
    ( id          number(11) 
    , ref         varchar2(255) 
    , name        varchar2(255) 
    , nationality varchar2(255)
    );
  procedure printit(rec_in in rec_t)
  is
  begin
    dbms_output.put_line
    ( rec_in.id
    ||'('
    ||rec_in.ref
    ||')'
    ||rec_in.name
    ||'-'
    ||rec_in.nationality 
    );
  end;
  procedure display(refcursor_in in sys_refcursor)
  is
  begin
    for rec rec_t in values of refcursor_in loop
      printit(rec_in => rec);
    end loop;
  end display;
end information;
/
