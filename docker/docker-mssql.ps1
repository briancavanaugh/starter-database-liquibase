#######################################################
### Create a container for a local database server
### and persist data storage through local bind mount.
### Run liquibase command to update the starter database
### in the newly created container.
#######################################################

param ($pw = $(throw "Password (pw) parameter is required."))
param ($container = $(throw "Container Name (container) parameter is required."))
param ($data = $(throw "Data path (data) parameter is required."))

##### Microsoft SQL Server #####
docker pull mcr.microsoft.com/mssql/server:2022-latest

docker run --name $container-mssql `
--mount type=bind,source=$data\mssql,target=/var/opt/mssql/data `
-p 1433:1433 `
-e "ACCEPT_EULA=Y" `
-e "MSSQL_SA_PASSWORD=$pw" `
-d mcr.microsoft.com/mssql/server:2022-latest

liquibase `
--url="jdbc:sqlserver://localhost:1433;database=starter;encrypt=false" `
--username="sa" `
--password=$pw `
--changelog-file="../dbschema/00000_master_changelog.mssql.xml" `
update
