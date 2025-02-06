#!/bin/bash

SQL_COMMAND=$1
DB_NAME=$2
TABLE_NAME=$3

case $SQL_COMMAND in
    CREATE\ DATABASE*)
         ./db_operations.sh create_database ;;
    USE*)
         ./db_operations.sh connect_database ;;

CREATE\ TABLE)
if [[ -z "$DB_NAME" ]]; then
echo "Error: No databases selected. Use 'USE <database>' firsr"
exit1
fi
./table_operations.sh "$DB_NAME" create_table ;;

INSERT\ INTO)
if [[ -z "$DB_NAME" || -z "$TABLE_NAME" ]]; then
echo "Error: Missing databases or table name."
exit 1
fi
./table_operations.sh "$DB_NAME" insert_into_table "$TABLE_NAME" ;;

SELECT\ \*FROM)
if [[ -z "$DB_NAME" || -z "$TABLE_NAME" ]]; then
echo "Error: Missing databases or table name."
exit1
fi
./table_operations.sh "$DB_NAME" select_from_table "$TABLE_NAME" ;;

    *)
         echo "Invalid SQL command."
         ;;
esac

