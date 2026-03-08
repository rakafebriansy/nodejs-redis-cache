-- ==========================================================
-- 1. INSERT DATA PARENT CATEGORIES (10 Kategori Utama)
-- ==========================================================
INSERT INTO categories (id, name, parent_id) VALUES
('CAT-01', 'Kopi (Coffee)', NULL),
('CAT-02', 'Teh (Tea)', NULL),
('CAT-03', 'Minuman Susu (Milk-Based)', NULL),
('CAT-04', 'Frappe & Blended', NULL),
('CAT-05', 'Mocktail & Minuman Segar', NULL),
('CAT-06', 'Pastry & Roti', NULL),
('CAT-07', 'Makanan Utama (Main Course)', NULL),
('CAT-08', 'Camilan (Snacks)', NULL),
('CAT-09', 'Ekstra & Topping', NULL),
('CAT-10', 'Merchandise', NULL);

-- ==========================================================
-- 2. INSERT DATA CHILD CATEGORIES (100 Sub-kategori)
-- ==========================================================

-- Kategori 1: Kopi (Coffee)
INSERT INTO categories (id, name, parent_id) VALUES
('CAT-01-01', 'Espresso', 'CAT-01'),
('CAT-01-02', 'Americano / Long Black', 'CAT-01'),
('CAT-01-03', 'Cafe Latte', 'CAT-01'),
('CAT-01-04', 'Cappuccino', 'CAT-01'),
('CAT-01-05', 'Mochaccino', 'CAT-01'),
('CAT-01-06', 'Caramel Macchiato', 'CAT-01'),
('CAT-01-07', 'Flat White', 'CAT-01'),
('CAT-01-08', 'Piccolo', 'CAT-01'),
('CAT-01-09', 'Affogato', 'CAT-01'),
('CAT-01-10', 'Cold Brew', 'CAT-01');

-- Kategori 2: Teh (Tea)
INSERT INTO categories (id, name, parent_id) VALUES
('CAT-02-01', 'English Breakfast Tea', 'CAT-02'),
('CAT-02-02', 'Earl Grey Tea', 'CAT-02'),
('CAT-02-03', 'Jasmine Green Tea', 'CAT-02'),
('CAT-02-04', 'Chamomile Tea', 'CAT-02'),
('CAT-02-05', 'Peppermint Tea', 'CAT-02'),
('CAT-02-06', 'Matcha Latte', 'CAT-02'),
('CAT-02-07', 'Thai Tea', 'CAT-02'),
('CAT-02-08', 'Lemon Tea', 'CAT-02'),
('CAT-02-09', 'Lychee Tea', 'CAT-02'),
('CAT-02-10', 'Peach Tea', 'CAT-02');

-- Kategori 3: Minuman Susu (Milk-Based)
INSERT INTO categories (id, name, parent_id) VALUES
('CAT-03-01', 'Classic Chocolate', 'CAT-03'),
('CAT-03-02', 'Red Velvet Latte', 'CAT-03'),
('CAT-03-03', 'Taro Latte', 'CAT-03'),
('CAT-03-04', 'Charcoal Latte', 'CAT-03'),
('CAT-03-05', 'Vanilla Milk', 'CAT-03'),
('CAT-03-06', 'Strawberry Milk', 'CAT-03'),
('CAT-03-07', 'Banana Milk', 'CAT-03'),
('CAT-03-08', 'Hazelnut Milk', 'CAT-03'),
('CAT-03-09', 'Caramel Milk', 'CAT-03'),
('CAT-03-10', 'Macadamia Milk', 'CAT-03');

-- Kategori 4: Frappe & Blended
INSERT INTO categories (id, name, parent_id) VALUES
('CAT-04-01', 'Java Chip Frappe', 'CAT-04'),
('CAT-04-02', 'Vanilla Cream Frappe', 'CAT-04'),
('CAT-04-03', 'Caramel Coffee Frappe', 'CAT-04'),
('CAT-04-04', 'Matcha Cream Frappe', 'CAT-04'),
('CAT-04-05', 'Double Chocolate Frappe', 'CAT-04'),
('CAT-04-06', 'Taro Frappe', 'CAT-04'),
('CAT-04-07', 'Strawberry Cream Frappe', 'CAT-04'),
('CAT-04-08', 'Hazelnut Blended', 'CAT-04'),
('CAT-04-09', 'Oreo Cookies & Cream', 'CAT-04'),
('CAT-04-10', 'Mocha Blended', 'CAT-04');

-- Kategori 5: Mocktail & Minuman Segar
INSERT INTO categories (id, name, parent_id) VALUES
('CAT-05-01', 'Virgin Mojito', 'CAT-05'),
('CAT-05-02', 'Sunrise Splash', 'CAT-05'),
('CAT-05-03', 'Ocean Blue', 'CAT-05'),
('CAT-05-04', 'Berry Smash', 'CAT-05'),
('CAT-05-05', 'Citrus Breeze', 'CAT-05'),
('CAT-05-06', 'Tropical Mango', 'CAT-05'),
('CAT-05-07', 'Cucumber Lemonade', 'CAT-05'),
('CAT-05-08', 'Pomegranate Fizz', 'CAT-05'),
('CAT-05-09', 'Apple Mint Splash', 'CAT-05'),
('CAT-05-10', 'Watermelon Sugar', 'CAT-05');

