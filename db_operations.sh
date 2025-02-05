#!/bin/bash

DB_DIR="./db_storage"

create_database(){
read -p "Enter database name: " db_name
if [[ -d "$DB_DIR/$db_name" ]]; then
   echo "Database '$db_name' already exists."
else
   mkdir "$DB_DIR/$db_name"
   echo "Database '$db_name' created successfully."
fi
}


list_databases(){
echo "Available databases: "
ls "$DB_DIR"
}


drop_database(){
read -p "Enter database name to drop: " db_name
if [[ -d "$DB_DIR/$db_name" ]]; then
   rm -r "$DB_DIR/$db_name"
   echo "Database '$db_name' deleted."
else
   echo "Database '$db_name' does not exist."
fi
}


connect_database(){
read -p "Enter database name to connect: "db_name
if [[ -d "$DB_DIR/%db_name" ]]; then
   echo "Connected to database '$db_name'."
   ./table_operations.sh "$db_name"
else
   echo "Database '$db_name' does not exist."
fi
}
