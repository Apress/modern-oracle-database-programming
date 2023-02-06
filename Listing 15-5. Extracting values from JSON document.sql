declare
  races      apex_json.t_values;
  l_races    clob;
  l_elements apex_t_varchar2;
begin
   l_races := apex_web_service.make_rest_request
                ( p_url=> 'http://ergast.com/api/f1/current.json'
                , p_http_method => 'GET'
                );
   if apex_web_service.g_status_code between 200 and 299
   then
      apex_json.parse ( p_values => races
                      , p_source => l_races
                      );
      sys.dbms_output.put_line (
         'Season: '||
         apex_json.get_number
             ( p_path   => 'MRData.RaceTable.season'
             , p_values => races)
      );
      sys.dbms_output.put_line (
         'Nr of races: '||
         apex_json.get_number
             ( p_path   => 'MRData.total'
             , p_values => races)
      );
      sys.dbms_output.put_line (
         'First Race: '||
         apex_json.get_varchar2
              ( p_path => 'MRData.RaceTable.Races[1].raceName'
              , p_values => races)
      );
   end if;
end;
/
