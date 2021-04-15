# Easy SQL server Integration Testing

Two tools:
- [mssql-scripter](https://github.com/microsoft/mssql-scripter)
- [mssql docker container](https://hub.docker.com/_/microsoft-mssql-server)

1. Build the docker container
    ``` bash
    ./build_sql.sh
    # You will be prompted for the server, database, user, and password
    ```
1. Run SQL server locally (see run.sh)
    ``` bash
    docker run --rm -p 1433:1433 sql-test
    ```
1. Stop and dispose of the local SQL server (see stop.sh)
    ``` bash
    docker stop $(docker ps -q --filter "ancestor=sql-test")
    ```
