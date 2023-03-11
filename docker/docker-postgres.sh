#######################################################
### Create a container for a local database server
### and persist data storage through local bind mount.
### Run liquibase command to update the starter database
### in the newly created container.
#######################################################

param ($password = $(throw "Password (pw) parameter is required."))
param ($container = $(throw "Container Name (container) parameter is required."))
param ($datapath = $(throw "Data path (data) parameter is required."))

##### PostgreSQL #####
docker pull postgres

docker run --name $container-postgres \
--mount type=bind,source=$datapath/postgres,target=/var/lib/postgresql/data \
-p 5432:5432 \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASSWORD=$password \
-d postgres

liquibase \
--url="jdbc:postgresql://localhost:5432/starter" \
--username="postgres" \
--password=$password \
--changelog-file="../dbschema/00000_master_changelog.postgresql.xml" \
update
