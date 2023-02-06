create or replace function split
(
  tab  in table
, cols in columns default null
) return table
pipelined row polymorphic using split_ptf;
/
