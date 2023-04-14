# Gitpod Workspace with Oracle Database 23c Free and F1data schema for Modern Oracle Database Programming: Level Up Your Skill Set to Oracle's Latest and Most Powerful Features in SQL, PL/SQL, and JSON by Alex Nuijten and Patrick Barel (Apress, 2023).

This repo is a fork from the original source code repository prepared by Alex and Patrick. It has been extended with a Gitpod Workspace definition that includes an Oracle Database 23c Free instance that is setup with the F1data schema used by Alex and Patrick for the examples in their book. Once this workspace is running, you have access to a running database with the f1data schema including all tables and other database objects as well as the data.

You can run the Gitpod workspace by clicking this button:
[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/lucasjellema/modern-oracle-database-programming/tree/gitpod-workspace-23c-free)


You can use the VS Code Oracle Developer Tools extension for VS Code - which is preconfigured with a database connection for the f1data account.

SQLcl command line tool (see [SQLcl introduction](https://www.oracle.com/database/sqldeveloper/technologies/sqlcl/) for details) has also been installed and can be accessed using:

```
alias sql="/workspace/gitpod-oracle-database-23c-free/sqlcl/bin/sql"
sql f1data/"Formula1Database!"@localhost:1521/FREEPDB1 
```  

# Apress Source Code

This repository accompanies [Modern Oracle Database Programming: Level Up Your Skill Set to Oracle's Latest and Most Powerful Features in SQL, PL/SQL, and JSON ](https://www.link.springer.com/book/10.1007/9781484291658) by Alex Nuijten and Patrick Barel (Apress, 2023).

[comment]: #cover
![Cover image](9781484291658.jpg)

Download the files as a zip using the green button, or clone the repository to your machine using Git.

## Releases

Release v1.0 corresponds to the code in the published book, without corrections or updates.

## Contributions

See the file Contributing.md for more information on how you can contribute to this repository.