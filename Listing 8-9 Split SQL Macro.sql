create or replace function split
(
  table_in   in dbms_tf.table_t
, columns_in in dbms_tf.columns_t default null
)
  return varchar2 sql_macro( table ) is
  l_sql         varchar2( 32767 );
  l_split       varchar2( 32767 );

begin
  for cols in columns_in.first .. columns_in.last
  loop
    l_split := l_split || 
               q'[, trim( ';' from regexp_substr( ]'||
               table_in.column( 1 ).description.name ||
               q'[, '[^;]*;{0,1}', 1, ]' || 
               cols || q'[ ) ) ]' ||
               columns_in( cols );
  end loop;
  l_split := trim( leading ',' from l_split );
  l_sql   := q'[select t.*, ]' || 
             l_split ||
             q'[ from table_in t]';

  dbms_tf.trace( l_sql );
  return l_sql;
end;
/
