#!/bin/bash

# Prompt for user name and password
read -p "Server: 
>" SERVER
read -p "Database: 
>" DBNAME
read -p "User Name: 
>" USER
read -s -p "Password: 
>" PASSWORD

# Print a blank line
echo ""

# Build the connection string
CONNECT_STRING="Data Source=$SERVER;Initial Catalog=$DBNAME;User ID=$USER;Password=$PASSWORD;ApplicationIntent=ReadOnly;"

# Create a docker image with the name sql-test
docker build -t sql-test --build-arg CONNECT_STRING="$CONNECT_STRING" .
