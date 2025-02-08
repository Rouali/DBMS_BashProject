#!/bin/bash

source ./db_operations.sh
source ./table_operations.sh
source ./sql_parser.sh

main_menu() {
    echo -e "\n========================="
    echo "         Main Menu       "
    echo "========================="
    echo "1) Use SQL"
    echo "2) Use Menu"
    echo "3) Exit"
    echo "========================="
    read -p "Choose an option: " choice
    echo "-------------------------"

    case $choice in
        1) read -p "Enter SQL command: " SQL_COMMAND
           ./sql_parser.sh "$SQL_COMMAND" ;;
        2) submenu ;;
        3) exit ;;
        *) echo "Invalid option, try again." ;;
    esac
}

submenu() {
    echo -e "\n========================="
    echo "   Database Management   "
    echo "========================="
    echo "1) Create Database"
    echo "2) List Databases"
    echo "3) Connect to Database"
    echo "4) Drop Database"
    echo "5) Back to Main Menu"
    echo "========================="
    read -p "Choose an option: " choice

    case $choice in
        1) create_database ;;
        2) list_databases ;;
        3) connect_database ;;
        4) drop_database ;;
        5) main_menu ;;
        *) echo "Invalid option, try again." ;;
    esac
}

while true; do
    main_menu
done
