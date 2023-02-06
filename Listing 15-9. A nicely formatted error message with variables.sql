raise_application_error
   (-20000
   ,apex_string.format (p_message => q'{The combination %0, %1, and %2 is not allowed}'
                       ,p0 => 'A'
                       ,p1 => 'B'
                       ,p2 => 'C'
                       )
   );
