create or replace package modp_pkg as
  procedure set_context
  ( namespace_in in varchar2
  , attribute_in in varchar2
  , value_in     in varchar2
  , username_in  in varchar2 default null
  , client_id_in in varchar2 default null
  );
  procedure clear_context
  ( namespace_in in varchar2
  , client_id_in in varchar2 default null
  , attribute_in in varchar2 default null
  );
  procedure clear_all_context
  ( namespace_in in varchar2 );
end modp_pkg;
/

create or replace package body modp_pkg as
  procedure set_context
  ( namespace_in in varchar2
  , attribute_in in varchar2
  , value_in     in varchar2
  , username_in  in varchar2 default null
  , client_id_in in varchar2 default null
  ) is
  begin
    dbms_session.set_context(namespace => namespace_in
                            ,attribute => attribute_in
                            ,value     => value_in
                            ,username  => username_in
                            ,client_id => client_id_in);
  end set_context;

  procedure clear_context
  ( namespace_in in varchar2
  , client_id_in in varchar2 default null
  , attribute_in in varchar2 default null
  ) is
  begin
    dbms_session.clear_context(namespace => namespace_in
                              ,client_id => client_id_in
                              ,attribute => attribute_in);
  end clear_context;

  procedure clear_all_context
  ( namespace_in in varchar2 ) is
  begin
    dbms_session.clear_all_context(namespace => namespace_in);
  end clear_all_context;
end modp_pkg;
/
