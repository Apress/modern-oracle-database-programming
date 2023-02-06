drop table native_json purge
/

create table native_json
(id number generated always as identity primary key
,json_document json
)
/
declare
   b blob;
begin
   for i in 1.. 71
   loop
      b := apex_web_service.make_rest_request_b
        (p_url         => 'http://ergast.com/api/f1/'||to_char (1949 + i)||'/driverstandings.json?limit=500'
        ,p_http_method => 'GET'
        );
      insert into native_json
         (json_document)
      values (b);   
   end loop;
end;
/
commit
/