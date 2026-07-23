# Seleksi Tahap 2 Lab Basdat - ETL Project Data Scraping, Database Modeling, and Data Storing


## Author

* **Nama:** Tiara Clianta Andiwi
* **NIM:** 18224078

---

## Deskripsi Topik & DBMS

Proyek ini mencakup alur pengolahan data terintegrasi, mulai dari ekstraksi data gedung pencakar langit (*skyscrapers*) dari situs Skyscraper Center, pembersihan data (*data cleaning*), penyimpanan ke PostgreSQL RDBMS, pembuatan skema *Data Warehouse* (Star Schema), hingga optimasi query database.
Source: https://www.skyscrapercenter.com/buildings 

### Alasan Pemilihan Topik

Topik Skyscrapers dipilih karena memiliki keberagaman tipe data yang cukup komprehensif. Data ini mencakup atribut numerik kontinu (`height_m`, `height_ft`), numerik diskrit (`completion_year`, `floors`), atribut kategorikal (`material`, `function`), serta entitas relasional lokasi (`city`). Struktur data ini sangat ideal dalam konteks pemodelan basis data relasional (1:N) dan perancangan OLAP/Data Warehouse.

---

## Cara Menggunakan Scraper & Hasil Output

### 1. Instalasi Environment

Pastikan sudah menginstall Python 3 dan PostgreSQL. Kemudian jalankan kode ini untuk menyiapkan *virtual environment* dan menginstal dependensinya:

```bash
python3 -m venv venv
source venv/bin/activate
pip install bs4 psycopg2-binary

```
### 2. Penanganan Problem Cloudflare (Workaround)

Saat melakukan HTTP request langsung ke URL website (`[skyscrapercenter.com/buildings](https://skyscrapercenter.com/buildings)`), server target mengembalikan respons **HTTP 403 Forbidden** akibat proteksi Cloudflare WAF.

Solusi (*workaround*):

1. Halaman web diakses via browser dan diunduh (*Save As*) ke dalam format HTML (`.html`).
2. File tersebut disimpan ke folder `Data Scraping/src/`.
3. Skrip `scraper.py` dirancang untuk membaca file `.html` secara lokal (*offline parsing*) menggunakan `BeautifulSoup`, lalu melakukan ekstraksi pola teks (*regex*) untuk memisahkan kolom 

### 3. Menjalankan Scraper

Jalankan skrip ekstraksi data melalui terminal dengan kode:

```bash
python3 "Data Scraping/src/scraper.py"

```
### 4. Penggunaan Hasil Output

Hasil scraping akan menghasilkan dua file JSON di folder `Data Scraping/data/` (`cities.json` dan `buildings.json`). File ini digunakan oleh skrip `Data Storing/src/storing.py` untuk dimasukkan ke dalam basis data PostgreSQL `skyscrapers_db`.

---

## Struktur File JSON

### 1. `cities.json`

Menyimpan entitas kota untuk mencegah redundansi data (Normalisasi).

```json
[
    {
        "city_id": 1,
        "city_name": "Dubai"
    }
]

```

* `city_id`: Unique identifier setiap kota (Integer, Primary Key).
* `city_name`: Nama kota (String).

### 2. `buildings.json`

Menyimpan atribut detail dari setiap gedung pencakar langit (skyscraper)

```json
[
    {
        "building_id": 1,
        "name": "Burj Khalifa",
        "city_id": 1,
        "completion_year": 2010,
        "height_m": 828.0,
        "height_ft": 2717.0,
        "floors": 163,
        "function": "Office / Residential / Hotel",
        "material": "Steel / Concrete"
    }
]

```

* `building_id`: Unique identifier gedung (Integer, Primary Key).
* `name`: Nama lengkap gedung (String).
* `city_id`: Referensi ke entitas kota (Integer, Foreign Key ke `cities.json`).
* `completion_year`: Tahun gedung selesai dibangun (Integer).
* `height_m`: Tinggi gedung dalam satuan meter (Float).
* `height_ft`: Tinggi gedung dalam satuan feet (Float).
* `floors`: Jumlah lantai gedung (Integer).
* `function`: Peruntukan/fungsi penggunaan gedung (String).
* `material`: Bahan baku utama struktur gedung (String)

---

## ERD & Diagram Relasional RDBMS

### Entity Relationship Diagram (ERD)

### Struktur Tabel Relational Database

