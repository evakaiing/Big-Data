\c lab1_db;

TRUNCATE TABLE
    fact_sales,
    dim_products,
    dim_sellers,
    dim_customers,
    dim_stores,
    dim_brands,
    dim_suppliers
RESTART IDENTITY CASCADE;

INSERT INTO dim_suppliers (name, contact, email, phone, address, city, country)
SELECT DISTINCT supplier_name, supplier_contact, supplier_email, supplier_phone, supplier_address, supplier_city, supplier_country
FROM mock_data WHERE supplier_name IS NOT NULL
ON CONFLICT DO NOTHING;

INSERT INTO dim_brands (name)
SELECT DISTINCT product_brand
FROM mock_data
WHERE product_brand IS NOT NULL
ON CONFLICT DO NOTHING;

INSERT INTO dim_stores (name, location, city, state, country, phone, email)
SELECT DISTINCT store_name, store_location, store_city, store_state, store_country, store_phone, store_email
FROM mock_data
WHERE store_name IS NOT NULL
ON CONFLICT DO NOTHING;

INSERT INTO dim_customers (customer_id, first_name, last_name, age, email, country, postal_code, pet_type, pet_name, pet_breed)
SELECT DISTINCT sale_customer_id, customer_first_name, customer_last_name, customer_age, customer_email, customer_country, customer_postal_code, customer_pet_type, customer_pet_name, customer_pet_breed
FROM mock_data
WHERE sale_customer_id IS NOT NULL
ON CONFLICT (customer_id) DO NOTHING;

INSERT INTO dim_sellers (seller_id, first_name, last_name, email, country, postal_code)
SELECT DISTINCT sale_seller_id, seller_first_name, seller_last_name, seller_email, seller_country, seller_postal_code
FROM mock_data
WHERE sale_seller_id IS NOT NULL
ON CONFLICT (seller_id) DO NOTHING;

INSERT INTO dim_products (product_id, name, category, price, weight, color, size, material, description, rating, supplier_id, brand_id)
SELECT DISTINCT
    m.sale_product_id,
    m.product_name,
    m.product_category,
    m.product_price,
    m.product_weight,
    m.product_color,
    m.product_size,
    m.product_material,
    m.product_description,
    m.product_rating,
    s.supplier_id,
    b.brand_id
FROM mock_data m
LEFT JOIN dim_suppliers s ON m.supplier_name = s.name
LEFT JOIN dim_brands b ON m.product_brand = b.name
WHERE m.sale_product_id IS NOT NULL
ON CONFLICT (product_id) DO NOTHING;

INSERT INTO fact_sales (sale_id, sale_date, customer_id, seller_id, product_id, store_id, quantity, total_price)
SELECT DISTINCT
    m.id,
    m.sale_date,
    m.sale_customer_id,
    m.sale_seller_id,
    m.sale_product_id,
    st.store_id,
    m.sale_quantity,
    m.sale_total_price
FROM mock_data m
LEFT JOIN dim_stores st ON m.store_name = st.name
WHERE m.id IS NOT NULL
ON CONFLICT (sale_id) DO NOTHING;