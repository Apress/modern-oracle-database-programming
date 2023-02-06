create or replace package utl_call_stack_demo
is
  procedure public_procedure;
end utl_call_stack_demo;
/

create or replace package body utl_call_stack_demo is
  procedure private_procedure is
    l_subprogram utl_call_stack.unit_qualified_name;
  
    procedure local_procedure_in_private_procedure is
      l_subprogram utl_call_stack.unit_qualified_name;
    
      procedure local_procedure_in_local_procedure is
        l_subprogram utl_call_stack.unit_qualified_name;
      begin
        -----8<-replace-start------
        null;
        ------8<-replace-end------
      end local_procedure_in_local_procedure;
    
    begin
      -----8<-replace-start------
      null;
      ------8<-replace-end------
      dbms_output.put_line( 'Call the local in local procedure');
      local_procedure_in_local_procedure;
    end local_procedure_in_private_procedure;
  begin
    -----8<-replace-start------
    null;
    ------8<-replace-end------
    dbms_output.put_line( 'Call the local in private procedure');
    local_procedure_in_private_procedure;
  end private_procedure;

  procedure public_procedure is
    l_subprogram utl_call_stack.unit_qualified_name;
  
    procedure local_procedure_in_public_procedure is
      l_subprogram utl_call_stack.unit_qualified_name;
    
      procedure local_procedure_in_local_procedure is
        l_subprogram utl_call_stack.unit_qualified_name;
      begin
        -----8<-replace-start------
        null;
        ------8<-replace-end------
      end local_procedure_in_local_procedure;
    
    begin
      -----8<-replace-start------
      null;
      ------8<-replace-end------
      dbms_output.put_line( 'Call the local in local procedure');
      local_procedure_in_local_procedure;
    end local_procedure_in_public_procedure;
  begin
    -----8<-replace-start------
    null;
    ------8<-replace-end------
    dbms_output.put_line( 'Call the local procedure' );
    local_procedure_in_public_procedure;
    dbms_output.put_line( 'Call the private procedure' );
    private_procedure;
  end public_procedure;
end utl_call_stack_demo;
/
