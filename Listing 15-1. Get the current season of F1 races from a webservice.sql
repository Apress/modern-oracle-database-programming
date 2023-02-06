declare
  l_response clob;
  l_part     varchar2(4000 char);
  l_offset   pls_integer;
begin
  l_response := apex_web_service.make_rest_request
        ( p_url         => 'http://ergast.com/api/f1/current.json'
        , p_http_method => 'GET'
        );
  sys.dbms_output.put_line( apex_web_service.g_status_code );
  if apex_web_service.g_status_code between 200 and 299 then
    while apex_string.next_chunk
            ( p_str    => l_response
            , p_chunk  => l_part
            , p_offset => l_offset
            , p_amount => 4000
            )
    loop
      sys.dbms_output.put_line ( l_part );
    end loop;
  end if;
end;
/
