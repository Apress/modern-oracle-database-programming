/***
 *       __________       __                 
 *      / __<  / _ \___ _/ /____ _           
 *     / _/ / / // / _ `/ __/ _ `/           
 *    /_/  /_/____/\_,_/\__/\_,_/            
 *      _____                          __    
 *     / ___/__  __ _  __ _  ___ ___  / /____
 *    / /__/ _ \/  ' \/  ' \/ -_) _ \/ __(_-<
 *    \___/\___/_/_/_/_/_/_/\__/_//_/\__/___/
 *                                           
 * Filename : F1Data_Comments.sql
 */
clear screen
set serveroutput on size unlimited format wrapped

comment on column f1data.circuits.circuitid                          is 'Primary key';
comment on column f1data.circuits.circuitRef                         is 'Unique circuit identifier';
comment on column f1data.circuits.name                               is 'Circuit name';
comment on column f1data.circuits.location                           is 'Location name';
comment on column f1data.circuits.country                            is 'Country name';
comment on column f1data.circuits.lat                                is 'Latitude';
comment on column f1data.circuits.lng                                is 'Longitude';
comment on column f1data.circuits.alt                                is 'Altitude (metres)';
comment on column f1data.circuits.url                                is 'Circuit Wikipedia page';

comment on column f1data.constructorresults.constructorResultsId     is  'Primary key';
comment on column f1data.constructorresults.raceId                   is  'Foreign key link to races table';
comment on column f1data.constructorresults.constructorId            is  'Foreign key link to constructors table';
comment on column f1data.constructorresults.points                   is  'Constructor points for race';
comment on column f1data.constructorresults.status                   is  '"D" for disqualified (or null)';


comment on column f1data.constructorstandings.constructorStandingsId is 'Primary key';
comment on column f1data.constructorstandings.raceId                 is 'Foreign key link to races table';
comment on column f1data.constructorstandings.constructorId          is 'Foreign key link to constructors table';
comment on column f1data.constructorstandings.points                 is 'Constructor points for season';
comment on column f1data.constructorstandings.position               is 'Constructor standings position (integer)';
comment on column f1data.constructorstandings.positionText           is 'Constructor standings position (string)';
comment on column f1data.constructorstandings.wins                   is 'Season win count';


comment on column f1data.constructors.constructorId                  is 'Primary key';
comment on column f1data.constructors.constructorRef                 is 'Unique constructor identifier';
comment on column f1data.constructors.name                           is 'Constructor name';
comment on column f1data.constructors.nationality                    is 'Constructor nationality';
comment on column f1data.constructors.url                            is 'Constructor Wikipedia page';

comment on column f1data.driverstandings.driverStandingsId           is 'Primary key';
comment on column f1data.driverstandings.raceId                      is 'Foreign key link to races table';
comment on column f1data.driverstandings.driverId                    is 'Foreign key link to drivers table';
comment on column f1data.driverstandings.points                      is 'Driver points for season';
comment on column f1data.driverstandings.position                    is 'Driver standings position (integer)';
comment on column f1data.driverstandings.positionText                is 'Driver standings position (string)';
comment on column f1data.driverstandings.wins                        is 'Season win count';

comment on column f1data.drivers.driverId                            is 'Primary key';
comment on column f1data.drivers.driverRef                           is 'Unique driver identifier';
comment on column f1data.drivers.driver_number                       is 'Permanent driver number';
comment on column f1data.drivers.code                                is 'Driver code e.g. "ALO"';     
comment on column f1data.drivers.forename                            is 'Driver forename';
comment on column f1data.drivers.surname                             is 'Driver surname';
comment on column f1data.drivers.dob                                 is 'Driver date of birth';
comment on column f1data.drivers.nationality                         is 'Driver nationality';
comment on column f1data.drivers.url                                 is 'Driver Wikipedia page';

comment on column f1data.laptimes.raceId                             is 'Foreign key link to races table';
comment on column f1data.laptimes.driverId                           is 'Foreign key link to drivers table';
comment on column f1data.laptimes.lap                                is 'Lap number';
comment on column f1data.laptimes.position                           is 'Driver race position';
comment on column f1data.laptimes.time                               is 'Lap time e.g. "1:43.762"';
comment on column f1data.laptimes.milliseconds                       is 'Lap time in milliseconds';

comment on column f1data.pitstops.raceId                             is 'Foreign key link to races table';
comment on column f1data.pitstops.driverId                           is 'Foreign key link to drivers table';
comment on column f1data.pitstops.stop                               is 'Stop number';
comment on column f1data.pitstops.lap                                is 'Lap number';
comment on column f1data.pitstops.time                               is 'Time of stop e.g. "13:52:25"';
comment on column f1data.pitstops.duration                           is 'Duration of stop e.g. "21.783"';
comment on column f1data.pitstops.milliseconds                       is 'Duration of stop in milliseconds';

