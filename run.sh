#!/bin/bash

set -x
docker run --rm -p 1433:1433 sql-test
