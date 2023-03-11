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

##### My SQL #####
docker pull mysql

docker run \
--name $container-mysql \
--mount type=bind,source=$datapath/mysql,target=/var/lib/mysql \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=$password \
-d mysql

liquibase \
--url="jdbc:mysql://localhost:3306/$container?createDatabaseIfNotExist=true" \
--username=root \
--password=$password \
--changelog-file="../dbschema/00000_master_changelog.mysql.xml" \
update
