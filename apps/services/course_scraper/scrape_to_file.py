import requests
from bs4 import BeautifulSoup
import time

def create_insert_statement(module_data):
    keys = ', '.join(module_data.keys())
    values = []
    for key, value in module_data.items():
        if key == 'zpa_id':
            value = f"{value}L"
        elif isinstance(value, str) and key != 'id':
            value = "'{}'".format(value.replace("'", "''"))
        values.append(str(value))
    values_str = ', '.join(values)
    return f"INSERT INTO module ({keys}) VALUES ({values_str});"

# Define the base URL of the module listings page
base_url = 'https://zpa.cs.hm.edu/public/module/'

# Number of pages to scrape
num_pages = 446

# Open the file for writing
with open('data.sql', 'w') as file:
    # Loop through the pages
    for page_number in range(1, num_pages + 1):
        module_listings_url = f'{base_url}{page_number}/'
        response = requests.get(module_listings_url)

        if response.status_code == 200:
            soup = BeautifulSoup(response.content, 'html.parser')
            module_tables = soup.find('div', id='content').find_all('table')

            if module_tables:
                module_data = {'id': 'default', 'zpa_id': page_number}
                table = module_tables[0]
                rows = table.find_all('tr')

                for row in rows:
                    columns = row.find_all('td')
                    if len(columns) == 2 and columns[0].get('class', [''])[0] == 'left':
                        key = columns[0].text.strip().replace(' ', '_').lower()
                        value = columns[1].get_text(separator=' ').strip()

                        if key == 'sprache(n)':
                            key = 'sprachen'
                            languages = []
                            if "Deutsch" in value:
                                languages.append("Deutsch")
                            if "Englisch" in value:
                                languages.append("Englisch")
                            module_data[key] = ", ".join(languages)
                            module_data['anzahl_sprachen'] = len(languages)
                        else:
                            module_data[key] = value

                    module_data['url'] = module_listings_url

                if module_data:
                    # Create an SQL insert statement and write it to the file
                    insert_statement = create_insert_statement(module_data)
                    file.write(insert_statement + '\n')

        # Adding a delay to prevent potential rate limiting
        time.sleep(0.5)
