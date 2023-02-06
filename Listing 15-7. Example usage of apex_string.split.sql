select column_value
  from apex_string.split
         ( p_str => 'this:should:be:shown:as:a:table'
         , p_sep => ':'
         )
/
