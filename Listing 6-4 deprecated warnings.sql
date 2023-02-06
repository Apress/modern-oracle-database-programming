create or replace package deprecatedwarnings is
  procedure deprecate_this_later;
  procedure deprecate_this_now;
  pragma deprecate( deprecate_this_now,
  'This will raise PLW-6019, when this program is called' );
  pragma deprecate( deprecate_this_later,
  'This will raise PLW-6021, because this pragma is misplaced' );
  procedure call_the_deprecated_procedure;
end deprecatedwarnings;
