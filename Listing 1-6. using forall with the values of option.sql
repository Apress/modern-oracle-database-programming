declare
  cursor c_drivers
  is
  select drv.*
  from   f1data.drivers drv
  ;

  type drivers_tt is table of f1data.drivers%rowtype
    index by pls_integer;
  type driver_numbers_tt is table of pls_integer
    index by pls_integer;

  l_drivers             drivers_tt;
  l_drivers_with_number drivers_tt;
  l_driver_numbers      driver_numbers_tt;

begin
  open c_drivers;
  fetch c_drivers
  bulk  collect into l_drivers;
  close c_drivers;

  if l_drivers.count > 0
  then
    for indx in l_drivers.first .. l_drivers.last
    loop
      if l_drivers( indx ).driver_number is not null
      then
        l_drivers_with_number(l_drivers( indx ).driver_number) :=
          l_drivers( indx );
        l_driver_numbers( l_driver_numbers.count + 1 ) :=
          l_drivers( indx ).driver_number;
      end if;
    end loop;
  end if;

  if l_driver_numbers.count > 0
  then
    forall indx in values of l_driver_numbers
      insert into drivers_with_number
      values l_drivers_with_number( indx );
  end if;
end;
/
