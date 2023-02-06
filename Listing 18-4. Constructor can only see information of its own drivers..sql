create or replace context constructor_ctx using context_pkg
/
create or replace package context_pkg as
  procedure set_constructor( constructorid_in in number );
  procedure unset_constructor;
end context_pkg;
/

create or replace package body context_pkg as
  procedure set_constructor(constructorid_in in number) is
  begin
    dbms_session.set_context( namespace => 'CONSTRUCTOR_CTX'
                            , attribute => 'CONSTRUCTORID'
                            , value     => constructorid_in
                            );
  End set_constructor;
  
  procedure unset_constructor is
  begin
    dbms_session.clear_context( namespace => 'CONSTRUCTOR_CTX' );
  end unset_constructor;
end context_pkg;
/
