#######################################################
### Create a container for a local database server
### and persist data storage through local bind mount.
### Run liquibase command to update the starter database
### in the newly created container.
#######################################################

param ($pw = $(throw "Password (pw) parameter is required."))
param ($container = $(throw "Container Name (container) parameter is required."))
param ($data = $(throw "Data path (data) parameter is required."))
#TODO: Add scripting for Mongo Databases
##### MongoDB #####
docker pull mongo

docker run --name $container-mongo `
--mount type=bind,source=$data\mongo\db,target=/data/db `
--mount type=bind,source=$data\mongo\configdb,target=/data/configdb `
-p 27017:27017 `
-e "MONGO_INITDB_ROOT_USERNAME=mongoadmin" `
-e "MONGO_INITDB_ROOT_PASSWORD=$pw" `
-d mongo
