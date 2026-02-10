-- ============================================
-- Упрощенная версия без комментариев COMMENT ON
-- Используйте эту версию, если основная не работает
-- ============================================

-- Удаляем таблицы, если они уже существуют
DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS products CASCADE;
COMMIT;

-- Создание таблицы products
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    brand VARCHAR(100),
    purchase_price NUMERIC(10, 2),
    current_price NUMERIC(10, 2),
    stock INTEGER DEFAULT 0
);
COMMIT;

-- Создание таблицы sales
CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    sale_date DATE NOT NULL,
    product_id INTEGER NOT NULL REFERENCES products(product_id) ON DELETE RESTRICT,
    quantity INTEGER NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    status VARCHAR(50),
    city VARCHAR(100),
    customer_id INTEGER
);
COMMIT;
