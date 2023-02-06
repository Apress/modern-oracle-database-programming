select points
     , whole_partition
     , rows_
     , groups_
     , range_
from   (
        select drv.driverid
             , drs.points
             , max (drs.points) over w_part  as whole_partition
             , max (drs.points) over w_rows  as rows_
             , max (drs.points) over w_group as groups_
             , max (drs.points) over w_range as range_ 
        from   f1data.driverstandings drs
        join   f1data.drivers drv
          on   drv.driverid = drs.driverid
        window w_part  as (partition by drv.driverid)
             , w_sort  as (w_part order by drs.points desc)
             , w_rows  as (w_sort rows   between 10 preceding
                                             and current row)
             , w_group as (w_sort groups between 10 preceding
                                             and current row)
             , w_range as (w_sort range  between 10 preceding
                                             and current row)
       )
where  driverid = 815
and    rownum <= 20
order  by driverid, points desc
/
 
