declare
  type numbers_tt is table of number index by pls_integer;
  l_numbers numbers_tt;
begin
  l_numbers := numbers_tt( 72 => 29
                         , 76 => 6
                         , 98 => 18
                         , 69 => 5
                         );
  
  for indx in indices of l_numbers loop
    dbms_output.put_line( '('
                        ||indx
                        ||') '
                        ||l_numbers(indx)
                        );
  end loop;
end;
/
