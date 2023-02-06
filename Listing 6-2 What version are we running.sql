begin
  $if dbms_db_version.ver_le_12 $then
  dbms_output.put_line( 'This will run 12c code.' );
  $elsif dbms_db_version.ver_le_18 $then
  dbms_output.put_line( 'This will run 18c code.' );
  $elsif dbms_db_version.ver_le_19 $then
  dbms_output.put_line( 'This will run 19c code.' );
  $elsif dbms_db_version.ver_le_20 $then
  dbms_output.put_line( 'This will run 20c code.' );
  $elsif dbms_db_version.ver_le_21 $then
  dbms_output.put_line( 'This will run 21c code.' );
  $else
  dbms_output.put_line( 'This version is not supported' );
  $end
end;
/
