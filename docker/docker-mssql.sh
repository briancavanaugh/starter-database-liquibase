#######################################################
### Create a container for a local database server
### and persist data storage through local bind mount.
### Run liquibase command to update the starter database
### in the newly created container.
#######################################################

while getopts p:c:d: flag
do
    case "${flag}" in
        p) password=${OPTARG};;
        c) container=${OPTARG};;
        d) datapath=${OPTARG};;
    esac
done

##### Microsoft SQL Server #####
docker pull mcr.microsoft.com/mssql/server:2022-latest

docker run --name $container-mssql \
--mount type=bind,source=$datapath/mssql,target=/var/opt/mssql/data \
-p 1433:1433 \
-e "ACCEPT_EULA=Y" \
-e "MSSQL_SA_PASSWORD=$password" \
-d mcr.microsoft.com/mssql/server:2022-latest

liquibase \
--url="jdbc:sqlserver://localhost:1433;database=starter;encrypt=false" \
--username="sa" \
--password=$password \
--changelog-file="../dbschema/00000_master_changelog.mssql.xml" \
update
