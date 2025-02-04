#!/bin/bash

DB_FILE="bank_database.txt"

# Ensure the database file exists
touch "$DB_FILE"

# Function to add a new client
add_client() {

    read -p "Enter Client ID:" client_id

    grep -q "^id: $client_id:" "$DB_FILE" && echo "Client already exists!" && return

    read -p "Enter Client Name:" client_name

    read -p "Enter Client Balance:" client_balance

    echo "id: $client_id Name: $client_name Balance: $client_balance$" >>"$DB_FILE"
    echo "Client added successfully!"
}

# Function to update client details
update_client() {

    read -p "Enter Client ID to update:" client_id

    grep -q "^id: $client_id " "$DB_FILE" || {
        echo "Client not found!"
        return
    }

    read -p "Enter New Name:" new_name

    read -p "Enter New Balance:" new_balance

    sed -i "/^id: $client_id / c\id: $client_id Name: $new_name Balance: $new_balance$" "$DB_FILE"
    echo "Client updated successfully!"
}

# Function to delete a client
delete_client() {

    read -p "Enter Client ID to delete:" client_id

    grep -q "^id: $client_id " "$DB_FILE" || {
        echo "Client not found!"
        return
    }

    sed -i "/^id: $client_id /d" "$DB_FILE"
    echo "Client deleted successfully!"
}

# Function to print all clients
print_clients() {
    echo "--- Client List ---"
    cat "$DB_FILE"
}

# Main menu
while true; do
    echo -e "\nBank Database Management System"
    echo "1. Add Client"
    echo "2. Update Client"
    echo "3. Delete Client"
    echo "4. Print Clients"
    echo "5. Exit"

    read -p "Choose an option:" choice

    case $choice in
    1) add_client ;;
    2) update_client ;;
    3) delete_client ;;
    4) print_clients ;;
    5) exit 0 ;;
    *) echo "Invalid option, please try again!" ;;
    esac
done
