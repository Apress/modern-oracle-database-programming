/***
 *       __________       __                                      
 *      / __<  / _ \___ _/ /____ _                                
 *     / _/ / / // / _ `/ __/ _ `/                                
 *    /_/  /_/____/\_,_/\__/\_,_/                                 
 *       ____                       __         __  ___  __________
 *      / __/__ ___  ___ ________ _/ /____ ___/ / / _ \/_  __/ __/
 *     _\ \/ -_) _ \/ _ `/ __/ _ `/ __/ -_) _  / / ___/ / / / _/  
 *    /___/\__/ .__/\_,_/_/  \_,_/\__/\__/\_,_/ /_/    /_/ /_/    
 *           /_/                                                  
 * filename : F1DATA_Separated_PTF.sql
 */
clear screen
set serveroutput on size unlimited

create or replace package separated_ptf is
  function describe(tab        in out dbms_tf.table_t
                   ,cols       in dbms_tf.columns_t default null
                   ,coltosplit in varchar2 default null
                   ,separator  in varchar2 default ';') return dbms_tf.describe_t;

  procedure fetch_rows(coltosplit in varchar2 default null
                      ,separator  in varchar2 default ';');
end separated_ptf;
/

create or replace package body separated_ptf as
  function describe(tab        in out dbms_tf.table_t
                   ,cols       in dbms_tf.columns_t default null
                   ,coltosplit in varchar2 default null
                   ,separator  in varchar2 default ';') return dbms_tf.describe_t as
    -- metadata for column to add
    l_new_col dbms_tf.column_metadata_t;
    -- table of columns to add
    l_new_cols dbms_tf.columns_new_t;
    -- make sure the column to split is in the correct format (uppercase with doublequotes)
    l_coltosplit dbms_quoted_id := dbms_assert.enquote_name(str => coltosplit, capitalize => true);
  begin
    -- if the coltosplit parameter is null then
    if coltosplit is null then
      -- Mark the first column ReadOnly and don't display it anymore
      tab.column(1).for_read := true;
      tab.column(1).pass_through := false;
    else
      -- if the coltosplit parameter is not null then
      -- check every column from the source table
      for indx in tab.column.first .. tab.column.last loop
        -- if this is the column we want to split then
        if tab.column(indx).description.name = l_coltosplit then
          -- Mark this column ReadOnly and don't display it anymore
          tab.column(indx).for_read := true;
          tab.column(indx).pass_through := false;
        end if;
      end loop;
    end if;
    -- Add the new columns, as specified in the cols parameter
    for indx in 1 .. cols.count loop
      -- define metadata for column named cols(indx)
      -- that will default to a datatype of varchar2 with
      -- a length of 4000
      l_new_col := dbms_tf.column_metadata_t(name => cols(indx));
      -- add the new column to the list of columns new columns
      l_new_cols(l_new_cols.count + 1) := l_new_col;
    end loop;
    -- Instead of returning NULL we will RETURN a specific
    -- DESCRIBE_T that adds new columns
    return dbms_tf.describe_t(new_columns => l_new_cols);
  end;

  procedure fetch_rows(coltosplit in varchar2 default null
                      ,separator  in varchar2 default ';') is
    -- define a table type of varchar2 tables
    type colset is table of dbms_tf.tab_varchar2_t index by pls_integer;
    -- variable to hold the rowset as retrieved
    l_rowset dbms_tf.row_set_t;
    -- variable to hold the number of rows as retrieved
    l_rowcount pls_integer;
    -- variable to hold the number of put columns
    l_putcolcount pls_integer := dbms_tf.get_env().put_columns.count;
    -- variable to hold the new values
    l_newcolset colset;
    -- get the name of the column to be split from the get columns
    l_coltosplit dbms_quoted_id := trim('"' from dbms_tf.get_env().get_columns(1).name);
  begin
    -- fetch rows into a local rowset
    -- at this point the rows will have columns
    -- from the the table/view/query passed in
    dbms_tf.get_row_set(l_rowset, l_rowcount);
    -- for every row in the rowset...
    for rowindx in 1 .. l_rowcount loop
      -- for every column
      for colindx in 1 .. l_putcolcount loop
        -- split the row into separate values
        --  FUNCTION Row_To_Char(rowset Row_Set_t,
        --                       rid    PLS_INTEGER,
        --                       format PLS_INTEGER default FORMAT_JSON)
        --           return VARCHAR2;
        -- splitting the regexp way: http://nuijten.blogspot.com/2009/07/splitting-comma-delimited-string-regexp.html
        l_newcolset(colindx)(rowindx) := trim(separator from regexp_substr(json_value(dbms_tf.row_to_char(l_rowset, rowindx), '$.' || l_coltosplit)
                                                           ,'[^' || separator || ']*' || separator || '{0,1}'
                                                           ,1
                                                           ,colindx));
      end loop; -- every column
    end loop; -- every row in the rowset
    -- add the newly populated columns to the rowset
    for indx in 1 .. l_putcolcount loop
      dbms_tf.put_col(columnid => indx, collection => l_newcolset(indx));
    end loop;
  end;
end separated_ptf;
/
-- create a 'wrapper' function for the polymorphic table function
create or replace function separated_fnc(p_tbl      in table
                                        ,cols       columns default null
                                        ,coltosplit in varchar2 default null
                                        ,separator  in varchar2 default ';') return table
  pipelined row polymorphic using separated_ptf;
/
