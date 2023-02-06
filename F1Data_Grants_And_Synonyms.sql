/***
 *       __________       __                                                               
 *      / __<  / _ \___ _/ /____ _                                                         
 *     / _/ / / // / _ `/ __/ _ `/                                                         
 *    /_/  /_/____/\_,_/\__/\_,_/                                                          
 *      _____              __                     __                                       
 *     / ___/______ ____  / /____   ___ ____  ___/ / ___ __ _____  ___  ___  __ ____ _  ___
 *    / (_ / __/ _ `/ _ \/ __(_-<  / _ `/ _ \/ _  / (_-</ // / _ \/ _ \/ _ \/ // /  ' \(_-<
 *    \___/_/  \_,_/_//_/\__/___/  \_,_/_//_/\_,_/ /___/\_, /_//_/\___/_//_/\_, /_/_/_/___/
 *                                                     /___/               /___/           
 * Filename : F1Data_Grants_And_Synonyms.sql
 */
clear screen
set serveroutput on size unlimited format wrapped

create or replace public synonym constructorresults   for constructorresults;
create or replace public synonym constructorstandings for constructorstandings;
create or replace public synonym driverstandings      for driverstandings ;
create or replace public synonym laptimes             for laptimes ;
create or replace public synonym pitstops             for pitstops ;
create or replace public synonym qualifying           for qualifying ;
create or replace public synonym results              for results ;
create or replace public synonym sprintresults        for sprintresults ;
create or replace public synonym races                for races ;
create or replace public synonym status               for status ;
create or replace public synonym seasons              for seasons ;
create or replace public synonym circuits             for circuits ;
create or replace public synonym constructors         for constructors ;
create or replace public synonym drivers              for drivers ;

grant all on constructorresults to public;
grant all on constructorstandings to public;
grant all on driverstandings to public;
grant all on laptimes to public;
grant all on pitstops to public;
grant all on qualifying to public;
grant all on results to public;
grant all on sprintresults to public;
grant all on races to public;
grant all on status to public;
grant all on seasons to public;
grant all on circuits to public;
grant all on constructors to public;
grant all on drivers to public;


