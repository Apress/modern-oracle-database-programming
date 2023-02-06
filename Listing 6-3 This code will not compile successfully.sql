create or replace package willnotcompile as
  the_answer constant number := 42;
  $error 'This package should not be compiled' $end
  wear_towel constant boolean := true;
end willnotcompile;
