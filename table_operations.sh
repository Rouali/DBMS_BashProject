#!/bin/bash

table_menu() {
    local db_name=$1
    local table_dir="./db_storage/$db_name"

    while true; do
        echo -e "\n========================="
        echo "     Table Operations    "
        echo "========================="
        echo "1) Create Table"
        echo "2) List Tables"
        echo "3) Drop Table"
        echo "4) Insert Into Table"
        echo "5) Select From Table"
        echo "6) Back to Database Menu"
        echo "========================="
        read -p "Choose an option: " choice

        case $choice in
            1) create_table "$db_name" ;;
            2) list_tables "$db_name" ;;
            3) drop_table "$db_name" ;;
            4) insert_into_table "$db_name" ;;
            5) select_from_table "$db_name" ;;
            6) return ;;
            *) echo "Invalid option, try again." ;;
        esac
    done
}

create_table() {
    local db_name=$1
    local table_dir="./db_storage/$db_name"

    read -p "Enter table name: " table_name
    if [[ -f "$table_dir/$table_name" ]]; then
        echo "Table '$table_name' already exists."
        return
    fi

    touch "$table_dir/$table_name"
    echo "Table '$table_name' created successfully."
}

list_tables() {
    local db_name=$1
    local table_dir="./db_storage/$db_name"

    echo "Tables in '$db_name':"
    ls "$table_dir"
}

drop_table() {
    local db_name=$1
    local table_dir="./db_storage/$db_name"

    read -p "Enter table name to drop: " table_name
    if [[ -f "$table_dir/$table_name" ]]; then
        rm "$table_dir/$table_name"
        echo "Table '$table_name' deleted."
    else
        echo "Table '$table_name' does not exist."
    fi
}

insert_into_table() {
    local db_name=$1
    local table_dir="./db_storage/$db_name"

    read -p "Enter table name: " table_name
    if [[ ! -f "$table_dir/$table_name" ]]; then
        echo "Table '$table_name' does not exist."
        return
    fi

    read -p "Enter data (comma-separated): " data
    echo "$data" >> "$table_dir/$table_name"
    echo "Data inserted into '$table_name'."
}

select_from_table() {
    local db_name=$1
    local table_dir="./db_storage/$db_name"

    read -p "Enter table name: " table_name
    if [[ ! -f "$table_dir/$table_name" ]]; then
        echo "Table '$table_name' does not exist."
        return
    fi

    echo "Contents of '$table_name':"
    cat "$table_dir/$table_name"
}
