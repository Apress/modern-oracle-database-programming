create or replace package body split_ptf as
  subtype maxvarchar2 is varchar2( 32767 );
  function describe
  (
    tab  in out dbms_tf.table_t
  , cols in     dbms_tf.columns_t default null
  ) return dbms_tf.describe_t as
    -- metadata for column to add
    l_new_col dbms_tf.column_metadata_t;

    -- table of columns to add
    l_new_cols dbms_tf.columns_new_t;
  begin
-- Mark the first column to be read and don't display it anymore
    tab.column( 1 ).for_read     := true;
    tab.column( 1 ).pass_through := false;
    -- Add the new columns, as specified in the cols parameter
    for indx in 1 .. cols.count
    loop
      -- define metadata for column named cols(indx)
      l_new_col := dbms_tf.column_metadata_t
                   ( type    => dbms_tf.type_varchar2
                   , max_len => 4000
                   , name    => cols( indx )
                   );
      -- add the new column to the list of columns new columns
      l_new_cols( l_new_cols.count + 1 ) := l_new_col;
    end loop;
    -- Now we return a specific DESCRIBE_T that adds new columns
    return dbms_tf.describe_t( new_columns => l_new_cols );
  end;

  procedure fetch_rows is
    -- define a table type of varchar2 tables
    type colset is table of dbms_tf.tab_varchar2_t
      index by pls_integer;

    -- variable to hold the rowset as retrieved
    l_rowset dbms_tf.row_set_t;

    -- variable to hold the number of rows as retrieved
    l_rowcount pls_integer;

    -- variable to hold the number of (out)put columns
    l_putcolcount pls_integer :=
      dbms_tf.get_env().put_columns.count;

    -- variable to hold the new values
    l_newcolset colset;
    -- the value of the column
    l_columnvalue maxvarchar2;
  begin
    -- fetch rows into a local rowset
    -- at this point the rows will have columns
    -- from the the table/view/query passed in
    dbms_tf.get_row_set( rowset    => l_rowset
                       , row_count =>  l_rowcount
                       );
    -- for every row in the rowset...
    for rowindx in 1 .. l_rowcount
    loop
      -- for every column
      for colindx in 1 .. l_putcolcount
      loop
        l_columnvalue := trim(both '"' from 
                           dbms_tf.col_to_char( l_rowset( 1 )
                                              , rowindx ) );
        l_newcolset(colindx)(rowindx) := trim( ';' from
                                     regexp_substr( l_columnvalue
                                                  , '[^;]*;{0,1}'
                                                  , 1
                                                  , colindx
                                                  ) 
                                             );
      end loop; -- every column
    end loop; -- every row in the rowset
    -- add the newly populated columns to the rowset
    for indx in 1 .. l_putcolcount
    loop
      dbms_tf.put_col( columnid   => indx
                     , collection => l_newcolset( indx )
                     );
    end loop;
  end;
end split_ptf;
/
