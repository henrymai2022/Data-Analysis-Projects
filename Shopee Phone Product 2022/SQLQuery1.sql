USE ShopeePhone
GO
---CHECK SOURCE TABLE---
SELECT * FROM DATA$
SELECT * FROM ID$
SELECT * FROM RATING$

--- CHECK DATA TYPE
EXEC sp_help DATA$


---CHECK COLUMN---
SELECT brand FROM DATA$

---REMOVE NULL
SELECT *
FROM DATA$

UPDATE DATA$
SET brand = 'NO BRAND'
WHERE brand IS NULL

UPDATE DATA$
SET discount = '0%'
WHERE discount IS NULL

UPDATE RATING$
SET comment = 'No comment'
WHERE comment IS NULL

---UPPER CASE
UPDATE DATA$
SET brand = UPPER(brand)

----TAO STORE PROCEDUE---
GO
CREATE OR ALTER PROCEDURE sp_upper
AS
	SELECT item_id, shop_id , UPPER(brand) AS Brand, sold_quantity,stock,discount_price,original_price,discount,liked_count,rating_star,number_of_ratings
	FROM DATA$

----TAO TABLE UPPER
DROP TABLE uppertable
GO
CREATE TABLE uppertable(item_id FLOAT PRIMARY KEY,
					   shop_id FLOAT NOT NULL,
					   Brand NVARCHAR(25),
					   sold_quantity FLOAT,
					   stock FLOAT,
					   discount_price NVARCHAR(25),
					   original_price FLOAT,
					   discount FLOAT,
					   liked_count FLOAT,
					   rating_star FLOAT,
					   number_of_ratings FLOAT
					   )
--- THUC HIEN
INSERT INTO uppertable
EXEC sp_upper

---- FINAL STEP
SELECT DISTINCT DATA$.item_id, ID$.shop_id , UPPER(brand) AS Brand, sold_quantity,stock,discount_price,original_price,discount,liked_count,ROUND(rating_star,2,0) AS rating_star, number_of_ratings,name
FROM DATA$ INNER JOIN ID$ ON DATA$.item_id = ID$.item_id
WHERE original_price IS NOT NULL AND name LIKE N'%điện%'

SELECT DISTINCT ID$.item_id,brand, name 
FROM ID$ INNER JOIN DATA$ ON ID$.item_id = DATA$.item_id
WHERE name LIKE N'%điện%'

SELECT DISTINCT * FROM RATING$