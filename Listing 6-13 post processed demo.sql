create or replace package postprocesseddemo as
  $if $$exposeprocedure $then
  procedure private_procedure;
  $end
  procedure public_procedure;
end postprocesseddemo;
