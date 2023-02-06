create or replace package cctestdemo as
  $if $$expose_for_test $then
  procedure private_procedure;
  $end
  procedure public_procedure;
end cctestdemo;
