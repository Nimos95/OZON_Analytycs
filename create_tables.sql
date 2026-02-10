-- ============================================
-- Создание таблиц products и sales в PostgreSQL
-- Оптимизировано для DBeaver
-- ============================================

-- Удаляем таблицы, если они уже существуют (в обратном порядке из-за внешних ключей)
-- CASCADE автоматически удаляет все зависимые объекты
DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS products CASCADE;

-- Явный коммит после удаления таблиц (для DBeaver)
COMMIT;

-- --------------------------------------------
-- 1. Таблица products (товары)
-- --------------------------------------------
CREATE TABLE products (
    -- Уникальный идентификатор товара, SERIAL = автоинкремент (1, 2, 3...)
    product_id SERIAL PRIMARY KEY,
    -- Название товара, строка переменной длины, обязательное поле
    product_name VARCHAR(255) NOT NULL,
    -- Категория товара
    category VARCHAR(100),
    -- Бренд
    brand VARCHAR(100),
    -- Закупочная цена (с копейками), NUMERIC точнее для денег чем FLOAT
    purchase_price NUMERIC(10, 2),
    -- Текущая цена продажи
    current_price NUMERIC(10, 2),
    -- Количество на складе, целое число
    stock INTEGER DEFAULT 0
);

-- Комментарии к таблице и столбцам
COMMENT ON TABLE products IS 'Справочник товаров';
COMMENT ON COLUMN products.product_id IS 'Уникальный ID товара (автоинкремент)';
COMMENT ON COLUMN products.product_name IS 'Название товара';
COMMENT ON COLUMN products.category IS 'Категория';
COMMENT ON COLUMN products.brand IS 'Бренд';
COMMENT ON COLUMN products.purchase_price IS 'Цена закупки';
COMMENT ON COLUMN products.current_price IS 'Текущая цена';
COMMENT ON COLUMN products.stock IS 'Остаток на складе';

-- Явный коммит после создания products (для DBeaver)
COMMIT;

-- --------------------------------------------
-- 2. Таблица sales (продажи)
-- --------------------------------------------
CREATE TABLE sales (
    -- Уникальный идентификатор продажи, SERIAL = автоинкремент (1, 2, 3...)
    sale_id SERIAL PRIMARY KEY,
    -- Дата продажи (только дата, без времени)
    -- Переименовано из 'date' (зарезервированное слово) в 'sale_date'
    sale_date DATE NOT NULL,
    -- ID товара — внешний ключ на products (связь «многие продажи — один товар»)
    -- ON DELETE RESTRICT предотвращает удаление товара, если есть продажи
    product_id INTEGER NOT NULL REFERENCES products(product_id) ON DELETE RESTRICT,
    -- Количество проданных единиц
    quantity INTEGER NOT NULL,
    -- Цена за единицу в момент продажи
    price NUMERIC(10, 2) NOT NULL,
    -- Статус заказа (например: 'completed', 'cancelled', 'pending')
    status VARCHAR(50),
    -- Город продажи
    city VARCHAR(100),
    -- ID покупателя (число для связи с будущей таблицей customers при необходимости)
    customer_id INTEGER
);

-- Комментарии к таблице и столбцам
COMMENT ON TABLE sales IS 'Таблица продаж';
COMMENT ON COLUMN sales.sale_id IS 'Уникальный ID продажи';
COMMENT ON COLUMN sales.sale_date IS 'Дата продажи';
COMMENT ON COLUMN sales.product_id IS 'Ссылка на товар в products';
COMMENT ON COLUMN sales.quantity IS 'Количество';
COMMENT ON COLUMN sales.price IS 'Цена за единицу';
COMMENT ON COLUMN sales.status IS 'Статус заказа';
COMMENT ON COLUMN sales.city IS 'Город';
COMMENT ON COLUMN sales.customer_id IS 'ID покупателя';

-- Финальный коммит после создания sales
COMMIT;

-- Проверка создания таблиц (выполните этот запрос отдельно для проверки)
-- SELECT table_name 
-- FROM information_schema.tables 
-- WHERE table_schema = 'public' 
-- AND table_name IN ('products', 'sales');