1. **Tabel `cities**`
* `city_id` (INT, Primary Key)
* `city_name` (VARCHAR(100), NOT NULL)


2. **Tabel `buildings**`
* `building_id` (INT, Primary Key)
* `name` (VARCHAR(255), NOT NULL)
* `city_id` (INT, Foreign Key references `cities(city_id)`)
* `completion_year` (INT)
* `height_m` (FLOAT)
* `height_ft` (FLOAT)
* `floors` (INT)
* `function` (VARCHAR(100))
* `material` (VARCHAR(100))


---

## Translasi ERD ke Diagram Relasional

1. **Pemetaan *Strong Entities*:**
Entitas `cities` dan `buildings` masing-masing ditranslasikan menjadi tabel terpisah (`cities` dan `buildings`)
2. **Pemetaan Relasi One-to-Many (1:N):**
Satu kota dapat memiliki banyak gedung (`1 city : N buildings`). Berdasarkan aturan kardenalitas relasional, Primary key dari sisi "One" (`cities.city_id`) dimasukkan sebagai **Foreign Key** ke dalam tabel sisi "Many" (`buildings.city_id`).
3. **Normalisasi (2NF):**
Atribut nama kota dipisahkan dari tabel gedung ke tabel `cities`. Hal ini dilakukan untuk menghilangkan *transitive dependency* dan redundansi penyimpanan string nama kota yang sama berulang kali.

![ERD](Data%20Storing/design/erd.png)

---

## Screenshot Jalannya Program

### 1. Eksekusi Storing Data ke PostgreSQL

Data JSON berhasil di-insert ke dalam RDBMS PostgreSQL:

![Select Buildings](Data%20Storing/screenshot/select.jpg)

### 2. Eksekusi Loading Data Warehouse (Star Schema)

Data berhasil ditransformasikan ke dalam Fact Table (`fact_buildings`) dan Dimension Tables:

![Data Warehouse Star Schema](Data%20Warehouse/screenshot/dw_select.jpg)

### 3. Query Optimization & Indexing

1) Filtering range height dan year. Penggunaan B-Tree Index (idx_buildings_height_year) mengubah pencarian dari Sequential Scan menjadi Index Scan.

![Optimisasi 1](Query%20Optimasi/optimasi1.jpg)

2) Aggregation JOIN City, penggunaan Index Foreign Key (idx_buildings_city_id) mempercepat operasi Hash Join dan Group Aggregate.

![Optimisasi 2](Query%20Optimasi/optimasi2.jpg)

3) Index idx_buildings_floors mempercepat pengurutan (sorting) data jumlah lantai terbesar tanpa melakukan Top-N Sort berbiaya tinggi.

![Optimisasi 3](Query%20Optimasi/optimasi3.jpg)

---

## Penggunaan AI 

### 1. Bagian yang Dibantu AI
* Eksplorasi pembuatan pola regex parsing pada skrip BeautifulSoup (scraper.py) untuk menangani pergeseran kolom HTML
* Penentuan library yang akan digunakan pada setiap tahap berbeda
* Troubleshooting error kode pada scraper.py, storing.py, dan load_dw.py
* Penyusunan konten README agar terstruktur (cara attach image, formatting, dll.)

### 2. Bagian yang Dikerjakan Mandiri
* Penentuan topik, solusi Cloudflare HTTP 403 Forbidden, dan pengambilan file HTML lokal
* Perancangan ERD, Relational Model, dan penetapan constraint database di postgreSQL
* Eksekusi akhir kode, debugging environment lokal Mac/PostgreSQL, verifikasi data, serta dokumentasi README.md

### 3. Refleksi Penggunaan AI
AI sangat bermanfaat sebagai alat bantu dalam mempercepat pemrograman. Namun, validasi manual tetap harus dilakukan karena hasil AI sempat menghasilkan beberapa error, kemudian disempurnakan dengan penyesuaian logika parsing secara mandiri.

---

## Referensi

* **Situs Web:** [The Skyscraper Center](https://www.skyscrapercenter.com/buildings) https://www.skyscrapercenter.com/buildings
* **Library Python:**
* `beautifulsoup4`(Parsing dokumen HTML)
* `psycopg2-binary`(Driver PostgreSQL adapter untuk python)
* `json`, `os`, `re`, `glob`(Modul bawaan Python untuk manipulasi file, direktori, dan regex parsing)

* **DBMS:** PostgreSQL 14+