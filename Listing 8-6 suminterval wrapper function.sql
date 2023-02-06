create or replace function suminterval_fnc
(
  tab  in table
 ,cols in columns default null
) return table
pipelined table polymorphic using suminterval_ptf;
/