comment on column f1data.qualifying.qualifyId                        is 'Primary key';
comment on column f1data.qualifying.raceId                           is 'Foreign key link to races table';
comment on column f1data.qualifying.driverId                         is 'Foreign key link to drivers table';
comment on column f1data.qualifying.constructorId                    is 'Foreign key link to constructors table';
comment on column f1data.qualifying.driver_number                    is 'Driver number';
comment on column f1data.qualifying.position                         is 'Qualifying position';
comment on column f1data.qualifying.q1                               is 'Q1 lap time e.g. "1:21.374"';
comment on column f1data.qualifying.q2                               is 'Q2 lap time';
comment on column f1data.qualifying.q3                               is 'Q3 lap time';

comment on column f1data.races.raceId                                is 'Primary key';
comment on column f1data.races.year                                  is 'Foreign key link to seasons table';
comment on column f1data.races.round                                 is 'Round number';
comment on column f1data.races.circuitId                             is 'Foreign key link to circuits table';
comment on column f1data.races.name                                  is 'Race name'; 
comment on column f1data.races.race_date                             is 'Race date e.g. "1950-05-13"';
comment on column f1data.races.time                                  is 'Race start time e.g."13:00:00"';
comment on column f1data.races.url                                   is 'Race Wikipedia page';
comment on column f1data.races.fp1_date                              is 'FP1 date';
comment on column f1data.races.fp1_time                              is 'FP1 start time';
comment on column f1data.races.fp2_date                              is 'FP2 date';
comment on column f1data.races.fp2_time                              is 'FP2 start time';
comment on column f1data.races.fp3_date                              is 'FP3 date';
comment on column f1data.races.fp3_time                              is 'FP3 start time';
comment on column f1data.races.quali_date                            is 'Qualifying date';
comment on column f1data.races.quali_time                            is 'Qualifying start time';
comment on column f1data.races.sprint_date                           is 'Sprint date';
comment on column f1data.races.sprint_time                           is 'Sprint start time';

comment on column f1data.results.resultId                            is 'Primary key';
comment on column f1data.results.raceId                              is 'Foreign key link to races table';
comment on column f1data.results.driverId                            is 'Foreign key link to drivers table';
comment on column f1data.results.constructorId                       is 'Foreign key link to constructors table';
comment on column f1data.results.driver_number                       is 'Driver number';
comment on column f1data.results.grid                                is 'Starting grid position';
comment on column f1data.results.position                            is 'Official classification, if applicable';
comment on column f1data.results.positionText                        is 'Driver position string e.g. "1" or "R"';
comment on column f1data.results.positionOrder                       is 'Driver position for ordering purposes';
comment on column f1data.results.points                              is 'Driver points for race';
comment on column f1data.results.laps                                is 'Number of completed laps';
comment on column f1data.results.time                                is 'Finishing time or gap';
comment on column f1data.results.milliseconds                        is 'Finishing time in milliseconds';   
comment on column f1data.results.fastestLap                          is 'Lap number of fastest lap';
comment on column f1data.results.rank                                is 'Fastest lap rank, compared to other drivers';
comment on column f1data.results.fastestLapTime                      is 'Fastest lap time e.g. "1:27.453"';
comment on column f1data.results.fastestLapSpeed                     is 'Fastest lap speed (km/h) e.g. "213.874"';
comment on column f1data.results.statusId                            is 'Foreign key link to status table';

comment on column f1data.sprintresults.sprintResultId                is 'Primary key';
comment on column f1data.sprintresults.raceId                        is 'Foreign key link to races table';
comment on column f1data.sprintresults.driverId                      is 'Foreign key link to drivers table';
comment on column f1data.sprintresults.constructorId                 is 'Foreign key link to constructors table';
comment on column f1data.sprintresults.driver_number                 is 'Driver number';
comment on column f1data.sprintresults.grid                          is 'Starting grid position';
comment on column f1data.sprintresults.position                      is 'Official classification, if applicable';
comment on column f1data.sprintresults.positionText                  is 'Driver position string e.g. "1" or "R"';
comment on column f1data.sprintresults.positionOrder                 is 'Driver position for ordering purposes';
comment on column f1data.sprintresults.points                        is 'Driver points for race';
comment on column f1data.sprintresults.laps                          is 'Number of completed laps';
comment on column f1data.sprintresults.time                          is 'Finishing time or gap';
comment on column f1data.sprintresults.milliseconds                  is 'Finishing time in milliseconds';   
comment on column f1data.sprintresults.fastestLap                    is 'Lap number of fastest lap';
comment on column f1data.sprintresults.fastestLapTime                is 'Fastest lap time e.g. "1:27.453"';
comment on column f1data.sprintresults.statusId                      is 'Foreign key link to status table';

comment on column f1data.seasons.year                                is 'Primary key e.g. 1950';
comment on column f1data.seasons.url                                 is 'Season Wikipedia page';

comment on column f1data.status.statusId                             is 'Primary key';
comment on column f1data.status.status                               is 'Finishing status e.g. "Retired"';
