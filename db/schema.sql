CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY, name TEXT NOT NULL DEFAULT 'Administrador', email TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL, role TEXT NOT NULL DEFAULT 'admin', created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS categories (
  id SERIAL PRIMARY KEY, name TEXT UNIQUE NOT NULL, slug TEXT UNIQUE NOT NULL, image_url TEXT, sort_order INT DEFAULT 0
);
CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY, sku TEXT UNIQUE, name TEXT NOT NULL, slug TEXT UNIQUE NOT NULL,
  category_id INT REFERENCES categories(id) ON DELETE SET NULL, brand TEXT DEFAULT 'Fossil', description TEXT,
  material TEXT, price NUMERIC(12,2) NOT NULL DEFAULT 0, compare_at_price NUMERIC(12,2), stock INT NOT NULL DEFAULT 0,
  sizes TEXT[] DEFAULT '{}', featured BOOLEAN DEFAULT FALSE, active BOOLEAN DEFAULT TRUE, created_at TIMESTAMPTZ DEFAULT NOW(), updated_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS product_images (
  id SERIAL PRIMARY KEY, product_id INT NOT NULL REFERENCES products(id) ON DELETE CASCADE, url TEXT NOT NULL, public_id TEXT, position INT DEFAULT 0, created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS inventory_movements (
  id SERIAL PRIMARY KEY, product_id INT NOT NULL REFERENCES products(id) ON DELETE CASCADE, type TEXT NOT NULL CHECK(type IN ('IN','OUT','ADJUSTMENT','SALE','RETURN')),
  quantity INT NOT NULL, note TEXT, created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS orders (
  id SERIAL PRIMARY KEY, customer_name TEXT, customer_phone TEXT, customer_email TEXT, status TEXT DEFAULT 'PENDING', total NUMERIC(12,2) NOT NULL DEFAULT 0, source TEXT DEFAULT 'web', created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS order_items (
  id SERIAL PRIMARY KEY, order_id INT REFERENCES orders(id) ON DELETE CASCADE, product_id INT REFERENCES products(id) ON DELETE SET NULL,
  product_name TEXT NOT NULL, quantity INT NOT NULL, unit_price NUMERIC(12,2) NOT NULL, size TEXT
);
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category_id);
CREATE INDEX IF NOT EXISTS idx_products_active ON products(active);
CREATE INDEX IF NOT EXISTS idx_inventory_product ON inventory_movements(product_id);
