declare
   l_circuit  mdsys.sdo_geometry;
   l_hometown mdsys.sdo_geometry;
   races      apex_json.t_values;
   l_races    clob;
begin
   l_hometown := apex_spatial.point
                   ( p_lon => 4.861316883708699
                   , p_lat => 51.64485385756768
                   );
   l_races := apex_web_service.make_rest_request
                ( p_url         => 'http://ergast.com/api/f1/current.json'
                , p_http_method => 'GET'
                );
   apex_json.parse ( p_values => races
                   , p_source => l_races
                   );
   l_circuit := apex_spatial.point
                  ( p_lon =>  apex_json.get_number ( p_path => 'MRData.RaceTable.Races[15].Circuit.Location.long'
                                                   , p_values => races)
                  , p_lat => apex_json.get_number ( p_path => 'MRData.RaceTable.Races[15].Circuit.Location.lat'
                                                  , p_values => races)
                  );
   sys.dbms_output.put_line (
      'The distance from my hometown to the circuit is '
      ||sdo_geom.sdo_distance
           (geom1 => l_hometown
           ,geom2 => l_circuit
           ,unit  => 'unit=KM')
      ||' km'
   );
end;
/
