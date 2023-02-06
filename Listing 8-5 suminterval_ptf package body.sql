create or replace package body suminterval_ptf as
  -- Record type to hold the different INTERVAL sums
  type sum_rec is record(
    sumym interval year to month
  , sumds interval day to second
  );
  -- Collection type for every column
  type sum_recs is table of sum_rec index by pls_integer;
  --
  function describe
  (
    tab  in out dbms_tf.table_t
  , cols in     dbms_tf.columns_t default null
  ) return dbms_tf.describe_t as
  
    sum_cols dbms_tf.columns_new_t;
  begin
    -- check every column from the source table
    for indx in tab.column.first .. tab.column.last
    loop
      -- mark every columns pass_through as false so it won't
      -- show up in the result anymore
      tab.column( indx ).pass_through := false;
      -- first mark the column not to be read, unless...
      tab.column( indx ).for_read     := false;
      for colindx in cols.first .. cols.last
      loop
        if tab.column( indx ).description.name = cols( colindx )
        then
          -- ...the result of the sum is requested
          -- the read this column
          tab.column( indx ).for_read := true;
          -- and add a new column of the same type but with the
          -- name SUM_colname_
          sum_cols( colindx ) :=
            dbms_tf.column_metadata_t
            ( name => 'SUM_' ||
                      replace( tab.column(indx).description.name
                             , '"' ) ||
                      '_'
            , type => tab.column( indx ).description.type
            );
        end if;
      end loop;
    end loop;
    -- Instead of returning NULL we will RETURN a specific
    -- DESCRIBE_T that adds new columns
    return dbms_tf.describe_t( new_columns => sum_cols );
  end;

  procedure fetch_rows is
    -- variable to hold the rowset as retrieved
    l_rowset dbms_tf.row_set_t;
    -- variable to hold the sum of each column

    l_sum_recs sum_recs;
    -- variable to hold the enviroment value

    env dbms_tf.env_t := dbms_tf.get_env();
    -- variable to hold all the YEAR TO MONTH INTERVALs

    l_intervalym dbms_tf.tab_interval_ym_t;
    -- variable to hold all the DAY TO SECOND INTERVALs

    l_intervalds dbms_tf.tab_interval_ds_t;
  begin
    for colindx in 1 .. env.get_columns.count
    loop
      case env.get_columns( colindx ).type
      -- when the column type is INTERVAL YEAR TO MONTH
        when dbms_tf.type_interval_ym then
          -- Get the contents of the column
          dbms_tf.get_col( columnid   => colindx
                         , collection => l_intervalym
                         );
          -- Initialize the record value, otherwise you'll add
          -- something to NULL which results in NULL
          l_sum_recs( colindx ).sumym := interval '0-0' year
                                         to month;
          -- Loop through all the values and add them together
          for indx in 1 .. l_intervalym.count
          loop
            l_sum_recs( colindx ).sumym := 
              l_sum_recs( colindx ).sumym + l_intervalym( indx );
          end loop;
          -- when the column type is INTERVAL DAY TO SECOND
        when dbms_tf.type_interval_ds then
          -- Get the contents of the column
          dbms_tf.get_col( columnid   => colindx
                         , collection => l_intervalds
                         );
          -- Initialize the record value, otherwise you'll add
          -- something to NULL which results in NULL
          l_sum_recs( colindx ).sumds := interval '0 0:0:0' day
                                         to second;
          -- Loop through all the values and add them together
          for indx in 1 .. l_intervalds.count
          loop
            l_sum_recs( colindx ).sumds :=
              l_sum_recs( colindx ).sumds + l_intervalds( indx );
          end loop;
        else
          -- Catch all others
          dbms_output.put_line( q'[Columns of this type (]' ||
                                env.get_columns(colindx).type ||
                                q'[) are not supported (yet).]'
                              );
      end case;
    end loop;
    -- completely ignore the current rowset from now on, just
    -- start a new set, with just the totals
    -- loop through the put_columns to fill the resulting row
    for colindx in 1 .. env.put_columns.count
    loop
      case env.put_columns( colindx ).type
      -- when the column type is INTERVAL YEAR TO MONTH
        when dbms_tf.type_interval_ym then
          -- add this value to the resulting row
          l_rowset( colindx ).tab_interval_ym( 1 ) :=
            l_sum_recs( colindx ).sumym;
          -- when the column type is INTERVAL DAY TO SECOND
        when dbms_tf.type_interval_ds then
          -- add this value to the resulting row
          l_rowset( colindx ).tab_interval_ds( 1 ) :=
            l_sum_recs( colindx ).sumds;
      end case;
    end loop;
    dbms_tf.put_row_set( l_rowset );
  end;
end suminterval_ptf;
/
