#!/bin/bash

# Wait to be sure that SQL Server came up
sleep 30s

# Run the setup script to create the DB and the schema in the DB
for file in ./*.sql
do
    echo running $file
    /opt/mssql-tools/bin/sqlcmd -I -S localhost -U sa -P ONE2three4! -d master -i $file
    echo finished $file
done

echo Sql Server is initialized