-- Kategori 6: Pastry & Roti
INSERT INTO categories (id, name, parent_id) VALUES
('CAT-06-01', 'Butter Croissant', 'CAT-06'),
('CAT-06-02', 'Almond Croissant', 'CAT-06'),
('CAT-06-03', 'Pain au Chocolat', 'CAT-06'),
('CAT-06-04', 'Cinnamon Roll', 'CAT-06'),
('CAT-06-05', 'Cheese Danish', 'CAT-06'),
('CAT-06-06', 'Blueberry Muffin', 'CAT-06'),
('CAT-06-07', 'Chocolate Chip Cookie', 'CAT-06'),
('CAT-06-08', 'Fudgy Brownie', 'CAT-06'),
('CAT-06-09', 'Banana Bread', 'CAT-06'),
('CAT-06-10', 'Lemon Pound Cake', 'CAT-06');

-- Kategori 7: Makanan Utama (Main Course)
INSERT INTO categories (id, name, parent_id) VALUES
('CAT-07-01', 'Nasi Goreng Spesial', 'CAT-07'),
('CAT-07-02', 'Mie Goreng Jawa', 'CAT-07'),
('CAT-07-03', 'Spaghetti Carbonara', 'CAT-07'),
('CAT-07-04', 'Spaghetti Bolognese', 'CAT-07'),
('CAT-07-05', 'Chicken Katsu Curry', 'CAT-07'),
('CAT-07-06', 'Rice Bowl Beef Teriyaki', 'CAT-07'),
('CAT-07-07', 'Rice Bowl Chicken Blackpepper', 'CAT-07'),
('CAT-07-08', 'Aglio Olio', 'CAT-07'),
('CAT-07-09', 'Nasi Ayam Geprek', 'CAT-07'),
('CAT-07-10', 'Nasi Gila', 'CAT-07');

-- Kategori 8: Camilan (Snacks)
INSERT INTO categories (id, name, parent_id) VALUES
('CAT-08-01', 'French Fries', 'CAT-08'),
('CAT-08-02', 'Potato Wedges', 'CAT-08'),
('CAT-08-03', 'Onion Rings', 'CAT-08'),
('CAT-08-04', 'Chicken Wings', 'CAT-08'),
('CAT-08-05', 'Calamari Rings', 'CAT-08'),
('CAT-08-06', 'Nachos dengan Saus Keju', 'CAT-08'),
('CAT-08-07', 'Singkong Goreng Keju', 'CAT-08'),
('CAT-08-08', 'Pisang Goreng Coklat Keju', 'CAT-08'),
('CAT-08-09', 'Tahu Cabai Garam', 'CAT-08'),
('CAT-08-10', 'Platter Mix', 'CAT-08');

-- Kategori 9: Ekstra & Topping
INSERT INTO categories (id, name, parent_id) VALUES
('CAT-09-01', 'Extra Espresso Shot', 'CAT-09'),
('CAT-09-02', 'Vanilla Syrup', 'CAT-09'),
('CAT-09-03', 'Caramel Syrup', 'CAT-09'),
('CAT-09-04', 'Hazelnut Syrup', 'CAT-09'),
('CAT-09-05', 'Upgrade Oat Milk', 'CAT-09'),
('CAT-09-06', 'Upgrade Almond Milk', 'CAT-09'),
('CAT-09-07', 'Whipped Cream', 'CAT-09'),
('CAT-09-08', 'Ice Cream Scoop (Vanilla/Coklat)', 'CAT-09'),
('CAT-09-09', 'Boba / Tapioca Pearls', 'CAT-09'),
('CAT-09-10', 'Cheese Foam', 'CAT-09');

-- Kategori 10: Merchandise
INSERT INTO categories (id, name, parent_id) VALUES
('CAT-10-01', 'Biji Kopi House Blend (250g)', 'CAT-10'),
('CAT-10-02', 'Tumbler Stainless Steel', 'CAT-10'),
('CAT-10-03', 'Mug Keramik Logo', 'CAT-10'),
('CAT-10-04', 'Tote Bag Kanvas', 'CAT-10'),
('CAT-10-05', 'T-Shirt Edisi Terbatas', 'CAT-10'),
('CAT-10-06', 'Topi Baseball', 'CAT-10'),
('CAT-10-07', 'Gantungan Kunci Kulit', 'CAT-10'),
('CAT-10-08', 'Pin / Enamel Badge', 'CAT-10'),
('CAT-10-09', 'Sticker Pack', 'CAT-10'),
('CAT-10-10', 'Sedotan Kaca Reusable', 'CAT-10');