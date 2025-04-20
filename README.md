# DBMS_BashProject

A simple **Database Management System (DBMS)** built entirely using **Bash shell scripting**. This project is designed to simulate basic DBMS functionality through a command-line interface, offering a hands-on learning experience for Linux and scripting enthusiasts.

## 🚀 Features

- Create and manage databases (directories)
- Create, list, and delete tables (files)
- Define table schemas (columns with data types)
- Insert, display, update, and delete records
- Data validation based on column types (e.g., `int`, `string`)
- Menu-based navigation with clear user prompts
- Modular codebase with clean separation of concerns

## 🗂️ Project Structure

```
DBMS_BashProject/
├── main.sh               # Entry point: main menu to navigate between databases
├── db_operations.sh      # Database-level operations (create, list, delete, connect)
├── table_operations.sh   # Table-level operations (create, list, delete, manipulate records)
├── utils.sh              # Helper functions (input validation, formatting, etc.)
└── databases/            # All created databases and tables stored here
```

## 🧰 Requirements

- Unix/Linux environment
- Bash version 4+
- Terminal access with execution permissions

## ⚙️ How to Run

1. Clone the repository:

```bash
git clone https://github.com/Rouali/DBMS_BashProject.git
cd DBMS_BashProject
```

2. Make the scripts executable:

```bash
chmod +x *.sh
```

3. Launch the DBMS:

```bash
./main.sh
```

## 📚 Learning Objectives

- Deepen understanding of Linux file systems and Bash scripting
- Learn how to simulate data structures and CRUD operations
- Explore error handling and user-friendly command-line interfaces

## 🧠 Concepts Used

- File I/O in Bash
- Arrays and string manipulation
- Functions and modularization
- Input validation with regex
- Simulating databases using directories and text files

## ✍️ Author

- [Rouali](https://github.com/Rouali)

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

> ⚡ Contributions, suggestions, and feedback are welcome!
