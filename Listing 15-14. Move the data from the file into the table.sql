insert into destination_tbl
  ( date_
  , payment_method
  , currency
  , amount
  , status
  , description
  )
select to_date (col001, 'yyyy-mm-dd hh24:mi:ss')
     , col002
     , col003
     , col004
     , col005
     , col007
from   temp_files tf
cross
join  table (apex_data_parser.parse
               ( p_content   => tf.blob_content
               , p_file_name => tf.filename
               , p_skip_rows => 1 -- skip the header line
               )
            )
where  tf.id = p_id
/
