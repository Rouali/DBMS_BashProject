#!/bin/bash

DB_DIR="./db_storage"
CURRENT_DB_FILE="./current_db.txt"

get_current_db() {
    if [[ -f "$CURRENT_DB_FILE" ]]; then
        cat "$CURRENT_DB_FILE"
    else
        echo ""
    fi
}

create_table() {
    CURRENT_DB=$(get_current_db)
    if [[ -z "$CURRENT_DB" ]]; then
        echo "No database selected. Use 'Connect to Database' first."
        return
    fi

    TABLE_DIR="$DB_DIR/$CURRENT_DB"

    read -p "Enter table name: " table_name
    table_file="$TABLE_DIR/$table_name"
    meta_file="$TABLE_DIR/$table_name.meta"

    if [[ -f "$table_file" ]]; then
        echo "Table '$table_name' already exists."
        return
    fi

    mkdir -p "$TABLE_DIR"
    touch "$table_file"
    touch "$meta_file"

    columns=()
    data_types=()

    echo "Define table schema (column name and data type):"
    while true; do
        read -p "Column name (or type 'done' to finish): " col_name
        if [[ "$col_name" == "done" ]]; then
            break
        fi

        read -p "Data type (INT, STRING): " col_type
        if [[ "$col_type" != "INT" && "$col_type" != "STRING" ]]; then
            echo "Invalid data type. Use INT or STRING."
            continue
        fi

        columns+=("$col_name")
        data_types+=("$col_type")
    done

    echo "Available columns: ${columns[*]}"
    while true; do
        read -p "Enter primary key column: " primary_key
        if [[ " ${columns[@]} " =~ " $primary_key " ]]; then
            break
        else
            echo "Invalid primary key. It must be one of the defined columns."
        fi
    done

    echo "Columns: ${columns[*]}" > "$meta_file"
    echo "Data Types: ${data_types[*]}" >> "$meta_file"
    echo "Primary Key: $primary_key" >> "$meta_file"

    echo "Table '$table_name' created successfully."
}

list_tables() {
    CURRENT_DB=$(get_current_db)
    if [[ -z "$CURRENT_DB" ]]; then
        echo "No database selected. Use 'Connect to Database' first."
        return
    fi

    TABLE_DIR="$DB_DIR/$CURRENT_DB"
    echo "Tables in database '$CURRENT_DB':"
    ls "$TABLE_DIR" | grep -v ".meta"
}

drop_table() {
    CURRENT_DB=$(get_current_db)
    if [[ -z "$CURRENT_DB" ]]; then
        echo "No database selected. Use 'Connect to Database' first."
        return
    fi

    TABLE_DIR="$DB_DIR/$CURRENT_DB"

    read -p "Enter table name to drop: " table_name
    table_file="$TABLE_DIR/$table_name"
    meta_file="$TABLE_DIR/$table_name.meta"

    if [[ -f "$table_file" ]]; then
        rm "$table_file" "$meta_file"
        echo "Table '$table_name' deleted."
    else
        echo "Table '$table_name' does not exist."
    fi
}

insert_into_table() {
    CURRENT_DB=$(get_current_db)
    if [[ -z "$CURRENT_DB" ]]; then
        echo "No database selected. Use 'Connect to Database' first."
        return
    fi

    TABLE_DIR="$DB_DIR/$CURRENT_DB"
    read -p "Enter table name: " table_name
    table_file="$TABLE_DIR/$table_name"
    meta_file="$TABLE_DIR/$table_name.meta"

    if [[ ! -f "$table_file" || ! -f "$meta_file" ]]; then
        echo "Table '$table_name' does not exist."
        return
    fi

    columns=($(grep "Columns:" "$meta_file" | cut -d ':' -f2))
    data_types=($(grep "Data Types:" "$meta_file" | cut -d ':' -f2))
    primary_key=$(grep "Primary Key:" "$meta_file" | cut -d ':' -f2)

    values=()
    pk_index=-1

    for i in "${!columns[@]}"; do
        col_name="${columns[i]}"
        col_type="${data_types[i]}"

        read -p "Enter value for $col_name ($col_type): " value

        if [[ "$col_type" == "INT" && ! "$value" =~ ^[0-9]+$ ]]; then
            echo "Error: $col_name must be an integer."
            return
        fi

        values+=("$value")

        if [[ "$col_name" == "$primary_key" ]]; then
            pk_index=$i
        fi
    done

    if [[ "$pk_index" -ne -1 ]]; then
        pk_value="${values[$pk_index]}"
        if grep -q "^$pk_value|" "$table_file"; then
            echo "Error: Primary Key '$pk_value' already exists."
            return
        fi
    fi

    echo "${values[*]}" | sed 's/ /|/g' >> "$table_file"
    echo "Data inserted into '$table_name'."
}

select_from_table() {
    CURRENT_DB=$(get_current_db)
    if [[ -z "$CURRENT_DB" ]]; then
        echo "No database selected. Use 'Connect to Database' first."
        return
    fi

    TABLE_DIR="$DB_DIR/$CURRENT_DB"
    read -p "Enter table name: " table_name
    table_file="$TABLE_DIR/$table_name"

    if [[ -f "$table_file" ]]; then
        echo "Contents of '$table_name':"
        column -t -s "|" "$table_file"
    else
        echo "Table '$table_name' does not exist."
    fi
}

delete_from_table() {
    CURRENT_DB=$(get_current_db)
    if [[ -z "$CURRENT_DB" ]]; then
        echo "No database selected. Use 'Connect to Database' first."
        return
    fi

    TABLE_DIR="$DB_DIR/$CURRENT_DB"
    read -p "Enter table name: " table_name
    table_file="$TABLE_DIR/$table_name"

    if [[ -f "$table_file" ]]; then
        echo "Deleting all data from '$table_name'."
        > "$table_file"
    else
        echo "Table '$table_name' does not exist."
    fi
}

table_menu() {
    while true; do
        echo "========================="
        echo "       Table Menu       "
        echo "========================="
        echo "1) Create Table"
        echo "2) List Tables"
        echo "3) Drop Table"
        echo "4) Insert Into Table"
        echo "5) Select From Table"
        echo "6) Delete From Table"
        echo "7) Back to Database Menu"
        echo "========================="
        read -p "Choose an option: " table_choice

        case $table_choice in
            1) create_table ;;
            2) list_tables ;;
            3) drop_table ;;
            4) insert_into_table ;;
            5) select_from_table ;;
            6) delete_from_table ;;
            7) break ;;
            *) echo "Invalid option, try again." ;;
        esac
    done
}
