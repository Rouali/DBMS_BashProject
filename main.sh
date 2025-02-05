#!/bin/bash

source ./db_operations.sh

while true; do
   echo "Main Menu:"
   echo "1) Create Database"
   echo "2) List Database"
   echo "3) Connect to Database"
   echo "4) Drop Database"
   echo "5) Execute SQL Command"
   echo "6) Exit"
   read -p "Choose an option: " choice

   case $choice in
        1) create_database ;;
        2) list_databases ;;
        3) connect_database ;;
        4) drop_database ;;
        5) read -p "Enter SQL command (e.g, CREATE DATABASE db_name): " SQL_COMMAND
           ./sql_parser.sh "$SQL_COMMAND" ;;
        6) exit ;;
        *) echo "Invalid option, try again." ;;
   esac
done
