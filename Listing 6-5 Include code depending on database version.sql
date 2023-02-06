begin
  $if dbms_db_version.version <= 19 $then
  dbms_output.put_line( 'pre Oracle 19c code' );
  $else
  dbms_output.put_line( 'post Oracle 19c code' );
  $end
end;
