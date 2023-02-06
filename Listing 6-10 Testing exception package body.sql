create or replace package body ccexception as
  function getdobfordriver( driverid_in in number ) 
    return date
  is
    l_dob date;
  begin
    begin
      $if $$testexceptions $then
      case
        when mod( driverid_in, 2 ) = 0 
        then raise no_data_found;
        else raise too_many_rows;
      end case;
      $else
      select drv.dob
      into   l_dob
      from   f1data.drivers drv
      where  drv.driverid = driverid_in;
      $end
    exception
      when no_data_found
      then
        $if $$testexceptions $then
        dbms_output.put_line( 'no_data_found' );
        $end
        l_dob := null;
      when too_many_rows
      then 
        $if $$testexceptions $then
        dbms_output.put_line( 'too_many_rows' );
        $end
        l_dob := to_date('19721229', 'YYYYMMDD');
    end;
    return l_dob;
  end getdobfordriver;
end ccexception;
/
