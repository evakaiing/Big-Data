\c lab2_db;

CREATE TABLE mock_data (
    id                   INTEGER,
    customer_first_name  VARCHAR(100),
    customer_last_name   VARCHAR(100),
    customer_age         INTEGER,
    customer_email       VARCHAR(255),
    customer_country     VARCHAR(100),
    customer_postal_code VARCHAR(20),
    customer_pet_type    VARCHAR(100),
    customer_pet_name    VARCHAR(100),
    customer_pet_breed   VARCHAR(100),
    seller_first_name    VARCHAR(100),
    seller_last_name     VARCHAR(100),
    seller_email         VARCHAR(255),
    seller_country       VARCHAR(100),
    seller_postal_code   VARCHAR(20),
    product_name         VARCHAR(255),
    product_category     VARCHAR(100),
    product_price        NUMERIC(10,2),
    product_quantity     INTEGER,
    sale_date            DATE,
    sale_customer_id     INTEGER,
    sale_seller_id       INTEGER,
    sale_product_id      INTEGER,
    sale_quantity        INTEGER,
    sale_total_price     NUMERIC(10,2),
    store_name           VARCHAR(255),
    store_location       VARCHAR(255),
    store_city           VARCHAR(100),
    store_state          VARCHAR(100),
    store_country        VARCHAR(100),
    store_phone          VARCHAR(50),
    store_email          VARCHAR(255),
    pet_category         VARCHAR(100),
    product_weight       VARCHAR(50),
    product_color        VARCHAR(50),
    product_size         VARCHAR(50),
    product_brand        VARCHAR(100),
    product_material     VARCHAR(100),
    product_description  TEXT,
    product_rating       NUMERIC(3,2),
    product_reviews      INTEGER,
    product_release_date DATE,
    product_expiry_date  DATE,
    supplier_name        VARCHAR(255),
    supplier_contact     VARCHAR(255),
    supplier_email       VARCHAR(255),
    supplier_phone       VARCHAR(50),
    supplier_address     VARCHAR(255),
    supplier_city        VARCHAR(100),
    supplier_country     VARCHAR(100)
);

COPY mock_data FROM '/data/MOCK_DATA (1).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (2).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (3).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (4).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (5).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (6).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (7).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (8).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA (9).csv' DELIMITER ',' CSV HEADER;
COPY mock_data FROM '/data/MOCK_DATA.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE IF NOT EXISTS dim_suppliers (
    supplier_id SERIAL PRIMARY KEY,
    name        VARCHAR(255) UNIQUE,
    contact     VARCHAR(255),
    email       VARCHAR(255),
    phone       VARCHAR(50),
    address     VARCHAR(255),
    city        VARCHAR(100),
    country     VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS dim_brands (
    brand_id SERIAL PRIMARY KEY,
    name     VARCHAR(100) UNIQUE
);

CREATE TABLE IF NOT EXISTS dim_stores (
    store_id SERIAL PRIMARY KEY,
    name     VARCHAR(255) UNIQUE,
    location VARCHAR(255),
    city     VARCHAR(100),
    state    VARCHAR(100),
    country  VARCHAR(100),
    phone    VARCHAR(50),
    email    VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS dim_customers (
    customer_id INTEGER PRIMARY KEY,
    first_name  VARCHAR(100),
    last_name   VARCHAR(100),
    age         INTEGER,
    email       VARCHAR(255),
    country     VARCHAR(100),
    postal_code VARCHAR(20),
    pet_type    VARCHAR(100),
    pet_name    VARCHAR(100),
    pet_breed   VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS dim_sellers (
    seller_id   INTEGER PRIMARY KEY,
    first_name  VARCHAR(100),
    last_name   VARCHAR(100),
    email       VARCHAR(255),
    country     VARCHAR(100),
    postal_code VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS dim_products (
    product_id  INTEGER PRIMARY KEY,
    name        VARCHAR(255),
    category    VARCHAR(100),
    price       NUMERIC(10,2),
    weight      VARCHAR(50),
    color       VARCHAR(50),
    size        VARCHAR(50),
    material    VARCHAR(100),
    description TEXT,
    rating      NUMERIC(3,2),
    supplier_id INTEGER REFERENCES dim_suppliers(supplier_id),
    brand_id    INTEGER REFERENCES dim_brands(brand_id)
);

CREATE TABLE IF NOT EXISTS fact_sales (
    sale_id     INTEGER PRIMARY KEY,
    sale_date   DATE,
    customer_id INTEGER REFERENCES dim_customers(customer_id),
    seller_id   INTEGER REFERENCES dim_sellers(seller_id),
    product_id  INTEGER REFERENCES dim_products(product_id),
    store_id    INTEGER REFERENCES dim_stores(store_id),
    quantity    INTEGER,
    total_price NUMERIC(10,2)
);