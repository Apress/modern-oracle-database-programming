create or replace package only_for_dev is
  $if environment_pkg.development $then
    procedure still_in_development;
  $else
    $error 'This package is for the development environment only'
    $end
  $end
end only_for_dev;
