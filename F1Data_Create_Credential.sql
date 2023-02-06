/***
 *       __________       __                                                
 *      / __<  / _ \___ _/ /____ _                                          
 *     / _/ / / // / _ `/ __/ _ `/                                          
 *    /_/  /_/____/\_,_/\__/\_,_/                                           
 *      _____             __        _____           __         __  _      __
 *     / ___/______ ___ _/ /____   / ___/______ ___/ /__ ___  / /_(_)__ _/ /
 *    / /__/ __/ -_) _ `/ __/ -_) / /__/ __/ -_) _  / -_) _ \/ __/ / _ `/ / 
 *    \___/_/  \__/\_,_/\__/\__/  \___/_/  \__/\_,_/\__/_//_/\__/_/\_,_/_/  
 *                                                                          
 * Filename : F1Data_Create_Credential.sql
 * Remarks  : Run this script as the admin user
 *            Replace <<Authorisation Token>> with your authorisation token 
 */
clear screen
set serveroutput on size unlimited format wrapped

begin
  DBMS_CLOUD.create_credential(
    credential_name => 'F1DATA_CREDENTIALS',
    username => 'F1DATA',
    password => '<<Authorisation Token>>'
  );
end;
/
