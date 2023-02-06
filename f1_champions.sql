create table f1_champions
(driver varchar2(50)
,season json
);
insert into f1_champions
select 'Michael Schumacher' as driver, '{"winner":[1994, 1995, 2000, 2001, 2002, 2003, 2004]}' as champion_year from dual union all
select 'Lewis Hamilton' as driver, '{"winner":[2008, 2014, 2015, 2017, 2018, 2019, 2020]}' as champion_year from dual union all
select 'Juan Manuel Fangio' as driver, '{"winner":[1951, 1954, 1955, 1956, 1957]}' as champion_year from dual union all
select 'Alain Prost' as driver, '{"winner":[1985, 1986, 1989, 1993]}' as champion_year from dual union all
select 'Sebastian Vettel' as driver, '{"winner":[2010, 2011, 2012, 2013]}' as champion_year from dual union all
select 'Jack Brabham' as driver, '{"winner":[1959, 1960, 1966]}' as champion_year from dual union all
select 'Jackie Stewart' as driver, '{"winner":[1969, 1971, 1973]}' as champion_year from dual union all
select 'Niki Lauda' as driver, '{"winner":[1975, 1977, 1984]}' as champion_year from dual union all
select 'Nelson Piquet' as driver, '{"winner":[1981, 1983, 1987]}' as champion_year from dual union all
select 'Ayrton Senna' as driver, '{"winner":[1988, 1990, 1991]}' as champion_year from dual union all
select 'Alberto Ascari' as driver, '{"winner":[1952, 1953]}' as champion_year from dual union all
select 'Graham Hill' as driver, '{"winner":[1962, 1968]}' as champion_year from dual union all
select 'Jim Clark' as driver, '{"winner":[1963, 1965]}' as champion_year from dual union all
select 'Emerson Fittipaldi' as driver, '{"winner":[1972, 1974]}' as champion_year from dual union all
select 'Mika Häkkinen' as driver, '{"winner":[1998, 1999]}' as champion_year from dual union all
select 'Fernando Alonso' as driver, '{"winner":[2005, 2006]}' as champion_year from dual union all
select 'Giuseppe Farina' as driver, '{"winner":[1950]}' as champion_year from dual union all
select 'Mike Hawthorn' as driver, '{"winner":[1958]}' as champion_year from dual union all
select 'Phil Hill' as driver, '{"winner":[1961]}' as champion_year from dual union all
select 'John Surtees' as driver, '{"winner":[1964]}' as champion_year from dual union all
select 'Denny Hulme' as driver, '{"winner":[1967]}' as champion_year from dual union all
select 'Jochen Rindt' as driver, '{"winner":[1970]}' as champion_year from dual union all
select 'James Hunt' as driver, '{"winner":[1976]}' as champion_year from dual union all
select 'Mario Andretti' as driver, '{"winner":[1978]}' as champion_year from dual union all
select 'Jody Scheckter' as driver, '{"winner":[1979]}' as champion_year from dual union all
select 'Alan Jones' as driver, '{"winner":[1980]}' as champion_year from dual union all
select 'Keke Rosberg' as driver, '{"winner":[1982]}' as champion_year from dual union all
select 'Nigel Mansell' as driver, '{"winner":[1992]}' as champion_year from dual union all
select 'Damon Hill' as driver, '{"winner":[1996]}' as champion_year from dual union all
select 'Jacques Villeneuve' as driver, '{"winner":[1997]}' as champion_year from dual union all
select 'Kimi Räikkönen' as driver, '{"winner":[2007]}' as champion_year from dual union all
select 'Jenson Button' as driver, '{"winner":[2009]}' as champion_year from dual union all
select 'Nico Rosberg' as driver, '{"winner":[2016]}' as champion_year from dual union all
select 'Max Verstappen' as driver, '{"winner":[2021]}' as champion_year from dual
/
commit
/
explain plan for
select driver
  from f1_champions f
 where json_exists (f.season, '$.winner?(@.number() >= 2010)')
/
select *
  from dbms_xplan.display (format => 'BASIC')
/

create multivalue index season_idx on f1_champions f
  (f.season.winner.number())
/
explain plan for
select driver
  from f1_champions f
 where json_exists (f.season, '$.winner?(@.number() >= 2010)')
/
select *
  from dbms_xplan.display (format => 'BASIC')
/
