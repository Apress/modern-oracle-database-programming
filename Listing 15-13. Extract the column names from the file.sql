select column_name
bulk collect
into   l_file_headers
from   temp_files tf
cross
join   table (apex_data_parser.get_columns
               (apex_data_parser.discover
                   (p_content   => tf.blob_content
                   ,p_file_name => tf.filename
                  )))
where  tf.id = p_id
/
