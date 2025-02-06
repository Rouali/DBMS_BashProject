#!/bin/bash

DB_NAME=$1
TABLE_DIR="./db_storage/$DB_NAME"

create_table(){
read -p "Enter table name: " table_name
if [[ -f "$TABLE_DIR/$table_name" ]]; then
echo "Table '$table_name' already exists."
return
fi

read -p "Enter column names and data types: " columns
read -p "Enter the primary key column:" primary_key

echo "$columns" > "$TABLE_DIR/$table_name.meta"
echo "PrimaryKey: $primary_key" >> "$TABLE_DIR/$table_name.meta"

touch "$TABLE_DIR/$table_name"
echo "Table '$table_name' created successfully."
}

list_table(){
echo "Tables in '$DB_NAME':"
ls "$TABLE_DIR"
}

drop_table(){
read -p "Enter table name to drop: " table_name
if [[ -f "$TABLE_DIR/$table_name" ]]; then
rm "$TABLE_DIR/$table_name"
echo "Table '$table_name' deleted."
else
echo "Table '$table_name' does not exist."
fi
}

insert_into_table(){
read -p "Enter table name: " table_name
table_file="$TABLE_DIR/$table_name"
meta_file="$TABLE_DIR/$table_name.meta"

if [[ ! -f "$table_file" || ! -f "$meta_file" ]]; then
echo "Table '$table_name' does not exist."
return
fi

schema=$(head -n 1 "$meta_file")
primary_key=$(grep "PrimaryKey:" "$meta_file" | cut -d '' -f2)
IFS=',' read -ra columns <<< "$schema"

values=()
for column in "${columns[@]}"; do
col_name=$(echo "$column" | awk '{print $1}')
col_type=$(echo "$column" | awk '{print $2}')

read -p "Enter value for $col_name($col_type): " value

#validate data type
if [[ "$col_type" == "INT" && ! "$value" =~ ^[0-9]+$ ]]; then
echo "Error: $col_name must be an integer."
return
fi
values+=("$value")
done

#check if pk already exist
pk_index=1
for i in "${!columns[@]}"; do 
if [[ "${columns[i]}" == *"$primary_key"* ]]; then
pk_index=$i
break
fi
done
if [[ "$pk_index" -ne -1 ]]; then
pk_value="${values[$pk_index]}"
if grep -q "^$pk_value|" "$table_file"; then
echo "Error: Primary Key '$pk_value' already exists."
return
fi
fi

#inserting
echo "{$values[*]}" | sed 's/ /|/g' >> "$table_file"
echo "Data inserted into '$table_name'."
}


select_from_table(){
read -p "Enter table name: " table_name
table_file="$TABLE_DIR/$table_name"

if [[ -f "$table_file" ]]; then
echo "Contents of '$table_name':"
column -t -s "|" "$table_file"
else
"Table '$table_name' does not exist."
fi
}


