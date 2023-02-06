begin
  dbms_output.put_line( 'Drivers:');
  for rec in (select drv.driverid
                   , drv.driverref
                   , drv.forename || ' ' 
                                  || drv.surname as name
                   , drv.nationality
              from   f1data.drivers drv
             ) loop
    dbms_output.put_line( rec.driverid
                        ||'('
                        ||rec.driverref
                        ||')'
                        ||rec.name
                        ||'-'
                        ||rec.nationality 
                        );
  end loop;
  dbms_output.put_line( 'Constructors:');
  for rec in (select ctr.constructorid
                   , ctr.constructorref
                   , ctr.name
                   , ctr.nationality
              from   f1data.constructors ctr
             ) loop
    dbms_output.put_line( rec.constructorid
                        ||'('
                        ||rec.constructorref
                        ||')'
                        ||rec.name
                        ||'-'
                        ||rec.nationality 
                        );
  end loop;
end;
/
