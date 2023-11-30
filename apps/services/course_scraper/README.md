# Web Scraper for Module Listings

This document provides installation and usage instructions for the web scraper component of the "Software Engineering 1" project.

## Overview

The web scraper is designed to extract module information from the ZPA module listings page and insert the data into a PostgreSQL database.

## Prerequisites

- Python 3.10 or higher
- Conda
- PostgreSQL

## Setup

### 1. Install PostgreSQL

Download and install PostgreSQL for your operating system from the official [PostgreSQL Downloads](https://www.postgresql.org/download/) page. Follow the installation prompts and make sure to remember the database superuser (usually `postgres`) password you set during installation.

### 2. Create a User and Database

Log in to the PostgreSQL console as the superuser:

```sh
psql -U postgres
```

Run the following commands to create a new role and database:

```sql
CREATE ROLE your_username WITH LOGIN PASSWORD 'your_password';
CREATE DATABASE your_db_name OWNER your_username;
GRANT ALL PRIVILEGES ON DATABASE your_db_name TO your_username;
```

Replace `your_username` and `your_password` with your desired credentials and `your_db_name` with your intended database name.

### 3. Set Up the Database Schema

Connect to your new database:

```sql
\c your_db_name
```

Create the `modules` table:

```sql
CREATE TABLE IF NOT EXISTS modules (
    id SERIAL PRIMARY KEY,
    Name TEXT,
    Anzahl_Sprachen INTEGER,
    Verantwortlich TEXT,
    SWS TEXT,
    ECTS TEXT,
    Sprachen TEXT,
    Lehrform TEXT,
    Angebot TEXT,
    Aufwand TEXT,
    Voraussetzungen TEXT,
    Ziele TEXT,
    Inhalt TEXT,
    Medien_und_Methoden TEXT,
    Literatur TEXT,
    Url TEXT
);
```

Assign privileges to your user:

```sql
GRANT ALL PRIVILEGES ON TABLE modules TO your_username;
GRANT USAGE, SELECT ON SEQUENCE modules_id_seq TO your_username;
```

### 4. Environment Configuration
Copy the `.env.example` file to a new file named `.env` and fill it with your database information:

```bash
DB_NAME=your_database_name
DB_USER=your_database_username
DB_PASSWORD=your_database_password
DB_HOST=localhost
```

Replace the placeholder values with your actual database details.

### 5. Install Dependencies with Conda

It is recommended to use a Conda environment to manage the dependencies of your project. Conda is an open-source package management system and environment management system that runs on Windows, macOS, and Linux. Using Conda, you can create isolated environments that have their own versions of Python and installed packages.

If you do not have Conda installed, follow the instructions from the [Conda installation guide](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html).

To create an environment from the given `environment.yml` file, use the following command:

```bash
conda env create -f environment.yml
```

Activate the environment using the following command:

```bash
conda activate se_praktikum_scraper
```

## Usage

Remember to always activate your Conda environment before running the scraper to ensure all dependencies are managed correctly:

```bash
conda activate se_praktikum_scraper
```

Run the scraper using the following command:

```bash
python run_scraper.py
```

The scraper will automatically connect to the database using the credentials provided in `.env`, scrape the module listings page, and insert the data into the modules table.

## Important Notes

- Ensure the `modules` table exists with the correct schema before running the scraper.
- Adjust the `time.sleep` delay in the script if necessary to manage the request rate.
- The script will print each module's data to the console before insertion for debugging purposes.

## Troubleshooting
If you encounter any issues with database connectivity, check the following:

- The `.env` file is correctly formatted and contains the correct credentials.
- PostgreSQL is running and accessible at the `DB_HOST` address specified.
