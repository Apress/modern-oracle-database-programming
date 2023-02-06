create or replace package split_ptf is
  function describe
  (
    tab  in out dbms_tf.table_t
  , cols in     dbms_tf.columns_t default null
  ) return dbms_tf.describe_t;

  procedure fetch_rows;
end split_ptf;
/
