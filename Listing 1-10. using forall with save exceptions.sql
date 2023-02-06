declare
  cursor c_drivers is
    select drv.*
    from   f1data.drivers drv
    where  drv.driver_number is not null
    order  by drv.dob;

  type drivers_tt is table of f1data.drivers%rowtype
    index by pls_integer;

  l_drivers drivers_tt;

  failure_in_forall exception;
  pragma exception_init( failure_in_forall, -24381 );
begin
  open  c_drivers;
  fetch c_drivers
  bulk  collect into l_drivers;
  close c_drivers;

  if l_drivers.count > 0
  then
    begin
      forall indx in l_drivers.first .. l_drivers.last
        save exceptions insert
          into drivers_with_number values l_drivers(indx);
    exception
      when failure_in_forall then
        for indx in 1 .. sql%bulk_exceptions.count
        loop
          dbms_output.put_line(  'Error ' 
                              || indx 
                              || ' occurred on index ' 
                              || sql%bulk_exceptions( indx ).
                                   error_index 
                              || '.'
                              );
          dbms_output.put_line(  'Oracle error is '
                              || sqlerrm( -1 * 
                                   sql%bulk_exceptions( indx ).
                                     error_code)
                              );        end loop;
    end;
  end if;
end;
/
