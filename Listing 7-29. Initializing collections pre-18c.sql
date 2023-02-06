declare
  type numbers_tt is table of number index by pls_integer;
  l_numbers numbers_tt;
begin
  l_numbers(72) := 29;
  l_numbers(76) := 6;
  l_numbers(98) := 18;
  l_numbers(69) := 5;
  
  for indx in indices of l_numbers loop
    dbms_output.put_line( '('
                        ||indx
                        ||') '
                        ||l_numbers(indx)
                        );
  end loop;
end;
/
