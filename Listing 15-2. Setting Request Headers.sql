apex_web_service.g_request_headers(1).name  := 'Authorization';
apex_web_service.g_request_headers(1).value := 'Bearer ' || l_bearer_token;
apex_web_service.g_request_headers(2).name  := 'Content-Type';
apex_web_service.g_request_headers(2).value := 'application/json';
