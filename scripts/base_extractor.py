import requests, os
from bs4 import BeautifulSoup
from dataclasses import dataclass

URL = "https://www.poe2wiki.net/wiki/{0}"
OUTPUT = "build/base_extractor/{0}.filter"
BASE_URL_SUFFIXES_TO_DISCRIMINATE: list[str] = [
    "Body_armour",
    "Flask",
    "Gloves",
    "Boots",
    "Helmet",
    "Shield",
    "Focus",
    "Crossbow"
]

@dataclass
class Base:
    name: str
    drop_level: int

def extract(url: str):
    page = requests.get(url)
    html = BeautifulSoup(page.text, 'html.parser')
    return [ extract_bases_from_table(table)
        for table in html.find_all('table', class_ = "item-table")
        if is_table_valid(table) ]

def is_table_valid(table):
    table_title: str = table.find_previous_sibling('h2').text
    return "unique" not in table_title.lower()

def extract_bases_from_table(table):
    bases: list[Base] = [ extract_base_from_row(row)
        for row in table.tbody.find_all('tr') ]
    return [ base for base in bases if base != None ]

def extract_base_from_row(row):
    tds = row.find_all('td')
    if len(tds) < 2:
        return None
    return Base(tds[0].span.span.a['title'], int(tds[1].text))

def get_sections(base_lists: list[list[Base]]):
    sections: dict[int, list[str]] = {}
    
    for base_list in base_lists:
        for base in base_list:
            
            drop_level_generator = (next_base.drop_level
                for next_base in base_list
                if next_base.drop_level > base.drop_level)
            
            next_drop_level =  next(drop_level_generator, 100)
            
            if next_drop_level not in sections:
                sections[next_drop_level] = []
            
            sections[next_drop_level] += [ base.name ]

    return sections

def write_sections(sections: dict[int, list[str]], filepath: str):
    contents = '\n\n'.join(
        print_section(area_level, basenames)
        for area_level, basenames in sorted(sections.items()))
    
    os.makedirs(os.path.dirname(filepath), exist_ok=True)
    with open(filepath, "w") as file:
        file.write(contents)

def print_section(area_level: int, basenames: list[str]):
    basenames_str = " ".join(f'"{basename}"' for basename in sorted(basenames))
    return f"Show\n    BaseType == {basenames_str}\n    AreaLevel < {area_level}"

def main():
    for suffix in BASE_URL_SUFFIXES_TO_DISCRIMINATE:
        print(f"Generating for '{suffix}'...")
        
        base_lists = extract(URL.format(suffix))
        sections = get_sections(base_lists)
        write_sections(sections, OUTPUT.format(suffix))

    print("Done!")

if __name__ == "__main__":
    main()