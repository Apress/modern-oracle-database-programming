l_url constant varchar2(50) :=
   $if environment_pkg.development
   $then 'url to endpoint A'
   $elsif environment_pkg.production
   $then 'url to endpoint B'
   $end;
