create or replace package ccexception as
  function getdobfordriver( driverid_in in number ) 
    return date;
end ccexception;
/
