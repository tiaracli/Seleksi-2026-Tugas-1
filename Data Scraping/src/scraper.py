import glob
import json
import os
import re
from bs4 import BeautifulSoup


def scrape_skyscrapers():
  script_dir = os.path.dirname(os.path.abspath(__file__))

  html_files = glob.glob(os.path.join(script_dir, '*.html')) + glob.glob(
      os.path.join(script_dir, '*.htm')
  )

  if not html_files:
    print("Tidak ada file .html di folder 'Data Scraping/src/'")
    return

  html_file_path = html_files[0]
  print(f"Membaca file: {os.path.basename(html_file_path)} ...")

  with open(html_file_path, 'r', encoding='utf-8', errors='ignore') as f:
    html_content = f.read()

  soup = BeautifulSoup(html_content, 'html.parser')
  table = soup.find('table')

  if not table:
    print('Tabel not found.')
    return

  buildings_data = []
  cities_data = []
  city_set = set()
  city_id_counter = 1

  rows = table.find_all('tr')

  for row in rows:
    cols = row.find_all(['td', 'th'])

    if len(cols) < 5:
      continue

    col_texts = [c.text.strip().replace('\xa0', ' ') for c in cols]

    full_row_str = ' '.join(col_texts)
    if 'Building' in full_row_str and 'Height' in full_row_str:
      continue
    if 'Rank' in col_texts[0] or 'Building Name' in col_texts[1]:
      continue

    name = col_texts[1] if len(col_texts) > 1 else 'Unknown'
    city = col_texts[2] if len(col_texts) > 2 else 'Unknown'

    completion_year = 0
    height_m = 0.0
    height_ft = 0.0
    floors = 0
    function_val = 'Mixed-Use'
    material_val = 'Composite'

    for text in col_texts:
      # height
      if 'm' in text.lower() or 'ft' in text.lower():
        m_match = re.search(r'([\d\.,]+)\s*m', text, re.IGNORECASE)
        if m_match and height_m == 0.0:
          try:
            height_m = float(m_match.group(1).replace(',', ''))
          except:
            pass

        ft_match = re.search(r'([\d\.,]+)\s*ft', text, re.IGNORECASE)
        if ft_match and height_ft == 0.0:
          try:
            height_ft = float(ft_match.group(1).replace(',', ''))
          except:
            pass

      # year
      if re.search(r'\b(19\d\d|20\d\d)\b', text) and completion_year == 0:
        y_match = re.search(r'\b(19\d\d|20\d\d)\b', text)
        completion_year = int(y_match.group(0))

      # floors
      if (
          text.isdigit()
          and int(text) < 300
          and floors == 0
          and completion_year > 0
      ):
        floors = int(text)

      # function dan material
      if any(
          k in text.lower()
          for k in ['office', 'residential', 'hotel', 'retail', 'mixed']
      ):
        function_val = text
      elif any(k in text.lower() for k in ['steel', 'concrete', 'composite']):
        material_val = text

    if city and city not in city_set and city != 'Unknown':
      city_set.add(city)
      cities_data.append({'city_id': city_id_counter, 'city_name': city})
      city_id_counter += 1

    current_city_id = next(
        (c['city_id'] for c in cities_data if c['city_name'] == city), 1
    )

    buildings_data.append({
        'building_id': len(buildings_data) + 1,
        'name': name,
        'city_id': current_city_id,
        'completion_year': completion_year,
        'height_m': height_m,
        'height_ft': height_ft,
        'floors': floors,
        'function': function_val,
        'material': material_val,
    })

    if len(buildings_data) >= 50:
      break

  data_dir = os.path.join(script_dir, '..', 'data')
  os.makedirs(data_dir, exist_ok=True)

  with open(
      os.path.join(data_dir, 'buildings.json'), 'w', encoding='utf-8'
  ) as f:
    json.dump(buildings_data, f, indent=4, ensure_ascii=False)

  with open(
      os.path.join(data_dir, 'cities.json'), 'w', encoding='utf-8'
  ) as f:
    json.dump(cities_data, f, indent=4, ensure_ascii=False)

  print(f"done scraping {len(buildings_data)} buildings data")


if __name__ == '__main__':
  scrape_skyscrapers()