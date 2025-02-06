#!/bin/bash

source ./db_operations.sh

main_menu(){
   echo -e "\n========================="
   echo "            Main Menu    "
   echo "========================="
   echo "1) Create Database"
   echo "2) List Database"
   echo "3) Connect to Database"
   echo "4) Drop Database"
   echo "5) Execute SQL Command"
   echo "6) Exit"
   echo "========================="
   read -p "Choose an option: " choice
   echo "-------------------------"

 case $choice in
        1) create_database
 echo "-------------------------"
;;
        2) list_databases
 echo "-------------------------"
;;
        3) connect_database
 echo "-------------------------"
;;
        4) drop_database
 echo "-------------------------"
;;
        5) read -p "Enter SQL command (e.g, CREATE DATABASE db_name): " SQL_COMMAND
 echo "-------------------------"
./sql_parser.sh "$SQL_COMMAND"
 echo "-------------------------"
;;
        6) exit ;;
        *) echo "Invalid option, try again."
 echo "-------------------------"
;;
   esac

}
while true; do
main_menu
done
