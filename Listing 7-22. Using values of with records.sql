declare
  type driver_aa is table of f1data.drivers%rowtype
    index by pls_integer;
  l_drivers driver_aa;
  cursor drivers is
    select drv.driverid
         , drv.driverref
         , drv.driver_number
         , drv.code
         , drv.forename
         , drv.surname
         , drv.dob
         , drv.nationality
         , drv.url
    from   f1data.drivers drv
    where  drv.nationality = 'Dutch';
begin
  l_drivers := driver_aa( for i in drivers
                            index i.driverid => i );
  for driver in values of l_drivers
  loop
    dbms_output.put_line( 'l_drivers['
                        || driver.driverid 
                        || ']='
                        || driver.driverref
                        );
  end loop;
end;
/ 
