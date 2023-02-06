create table drivers_ext
( driverid      number  (  11 )
, driverref     varchar2( 256 )
, driver_number varchar2( 256 )
, code          varchar2(   4 )
, forename      varchar2( 256 )
, surname       varchar2( 256 )
, dob           date
, nationality   varchar2( 256 )
, url           varchar2( 256 )
) organization external
(
  type oracle_loader
  default directory f1db_csv
  access parameters
  ( -- you can use comments,
    -- but only at the beginning the parameters
    records delimited by newline
    skip 1
    badfile 'drivers.bad'
    logfile 'drivers.log'
    fields terminated by ','
    optionally enclosed by '"'
    ( driverid
    , driverref
    , driver_number
    , code
    , forename
    , surname
    , dob          char( 10 ) date_format date mask "YYYY-MM-DD"
    , nationality
    , url
    )
  )
  location ( 'drivers.csv' )
)
reject limit 0
/
