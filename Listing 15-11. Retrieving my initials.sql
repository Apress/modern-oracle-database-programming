begin
   sys.dbms_output.put_line (
      apex_string.get_initials (
         p_str => 'alex nuijten'
        ,p_cnt => 4
      )
   );
end;
/
