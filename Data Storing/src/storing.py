import json
import os
import psycopg2


def insert_to_database():
  DB_HOST = "localhost"
  DB_PORT = "5432"
  DB_NAME = "skyscrapers_db"
  DB_USER = "tiaraclianta"
  DB_PASS = ""

  conn = psycopg2.connect(
      host=DB_HOST,
      port=DB_PORT,
      dbname=DB_NAME,
      user=DB_USER,
      password=DB_PASS,
  )
  cursor = conn.cursor()

  cursor.execute("DROP TABLE IF EXISTS buildings CASCADE;")
  cursor.execute("DROP TABLE IF EXISTS cities CASCADE;")

  create_tables_script = """
    CREATE TABLE cities (
        city_id INT PRIMARY KEY,
        city_name VARCHAR(100) NOT NULL
    );

    CREATE TABLE buildings (
        building_id INT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        city_id INT REFERENCES cities(city_id),
        completion_year INT,
        height_m FLOAT,
        height_ft FLOAT,
        floors INT,
        function VARCHAR(100),
        material VARCHAR(100)
    );
    """
  cursor.execute(create_tables_script)
  conn.commit()

  script_dir = os.path.dirname(os.path.abspath(__file__))
  data_dir = os.path.join(script_dir, "..", "..", "Data Scraping", "data")

  with open(
      os.path.join(data_dir, "cities.json"), "r", encoding="utf-8"
  ) as f:
    cities_data = json.load(f)

  with open(
      os.path.join(data_dir, "buildings.json"), "r", encoding="utf-8"
  ) as f:
    buildings_data = json.load(f)

  for city in cities_data:
    cursor.execute(
        """
            INSERT INTO cities (city_id, city_name)
            VALUES (%s, %s)
            ON CONFLICT (city_id) DO NOTHING;
        """,
        (city["city_id"], city["city_name"]),
    )

  for bldg in buildings_data:
    cursor.execute(
        """
            INSERT INTO buildings (building_id, name, city_id, completion_year, height_m, height_ft, floors, function, material)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s);
        """,
        (
            bldg["building_id"],
            bldg["name"],
            bldg["city_id"],
            bldg["completion_year"],
            bldg["height_m"],
            bldg["height_ft"],
            bldg["floors"],
            bldg["function"],
            bldg["material"],
        ),
    )

  conn.commit()
  cursor.close()
  conn.close()
  print("data stored into PostgreSQL database")


if __name__ == "__main__":
  insert_to_database()