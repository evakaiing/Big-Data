\c lab1_db;

CREATE TABLE dim_suppliers (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    contact VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    address VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE dim_brands (
    brand_id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE dim_stores (
    store_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    location VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    phone VARCHAR(50),
    email VARCHAR(255)
);

CREATE TABLE dim_customers (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    age INTEGER,
    email VARCHAR(255),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    pet_type VARCHAR(100),
    pet_name VARCHAR(100),
    pet_breed VARCHAR(100)
);

CREATE TABLE dim_sellers (
    seller_id INTEGER PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255),
    country VARCHAR(100),
    postal_code VARCHAR(20)
);

CREATE TABLE dim_products (
    product_id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    category VARCHAR(100),
    price NUMERIC(10,2),
    weight VARCHAR(50),
    color VARCHAR(50),
    size VARCHAR(50),
    material VARCHAR(100),
    description TEXT,
    rating NUMERIC(3,2),
    supplier_id INTEGER REFERENCES dim_suppliers(supplier_id),
    brand_id INTEGER REFERENCES dim_brands(brand_id)
);

CREATE TABLE fact_sales (
    sale_id INTEGER PRIMARY KEY,
    sale_date DATE,
    customer_id INTEGER REFERENCES dim_customers(customer_id),
    seller_id INTEGER REFERENCES dim_sellers(seller_id),
    product_id INTEGER REFERENCES dim_products(product_id),
    store_id INTEGER REFERENCES dim_stores(store_id),
    quantity INTEGER,
    total_price NUMERIC(10,2)
);