#!/bin/bash

DB_DIR="./db_storage"
CURRENT_DB_FILE="./current_db.txt"

mkdir -p "$DB_DIR"

source "./db_operations.sh"
source "./table_operations.sh"

display_main_menu() {
    while true; do
        echo "========================="
        echo "      Bash DBMS         "
        echo "========================="
        echo "1) Create Database"
        echo "2) List Databases"
        echo "3) Connect to Database"
        echo "4) Drop Database"
        echo "5) Exit"
        echo "========================="
        read -p "Choose an option: " choice

        case $choice in
            1) create_database ;;
            2) list_databases ;;
            3) connect_database ;;
            4) drop_database ;;
            5) echo "Goodbye!"; exit ;;
            *) echo "Invalid option, try again." ;;
        esac
    done
}

display_main_menu
