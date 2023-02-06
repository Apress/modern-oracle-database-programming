create or replace package body f1info is
  procedure show_driver(driverid_in in number)
  is
    l_forename    f1data.drivers.forename%type;
    l_surname     f1data.drivers.surname%type;
    l_nationality f1data.drivers.nationality%type;
  begin
    select drv.forename
         , drv.surname
         , drv.nationality
    into   l_forename
         , l_surname
         , l_nationality
    from   f1data.drivers drv
    where  drv.driverid = driverid_in;
    
    dbms_output.put_line( '  '
                        ||l_forename
                        ||' '
                        ||l_surname
                        ||'(' 
                        ||l_nationality 
                        ||')'
                        );
  end show_driver;
  
  procedure show_constructor( year_in          in number
                            , constructorid_in in number
                            )
  is
    l_name        f1data.constructors.name%type;
    l_nationality f1data.constructors.nationality%type;
    
  begin
    select ctr.name
         , ctr.nationality
    into   l_name
         , l_nationality
    from   f1data.constructors ctr
    where  ctr.constructorid = constructorid_in;
    
    dbms_output.put_line( l_name
                        ||'(' 
                        ||l_nationality 
                        ||')'
                        );
    for driver in 
      (select distinct rsl.driverid
       from   f1data.results rsl
       join   f1data.races   rcs  
         on   (rsl.raceid = rcs.raceid)
       where  1=1
       and    rcs.year = year_in
       and    rsl.constructorid = constructorid_in
      ) loop
      show_driver( driverid_in => driver.driverid );
    end loop;
  end show_constructor;
  
  procedure show_season(year_in in number)
  is
  begin
    for constructor in
      (select distinct rsl.constructorid
       from   f1data.results rsl
       join   f1data.races   rcs
         on   (rsl.raceid = rcs.raceid)
       where  1=1
       and    rcs.year = year_in
      ) loop
      show_constructor
        ( year_in          => year_in
        , constructorid_in => constructor.constructorid
        );
    end loop;
  end show_season;
end f1info;
/
