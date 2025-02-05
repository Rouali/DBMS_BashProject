#!/bin/bash

SQL_COMMAND=$1

case $SQL_COMMAND in
    CREATE\ DATABASE*)
         .\db_operations.sh create_database ;;
    USE*)
         .\db_operations.sh connect_database ;;
    *)
         echo "Invalid SQL command."
         ;;
esac
