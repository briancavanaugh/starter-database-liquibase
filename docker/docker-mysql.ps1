#######################################################
### Create a container for a local database server
### and persist data storage through local bind mount.
### Run liquibase command to update the starter database
### in the newly created container.
#######################################################

param ($pw = $(throw "Password (pw) parameter is required."))
param ($container = $(throw "Container Name (container) parameter is required."))
param ($data = $(throw "Data path (data) parameter is required."))

##### My SQL #####
docker pull mysql

docker run --name $container-mysql `
--mount type=bind,source=$data\mysql,target=/var/lib/mysql `
-p 3306:3306 `
-e "MYSQL_ROOT_PASSWORD=$pw" `
-d mysql

liquibase `
--url="jdbc:mysql://localhost:3306/starter" `
--username="root" `
--password=$pw `
--changelog-file="../dbschema/00000_master_changelog.mysql.xml" `
update
