create or replace view v_f1drivers as
select permanentNumber
     , code
     , givenName
     , familyName
     , dateOfBirth
     , nationality
  from split( table_in   => f1drivers
            , columns_in => columns( permanentNumber
                                   , code
                                   , givenName
                                   , familyName
                                   , dateOfBirth
                                   , nationality
                                   )
            )
/
