-- QUERY OPTIMASI 1 Filtering berdasarkan tinggi dan tahun
-- mencari gedung dengan tinggi > 500m yang selesai setelah tahun 2010

-- Sebelum Indexing (Sequential Scan)
EXPLAIN ANALYZE 
SELECT name, height_m, completion_year 
FROM buildings 
WHERE height_m > 500 AND completion_year >= 2010;

-- Index B-Tree
CREATE INDEX IF NOT EXISTS idx_buildings_height_year ON buildings(height_m, completion_year);

-- Sesudah Indexing (Index Scan)
EXPLAIN ANALYZE 
SELECT name, height_m, completion_year 
FROM buildings 
WHERE height_m > 500 AND completion_year >= 2010;


-- QUERY OPTIMASI 2 Aggregation dan grouping berdasarkan city
-- menghitung rata-rata tinggi dan jumlah gedung per kota

-- Sebelum Indexing
EXPLAIN ANALYZE 
SELECT c.city_name, COUNT(b.building_id) as total_buildings, AVG(b.height_m) as avg_height
FROM buildings b
JOIN cities c ON b.city_id = c.city_id
GROUP BY c.city_name
HAVING COUNT(b.building_id) > 1;

-- Index pada Foreign Key city_id
CREATE INDEX IF NOT EXISTS idx_buildings_city_id ON buildings(city_id);

-- Sesudah Indexing
EXPLAIN ANALYZE 
SELECT c.city_name, COUNT(b.building_id) as total_buildings, AVG(b.height_m) as avg_height
FROM buildings b
JOIN cities c ON b.city_id = c.city_id
GROUP BY c.city_name
HAVING COUNT(b.building_id) > 1;


-- QUERY OPTIMASI 3 Sorting dan range query pada floors
-- mencari gedung dengan jumlah lantai terbanyak (> 80 lantai)

-- Sebelum Indexing
EXPLAIN ANALYZE 
SELECT name, floors, function 
FROM buildings 
WHERE floors >= 80 
ORDER BY floors DESC;

--  Index pada floors
CREATE INDEX IF NOT EXISTS idx_buildings_floors ON buildings(floors DESC);

-- Sesudah Indexing
EXPLAIN ANALYZE 
SELECT name, floors, function 
FROM buildings 
WHERE floors >= 80 
ORDER BY floors DESC;