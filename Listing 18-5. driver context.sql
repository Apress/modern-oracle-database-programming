create or replace context driver_ctx using driver_pkg
/
create or replace package driver_pkg as
  procedure set_driver( driverid_in in number );
  procedure unset_driver;
end driver_pkg;
/
create or replace package body driver_pkg as
  procedure set_driver(driverid_in in number) is
  begin
    sys.dbms_session.set_context
    ( namespace => 'driver_ctx'
    , attribute => 'driverid'
    , value     => driverid_in
    );
  end set_driver;
  
  procedure unset_driver is
  begin
    sys.dbms_session.clear_context
    ( namespace => 'driver_ctx' );
  end unset_driver;
end driver_pkg;
/
