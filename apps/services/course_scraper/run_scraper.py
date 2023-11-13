import time
import os

from bs4 import BeautifulSoup
from dotenv import load_dotenv
import requests
import psycopg2

# Load environment variables from .env file
load_dotenv()

# Function to insert a module into the 'modules' table
def insert_module(module_data, connection):
    # Construct the SQL insert statement
    columns = module_data.keys()
    values = [module_data[column] for column in columns]
    placeholders = ', '.join(['%s'] * len(values))  # Create placeholders for the values
    column_names = ', '.join(columns)
    
    sql = f"INSERT INTO modules ({column_names}) VALUES ({placeholders})"

    cursor = connection.cursor()
    cursor.execute(sql, values)
    connection.commit()
    cursor.close()


# Connect to the database
db_name = os.getenv("DB_NAME")
db_user = os.getenv("DB_USER")
db_password = os.getenv("DB_PASSWORD")
db_host = os.getenv("DB_HOST")

database_connection = psycopg2.connect(
    dbname=db_name,
    user=db_user,
    password=db_password,
    host=db_host
)

# Define the base URL of the module listings page
base_url = 'https://zpa.cs.hm.edu/public/module/'

# Number of pages to scrape
num_pages = 446

# Loop through the pages
for page_number in range(1, num_pages + 1):
    # Construct the URL for the current page
    module_listings_url = f'{base_url}{page_number}/'

    # Use requests to retrieve the page content
    response = requests.get(module_listings_url)
    # If the request was successful
    if response.status_code == 200:
        # Parse the page content using BeautifulSoup
        soup = BeautifulSoup(response.content, 'html.parser')

        # Find all module detail tables within the 'content' div
        module_tables = soup.find('div', id='content').find_all('table')

        # This will hold the data for the first table
        module_data = {}

        # Check if there's at least one table
        if module_tables:
            table = module_tables[0]  # Get the first table
            rows = table.find_all('tr')

            # Loop through the rows
            for row in rows:
                columns = row.find_all('td')
                # Check if the row has two td elements, to avoid the nested curriculum table
                if len(columns) == 2 and columns[0].get('class', [''])[0] == 'left':
                    key = columns[0].text.strip().replace(' ', '_')  # Replace spaces with underscores
                    value = columns[1].get_text(separator=' ').strip() # Get the coontent of the second column
                    languages = []
                    # Check if the key is 'Sprache(n)'
                    if key == 'Sprache(n)':
                        key = 'Sprachen'  # Rename the key to match the table schema
                        # Check if the value contains 'Deutsch' or 'Englisch'
                        if "Deutsch" in value:
                            languages.append("Deutsch")
                        if "Englisch" in value:
                            languages.append("Englisch")
                        # Join the languages list into a string
                        module_data[key] = ", ".join(languages)
                        # Count the number of languages found
                        module_data['Anzahl_Sprachen'] = len(languages)
                    else:
                        # Add the key-value pair to the module_data dictionary
                        module_data[key] = value
                
                # Add the URL to the module_data dictionary
                module_data['Url'] = module_listings_url

        # Check if the module_data dictionary is not empty
        if module_data:
            print(module_data)
            insert_module(module_data, database_connection)

    # Add a delay to avoid overloading the server (you can adjust the sleep duration)
    time.sleep(0.5)  # Sleep for 0.5 seconds before making the next request

# Close the database connection
database_connection.close()
