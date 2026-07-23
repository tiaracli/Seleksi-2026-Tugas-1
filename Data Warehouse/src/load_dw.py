import psycopg2


def create_and_load_dw():
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

  cursor.execute("DROP TABLE IF EXISTS fact_buildings CASCADE;")
  cursor.execute("DROP TABLE IF EXISTS dim_cities CASCADE;")
  cursor.execute("DROP TABLE IF EXISTS dim_materials CASCADE;")
  cursor.execute("DROP TABLE IF EXISTS dim_functions CASCADE;")

  # dimensi city
  cursor.execute("""
        CREATE TABLE dim_cities AS
        SELECT city_id, city_name FROM cities;
    """)

  # dimensi material
  cursor.execute("""
        CREATE TABLE dim_materials (
            material_id SERIAL PRIMARY KEY,
            material_name VARCHAR(100) UNIQUE
        );
        INSERT INTO dim_materials (material_name)
        SELECT DISTINCT material FROM buildings WHERE material IS NOT NULL;
    """)

  # dimensi function
  cursor.execute("""
        CREATE TABLE dim_functions (
            function_id SERIAL PRIMARY KEY,
            function_name VARCHAR(100) UNIQUE
        );
        INSERT INTO dim_functions (function_name)
        SELECT DISTINCT function FROM buildings WHERE function IS NOT NULL;
    """)

  # fact table
  cursor.execute("""
        CREATE TABLE fact_buildings AS
        SELECT 
            b.building_id,
            b.city_id,
            m.material_id,
            f.function_id,
            b.completion_year,
            b.height_m,
            b.height_ft,
            b.floors
        FROM buildings b
        LEFT JOIN dim_materials m ON b.material = m.material_name
        LEFT JOIN dim_functions f ON b.function = f.function_name;
    """)

  conn.commit()
  cursor.close()
  conn.close()
  print("data warehouse & star schema stored into PostgreSQL database")


if __name__ == "__main__":
  create_and_load_dw()