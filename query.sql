DROP DATABASE IF EXISTS demo;
CREATE DATABASE demo;
USE demo;

DROP TABLE IF EXISTS products;
CREATE TABLE products
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    code        VARCHAR(10),
    name        VARCHAR(50),
    price       DOUBLE,
    amount      INT,
    description LONGTEXT,
    status      BOOLEAN DEFAULT TRUE
);

INSERT INTO products(code, name, price, amount, description, status)
VALUES ('AB1', 'Iphone6', 2000, 50, 'This is iphone 6', TRUE);
INSERT INTO products(code, name, price, amount, description, status)
VALUES ('CD2', 'Iphone7', 3000, 60, 'This is iphone 7', FALSE);
INSERT INTO products(code, name, price, amount, description)
VALUES ('EF3', 'Iphone8', 4000, 70, 'This is iphone 8');
INSERT INTO products(code, name, price, amount, description)
VALUES ('GH4', 'Iphone9', 5000, 80, 'This is iphone 9');
INSERT INTO products(code, name, price, amount, description)
VALUES ('IK5', 'IphoneX', 6000, 80, 'This is iphone X');

-- Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
EXPLAIN
SELECT *
FROM products
WHERE code = 'EF3';

ALTER TABLE products
    ADD UNIQUE INDEX idx_code (code),
    ADD INDEX idx_name_price (name, price);

-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
CREATE VIEW v_product_detail AS
SELECT code, name, price, status
FROM products;

-- Tiến hành sửa đổi view
CREATE OR REPLACE VIEW v_product_detail AS
SELECT code, name, price, amount, status
FROM products;

-- Tiến hành xoá view
DROP VIEW v_product_detail;

-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
DELIMITER //
CREATE PROCEDURE getAll()
BEGIN
    SELECT * FROM products;
END;
//
DELIMITER ;

-- Tạo store procedure thêm một sản phẩm mới
DELIMITER //
CREATE PROCEDURE addProduct(
    IN code VARCHAR(10),
    IN name VARCHAR(50),
    IN price DOUBLE,
    IN amount INT,
    IN description LONGTEXT
)
BEGIN
    INSERT INTO products (code, name, price, amount, description)
    VALUES (code, name, price, amount, description);
END;
//
DELIMITER ;

-- Tạo store procedure sửa thông tin sản phẩm theo id
DELIMITER //
CREATE PROCEDURE updateProduct(
    IN p_code VARCHAR(10),
    IN p_name VARCHAR(50),
    IN p_price DOUBLE,
    IN p_amount INT,
    IN p_description LONGTEXT,
    IN p_id INT
)
BEGIN
    UPDATE products
    SET code        = p_code,
        name        = p_name,
        price       = p_price,
        amount      = p_amount,
        description = p_description
    WHERE id = p_id;
END;
//
DELIMITER ;

-- Tạo store procedure xoá sản phẩm theo id
DELIMITER //
CREATE PROCEDURE deleteProduct(
    IN p_id INT
)
BEGIN
    DELETE
    FROM products
    WHERE id = p_id;
END;
//
DELIMITER ;

-- Chạy procedure
CALL getAll();
CALL addProduct('ML6', 'Galaxy S', 9000, 90, 'This is Samsung Galaxy');
CALL updateProduct('ML7', 'Galaxy XS', 9000, 90, 'This is Samsung Galaxy XS', 6);
CALL deleteProduct(6);
