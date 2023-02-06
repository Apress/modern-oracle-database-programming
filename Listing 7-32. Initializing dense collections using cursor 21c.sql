declare
  type circuit_tt is table of f1data.circuits%rowtype
    index by pls_integer;
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
                     order  by c.circuitref
                    ) sequence => rec);

  dbms_output.put_line( l_circuits(1).name
                      ||' ('
                      ||l_circuits(1).location
                      ||' ['
                      ||l_circuits(1).lat
                      ||','
                      ||l_circuits(1).lng
                      ||'])'
  );
end;
/
