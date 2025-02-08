#!/bin/bash

DB_DIR="./db_storage"
CURRENT_DB_FILE="./db_storage/current_db.txt"

# Ensure the DB directory exists
mkdir -p "$DB_DIR"

# Load the current database if connected
if [[ -f "$CURRENT_DB_FILE" ]]; then
    CURRENT_DB=$(cat "$CURRENT_DB_FILE")
else
    CURRENT_DB=""
fi

SQL_COMMAND=$1

case "$SQL_COMMAND" in
    CREATE\ DATABASE*)
        ./db_operations.sh create_database ;;
    
    USE\ *)
        db_name=$(echo "$SQL_COMMAND" | cut -d ' ' -f2)
        if [[ -d "$DB_DIR/$db_name" ]]; then
            echo "$db_name" > "$CURRENT_DB_FILE"
            echo "Connected to database '$db_name'."
        else
            echo "Database '$db_name' does not exist."
        fi
        ;;
    
    DROP\ DATABASE*)
        ./db_operations.sh drop_database ;;
    
    LIST\ DATABASES)
        ./db_operations.sh list_databases ;;
    
    CREATE\ TABLE*)
        if [[ -z "$CURRENT_DB" ]]; then
            echo "Error: No database selected. Use 'USE <database>' first."
            exit 1
        fi
        ./table_operations.sh create_table ;;
    
    DROP\ TABLE*)
        if [[ -z "$CURRENT_DB" ]]; then
            echo "Error: No database selected. Use 'USE <database>' first."
            exit 1
        fi
        ./table_operations.sh drop_table ;;
    
    INSERT\ INTO*)
        if [[ -z "$CURRENT_DB" ]]; then
            echo "Error: No database selected. Use 'USE <database>' first."
            exit 1
        fi
        ./table_operations.sh insert_into_table ;;
    
    SELECT\ \*FROM*)
        if [[ -z "$CURRENT_DB" ]]; then
            echo "Error: No database selected. Use 'USE <database>' first."
            exit 1
        fi
        ./table_operations.sh select_from_table ;;
    
    *)
        echo "Invalid SQL command."
        ;;
esac
