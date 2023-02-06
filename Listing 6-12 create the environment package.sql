declare
  l_pack_spec varchar2( 32767 );
  l_env       varchar2( 128 );
  function tochar(
    p_val in boolean)
    return varchar2
  as
  begin
    return case p_val
             when true then 'TRUE'
             when false then 'FALSE'
             else null
           end;
  end tochar;
begin
  l_env       := sys_context( 'userenv', 'db_name' );
  l_pack_spec := 'create or replace package environment_pkg'
                 || chr( 10 );
  l_pack_spec := l_pack_spec || 'is' || chr( 10 );
  l_pack_spec := l_pack_spec || '   --==' || chr( 10 );
  l_pack_spec := l_pack_spec 
                 || '   -- Environment Information'  
                 || chr( 10 );
  l_pack_spec := l_pack_spec
                 || '   development constant boolean := ' 
                 || lower( tochar( l_env like '%DEV%' ) )
                 || ';' || chr( 10 );
  l_pack_spec := l_pack_spec
                 || '   test        constant boolean := '
                 || lower( tochar( l_env like '%TST%' ) )
                 || ';' || chr( 10 );
  l_pack_spec := l_pack_spec 
                 || '   acceptance  constant boolean := '
                 || lower( tochar( l_env like '%ACC%' ) )
                 || ';' || chr( 10 );
  l_pack_spec := l_pack_spec
                 || '   production  constant boolean := '
                 || lower( tochar( l_env like '%PRD%' ) )
                 || ';' || chr( 10 );
  l_pack_spec := l_pack_spec || '   --==' || chr( 10 );
  l_pack_spec := l_pack_spec || 'end environment_pkg;'
                 || chr( 10 );
  execute immediate l_pack_spec;
end;
/
