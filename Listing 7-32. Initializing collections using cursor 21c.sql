declare
  type circuit_tt is table of f1data.circuits%rowtype
    index by varchar2(256);
  l_circuits circuit_tt;
begin
  l_circuits := circuit_tt
                  (for rec in 
                    (select c.circuitid
                          , c.circuitref
                          , c.name
                          , c.location
                          , c.country
                          , c.lat
                          , c.lng
                          , c.alt
                          , c.url
                     from   f1data.circuits c
                    ) index rec.circuitref => rec);

  dbms_output.put_line( l_circuits('zandvoort').name
                      ||' ('
                      ||l_circuits('zandvoort').location
                      ||' ['
                      ||l_circuits('zandvoort').lat
                      ||','
                      ||l_circuits('zandvoort').lng
                      ||'])'
  );
end;
/
