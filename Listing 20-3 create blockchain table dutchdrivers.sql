create blockchain table dutchdrivers 
( driverid      number  (  11 ) not null
, driverref     varchar2( 255 )
, driver_number number  (  11 )
, code          varchar2(   3 )
, forename      varchar2( 255 )
, surname       varchar2( 255 )
, dob           date
, nationality   varchar2( 255 )
, url           varchar2( 255 )
) 
no drop   until 0  days idle
no delete until 16 days after insert
hashing using sha2_512 version v1
/
