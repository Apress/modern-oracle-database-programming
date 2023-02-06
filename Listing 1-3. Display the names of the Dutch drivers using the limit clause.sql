declare
  cursor c_dutch_drivers
  is
  select drv.*
  from   f1data.drivers drv
  where  drv.nationality = 'Dutch'
  ;
  
  type dutch_drivers_tt is table of f1data.drivers%rowtype
    index by pls_integer;
  
  l_dutch_drivers dutch_drivers_tt;
begin
  open  c_dutch_drivers;
  loop
    fetch c_dutch_drivers
    bulk  collect
    into  l_dutch_drivers
    limit 5;
    dbms_output.put_line(  '----- ' 
    || to_char( l_dutch_drivers.count )
    || ' -----');
    if l_dutch_drivers.count > 0
    then
 for indx in l_dutch_drivers.first ..
   l_dutch_drivers.last
 loop
   dbms_output.put_line(  l_dutch_drivers( indx ).forename
   || ' '
   || l_dutch_drivers( indx ).surname);
 end loop;
    else
 exit;
    end if;
  end loop;
  close c_dutch_drivers;
end;
/
