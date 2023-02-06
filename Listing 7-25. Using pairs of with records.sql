declare
  type driver_aa is table of f1data.drivers%rowtype
    index by pls_integer;
  l_drivers driver_aa;
  cursor drivers is
    select rv.driverid
         , rv.driverref
         , rv.driver_number
         , rv.code
         , rv.forename
         , rv.surname
         , rv.dob
         , rv.nationality
         , rv.url
    from   f1data.drivers drv
    where  drv.nationality = 'Dutch';
begin
  l_drivers := driver_aa( for i in drivers
                            index i.driverid => i );
  for driverid, driver in pairs of l_drivers
  loop
    dbms_output.put_line( 'l_drivers[' || driverid || ']=' ||
                         driver.driverref );
  end loop;
end;
/
