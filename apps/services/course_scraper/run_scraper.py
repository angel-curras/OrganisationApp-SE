import time
import requests
from bs4 import BeautifulSoup

# Function to convert snake_case to camelCase
def snake_to_camel(snake_str):
    components = snake_str.split('_')
    return components[0] + ''.join(x.title() for x in components[1:])

# Function to post a module to the REST API
def post_module(module_data):
    # Convert keys to camelCase
    module_data_camel_case = {snake_to_camel(k.lower()): v for k, v in module_data.items()}

    # Send a POST request to the REST API
    response = requests.post('http://localhost:8080/modules', json=module_data_camel_case)
    if response.status_code == 201:
        print(f"Module posted successfully: {module_data_camel_case['name']} \n\n")
    else:
        print(f"Failed to post module: {module_data_camel_case['name']} \n\n")

# Define the base URL of the module listings page
base_url = 'https://zpa.cs.hm.edu/public/module/'

# Number of pages to scrape
num_pages = 446

# Loop through the pages
for page_number in range(1, num_pages + 1):
    module_listings_url = f'{base_url}{page_number}/'
    response = requests.get(module_listings_url)

    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')
        module_tables = soup.find('div', id='content').find_all('table')

        if module_tables:
            module_data = {}
            # page_no is id
            module_data['id'] = page_number
            table = module_tables[0]
            rows = table.find_all('tr')

            for row in rows:
                columns = row.find_all('td')
                if len(columns) == 2 and columns[0].get('class', [''])[0] == 'left':
                    key = columns[0].text.strip().replace(' ', '_')
                    value = columns[1].get_text(separator=' ').strip()
                    
                    if key == 'Sprache(n)':
                        key = 'Sprachen'
                        languages = []
                        if "Deutsch" in value:
                            languages.append("Deutsch")
                        if "Englisch" in value:
                            languages.append("Englisch")
                        module_data[key] = ", ".join(languages)
                        module_data['Anzahl_Sprachen'] = len(languages)
                    else:
                        module_data[key] = value
                
                module_data['Url'] = module_listings_url

            if module_data:
                print(module_data)
                print('\n')
                post_module(module_data)

    time.sleep(0.5)