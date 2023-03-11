# Starter Database
This repository is to be used as a template for new projects that will
contain database migrations (tables and seed data) as Liquibase changesets to run 
against a database.

## Dependencies
* Docker Desktop will be necessary to make use of the included powershell or linux
shell scripts.
* An Azure account will be necessary to make use of the included Github Actions 
workflows.
* [Liquibase](https://docs.liquibase.com/concepts/installation/home.html) 
should be installed locally in order to run generateChangeLog, diffChangeLog, 
diff, and other commands.

## Installing
* Other than the noted dependencies, nothing is required for installation.  However
to suit your needs, make the modifications mentioned below as desired.
* In order to best utilize this template repository, the 
dbschema/00000_master_changelog.xml file should be left in place, but the include 
elements should be modified to point to any newly created changelogs.  All other 
files in the dbschema folder can be removed/modified as needed.
* The liquibase.properties.example file contains samples of what will need to 
be set in a new liquibase.properties file.  This new file should NOT be checked 
into source control.  For an explanation of these properties, see additional 
documentation on Liquibase's website.

## Executing the Scripts and Workflows
### Docker scripts
* The Docker folder contains Powershell and Linux shell scripts that will
pull images from Docker hub, create containers, and initialize databases. A sample
Liquibase update command is also provided.

### **azure_infrastructure.yml** 
* Contains commands that will create Azure Resource Groups, 
Azure SQL Servers, and Azure SQL Databases.  These are dependent on 
Azure Service Principals (see notes below).  This workflow is run on 
demand and can run for the stage or prod environments.

### **ci.yml** 
* Runs the Liquibase _**updateSQL**_ command to allow for inspection of the SQL 
commands that will run on the target database. This workflow is run when a pull 
request is created for the main branch and on demand and can run for the stage 
or prod environments.

### **cd.yml** 
* Runs the Liquibase _**update**_ command to execute SQL commands on the target 
database. This workflow is run when a pull request is merged into the main branch and
on demand and can run for the stage or prod environments.

## Additional Notes
### Azure Service Principals
For additional details on how Service Principals work,
please see the appropriate documentation from Microsoft.

Below are sample commands to setup Service Principals.
The resulting JSON when the command is run should be copied into
the AZURE_CREDENTIALS_STAGE, and _PROD Github Secrets.

```
az ad sp create-for-rbac --name "starter-stage-sp" --sdk-auth
az ad sp create-for-rbac --name "starter-prod-sp" --sdk-auth
```

### Github Secrets
The above Github Actions are dependent on Github Secrets. 
These secrets should be setup before attempting to run these actions.
* AZURE_LOCATION
    * Location is used by the Azure Infrastructure
      workflow while creating cloud infrastructure. One
      location is used for all environments.
* AZURE_CREDENTIALS_STAGE (_PROD)
    * Used by the Azure Infrastructure workflow which will
      create the resource group, SQL Server, and SQL Server
      Database in the environment chosen.
    * Also used by the CI and CD workflows during integration
      and deployment.
* AZURE_RESOURCE_GROUP_STAGE (_PROD)
    * Used by the Azure Infrastructure workflow and sets the
      name of the resource group.
* AZURE_SQL_SERVER_STAGE (_PROD)
    * Used by the Azure Infrastructure workflow when creating
      the SQL Server.
* AZURE_SQL_DATABASE_STAGE (_PROD)
    * Used by the Azure Infrastructure workflow when creating
      the SQL Server Database.
* USERNAME_STAGE (_PROD)
    * Used by the Azure Infrastructure workflow when creating
      the SQL Server Admin User.
    * Also used by the CI and CD workflows during integration
      and deployment.
* PASSWORD_STAGE (_PROD)
    * Used by the Azure Infrastructure workflow when creating
      the SQL Server Admin User.
    * Also used by the CI and CD workflows during integration
      and deployment.
* DATABASE_URL_STAGE (_PROD)
    * Used by the CI and CD workflows during integration
      and deployment.

### Liquibase Commands
There are several different methods on how changesets can be created.  Your knowledge 
of database DML commands and Liquibase's common commands 
will allow you to make the best decision on how to create these.

Below are the most common Liquibase commands.  Please see their
[documentation](https://docs.liquibase.com/commands/community/home.html)
for proper usage.

* generateChangeLog
* diff
* diffChangeLog
* updateSQL
* update
* rollbackCountSQL
* rollbackCount

## Help
For a full explanation of how to use Liquibase, please see the 
[documentation and tutorials](https://docs.liquibase.com/home.html).

## Contributing
Interested in contributing to this project? 
[Please see the guidelines on how to do so](https://github.com/briancavanaugh/.github/blob/main/CONTRIBUTING.md).

[Authors](.github/AUTHORS.md) who wrote significant additions to this project.

[Contributors](.github/CONTRIBUTORS.md) who added value to this project.

## Version History

Please see the [changelog](.github/CHANGELOG.md) for a history of this project.

## License

The license for this project can be found [here](LICENSE).
