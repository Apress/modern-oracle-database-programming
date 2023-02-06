declare
  cursor c_drivers
  is
  select drv.*
  from   f1data.drivers drv
  where  drv.driver_number is not null
  order  by drv.dob
  ;

  type drivers_tt is table of f1data.drivers%rowtype
    index by pls_integer;

  l_drivers drivers_tt;

begin
  open  c_drivers;
  fetch c_drivers
  bulk  collect into l_drivers;
  close c_drivers;

  if l_drivers.count > 0
  then
    forall indx in l_drivers.first .. l_drivers.last
      insert into drivers_with_number
      values l_drivers( indx );
  end if;
end;
/
