#!/bin/bash

set -x
docker stop $(docker ps -q --filter "ancestor=sql-test")
