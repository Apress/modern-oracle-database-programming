declare
  l_tablen binary_integer;
  l_tab dbms_utility.uncl_array;
  l_drivername varchar2( 32767 );
begin
  for rec in (select distinct ctr.name
                   , dfc.drivers
              from   drivers_for_constructors dfc
              join   driverconstructors as of period
              for    drivercontract to_date( '20220320'
                                           , 'YYYYMMDD') dcr
              on     ( dfc.constructorid = dcr.constructorid )
              join   f1data.constructors ctr
              on     ( dfc.constructorid = ctr.constructorid )
             )
  loop
    dbms_output.put_line( rec.name );
    dbms_utility.comma_to_table( list   => rec.drivers
                               , tablen => l_tablen
                               , tab    => l_tab );
    dbms_output.put_line(  'Nr of drivers: '
                        || to_char( l_tablen )
                        );
    for indx in 1 .. l_tablen
    loop
      select d.forename || ' ' || d.surname as drivername
      into   l_drivername
      from   f1data.drivers d
      where  d.driverref = l_tab( indx );
      dbms_output.put_line(  to_char( indx )
                          || ') '
                          || l_drivername
                          );
    end loop;
  end loop; 
end;
/ 
