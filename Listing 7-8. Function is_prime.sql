create or replace function is_prime(number_in in number)
  return boolean is
  l_returnvalue boolean := true;
begin
  for indx in 2 .. number_in / 2
  loop
    if mod(number_in, indx) = 0
    then
      l_returnvalue := false;
      exit;
    end if;
  end loop;
  return l_returnvalue;
end;
/
