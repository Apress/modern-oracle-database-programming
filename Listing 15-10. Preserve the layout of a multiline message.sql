begin
   sys.dbms_output.put_line (
      apex_string.format (
         p_message => q'{Things you should do:
                        !   * Get quality sleep
                        !   * Eat Healthy
                        !   * Exercise regularly
                        !and all will be well}'
        ,p_prefix => '!'
      ));
end;
/
