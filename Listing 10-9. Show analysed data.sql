select 
  lpad(' ', level, ' ')||pf.function||' -> '||cf.function call,  
  pc.subtree_elapsed_time, 
  pc.function_elapsed_time, 
  pc.calls, 
  cf.line#  
from 
  (select * from dbmshp_parent_child_info where runid=1) pc,
  dbmshp_function_info pf, 
  dbmshp_function_info cf
where pc.runid=pf.runid
  and pc.parentsymid=pf.symbolid
  and pc.runid=cf.runid
  and pc.childsymid=cf.symbolid
connect by prior pc.childsymid=pc.parentsymid
start with pc.parentsymid = 3
/
