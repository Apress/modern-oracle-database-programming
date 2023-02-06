declare
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
begin
  dbms_output.put_line( 'Drivers:');
  for rec rec_t in (select drv.driverid
                         , drv.driverref
                         , drv.forename || ' ' 
                                        || drv.surname
                         , drv.nationality
                    from   f1data.drivers drv
                    where  rownum < 11) loop
    printit(rec_in => rec);
  end loop;
  dbms_output.put_line( 'Constructors:');
  for rec rec_t in (select ctr.constructorid
                         , ctr.constructorref
                         , ctr.name
                         , ctr.nationality
                    from   f1data.constructors ctr
                    where  rownum < 11) loop
    printit(rec_in => rec);
  end loop;
end;
/
