/***
 *       __________       __                         
 *      / __<  / _ \___ _/ /____ _                   
 *     / _/ / / // / _ `/ __/ _ `/                   
 *    /_/  /_/____/\_,_/\__/\_,_/                    
 *      _____             __        __  __           
 *     / ___/______ ___ _/ /____   / / / /__ ___ ____
 *    / /__/ __/ -_) _ `/ __/ -_) / /_/ (_-</ -_) __/
 *    \___/_/  \__/\_,_/\__/\__/  \____/___/\__/_/   
 *                                                   
 * Filename : F1Data_Create_User.sql
 * Remarks  : Run this script as the admin user
 */
drop user f1data cascade
/

create user f1data identified by "Formula1Database!"
/
alter user f1data enable editions
/
grant connect, resource to f1data
/
grant create any view to f1data
/
grant create any table to f1data
/
grant create any view to f1data
/
grant drop any view to f1data
/
grant drop any table to f1data
/
grant drop any view to f1data
/
grant execute on dbms_crypto to f1data
/
grant unlimited tablespace to f1data
/
grant alter any procedure to f1data
/
grant create any procedure to f1data
/
grant drop any procedure to f1data
/
grant execute any procedure to f1data
/
grant select any table to f1data
/
grant create any synonym to f1data
/
grant create public synonym to f1data
/

grant CREATE ANALYTIC VIEW to f1data
/
grant CREATE ATTRIBUTE DIMENSION to f1data
/
grant ALTER SESSION to f1data
/
grant CREATE HIERARCHY to f1data
/
grant CREATE JOB to f1data
/
grant CREATE MATERIALIZED VIEW to f1data
/
grant CREATE MINING MODEL to f1data
/
grant CREATE PROCEDURE to f1data
/
grant CREATE SEQUENCE to f1data
/
grant CREATE SESSION to f1data
/
grant CREATE SYNONYM to f1data
/
grant CREATE TABLE to f1data
/
grant CREATE TRIGGER to f1data
/
grant CREATE TYPE to f1data
/
grant CREATE VIEW to f1data
/
