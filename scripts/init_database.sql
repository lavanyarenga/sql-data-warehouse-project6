/*
Script Purpose:
    This script creates a new database named DataWarehouse. If the database already exists, it will be dropped and recreated. The script also creates three schemas within the database: bronze, silver, and gold.

WARNING:
  Executing this script will permanently delete the existing DataWarehouse database, including all its data, before creating a new one. Ensure that you have taken the necessary backups
  and understand the consequences before running the script.
*/

--drop and recreate the daawarehouse database
if exists (select 1 from sys.databases where name = 'DataWarehouse')
begin
	alter database DataWarehouse set single_user with rollback immediate;
	drop database DataWarehouse;
end;
go

--create database DataWarehouse
create database DataWarehouse;
go

use DataWarehouse;

--create schema
create schema bronze;
go

create schema silver;
go

create schema gold;
go
