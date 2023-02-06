declare
  l_old_module_name varchar2(64);
  l_old_action_name varchar2(64);
begin
  sys.dbms_application_info.read_module
  ( module_name => l_old_module_name
  , action_name => l_old_action_name
  );
  sys.dbms_application_info.set_module
  ( module_name => 'ModernOracleDatabaseProgramming'
  , action_name => 'DemoDBMS_Application_Info'
  );
  -- do the real work of this program
  --
  -- at the end, reset the module and action
  sys.dbms_application_info.set_module
  ( module_name => l_old_module_name
  , action_name => l_old_action_name
  );
end;
/
