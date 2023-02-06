declare
   l_ename_t apex_t_varchar2;
begin
  select ename
  bulk   collect
  into   l_ename_t
  from   emp;
  sys.dbms_output.put_line
    ( apex_string.join ( p_table => l_ename_t
                       , p_sep   => '~'
                       )
    );
end;
/
