DROP TABLE IF EXISTS Final_Orders;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS Administrator;
DROP SEQUENCE IF EXISTS SQ_OrderID;



CREATE SEQUENCE SQ_OrderID
START WITH 1
INCREMENT BY 1
NO CYCLE;

CREATE TABLE Menu (
  Item_id INT PRIMARY KEY, 
  Item_name VARCHAR(50) NOT NULL,
  Item_price DECIMAL(10,2) NOT NULL,
  Item_category VARCHAR(50) NOT NULL
);

CREATE TABLE Administrator (
  Admin_id INT NOT NULL PRIMARY KEY, 
  Admin_name VARCHAR(50) NOT NULL,
  Admin_password VARCHAR(50) NOT NULL
);

CREATE TABLE Orders (
  Order_id INT NOT NULL,
  Order_quantity INT NOT NULL,
  Order_date DATE,
  Order_Total DECIMAL(10,2),
  Item_id INT NOT NULL,
  Admin_id INT NOT NULL,
  PRIMARY KEY (Order_id),
  CONSTRAINT Item_id FOREIGN KEY (Item_id) REFERENCES Menu(Item_id),
  CONSTRAINT Admin_id FOREIGN KEY (Admin_id) REFERENCES Administrator (Admin_id)
);



INSERT INTO Menu (Item_id, Item_name, Item_price, Item_category)
VALUES
  (1, 'Twist', 50.00, 'Burgers'),
  (2, 'chicken_legs', 20.00, 'Chicken_meat'),
  (3, 'Mediterranean Pizza', 200.00, 'Pizzas'),
  (4, 'McChicken Burger', 50.00, 'Burgers'),
  (5, 'Coke', 15.00, 'Drinks'),
  (6, 'Chicken Noodles', 10.00, 'Noodles'),
  (7, 'Rumali Chicken Shawarma', 70.00, 'Chicken meat'),
  (8, 'Butter Chicken', 40.00, 'Chicken meat'),
  (9, 'Classic Paneer Pizza', 200.00, 'Pizzas'),
  (10, 'Smoky BBQ Pizza', 200.00, 'Pizzas'),
  (11, 'Coffee', 20.00, 'Hot beverages'),
  (12, 'Espresso', 30.00, 'Hot beverages'),
  (13, 'Tea', 15.00, 'Hot beverages'),
  (14, 'Chocolate Milkshake', 15.00, 'Milkshakes'),
  (15, 'Strawberry Milkshake', 17.00, 'Milkshakes'),
  (16, 'Blueberry Milkshake', 17.00, 'Milkshakes'),
  (17, 'Salted Caramel and Chocolate Chip Milkshake', 29.00, 'Milkshakes'),
  (18, 'Chai Tea Latte Milkshake', 27.00, 'Milkshakes'),
  (19, 'Oreo Milkshake.', 30.00, 'Milkshakes'),
  (20, 'Peppermint Bark Milkshake', 23.00, 'Milkshakes'),
  (21, 'Chocolate Peanut Butter Banana Shake.', 26.00, 'Milkshakes'),
  (22, 'Wings', 80.00, 'Chicken_meat'),
  (23, 'Chicken breast', 100.00, 'Chicken_meat'),
  (24, 'Chicken drumsticks', 90.00, 'Chicken_meat'),
  (25, 'Pork Steak', 120.00, 'Pork_meat'),
  (26, 'Pork Ribs', 150.00, 'Pork_meat'),
  (27, 'Pork Tenderloin', 190.00, 'Pork_meat'),
  (28, 'Pork Shoulder', 250.00, 'Pork_meat'),
  (29, 'Fish and chips', 110.00, 'Meals'),
  (30, 'chicken and chips', 130.00, 'Meals'),
  (31, 'Pap and chicken', 45.00, 'Meals'),
  (32, 'Pap and Beef', 50.00, 'Meals'),
  (33, 'Pap and cow heels', 60.00, 'Meals'),
  (34, 'Pap and mogodu', 65.00, 'Meals'),
  (35, 'Chips and Ribs', 115.00, 'Meals'),
  (36, 'Rice and chicken', 55.00, 'Meals'),
  (37, 'Rice and beef', 40.00, 'Meals'),
  (38, 'Rice and fried chicken', 65.00, 'Meals'),
  (39, 'Caribbean cow heel soup', 10.00, 'Soup'),
  (40, 'Spiced carrot & lentil soup', 15.00, 'Soup'),
  (41, 'Pumpkin soup', 14.00, 'Soup'),
  (42, 'Jewish chicken soup', 17.00, 'Soup'),
  (43, 'Miso & butternut soup', 16.00, 'Soup'),
  (44, 'Creamy cauliflower soup', 18.00, 'Soup'),
  (45, 'Mushroom soup', 19.00, 'Soup'),
  (46, 'sprite', 19.00, 'Drinks'),
  (47, 'Fanta Orange', 19.00, 'Drinks'),
  (48, 'Fanta grape', 19.00, 'Drinks'),
  (49, 'Juice', 19.00, 'Drinks'),
  (50, 'Water', 10.00, 'Drinks');

INSERT INTO Administrator (Admin_id, Admin_name, Admin_password)
VALUES
  (1029, 'Sibongile', '12345'),
  (1051, 'Malebo', '678910'),
  (1031, 'Zandile', '246810'),
  (1041, 'Zweli', '12346'),
  (1022, 'Ntsako', '12348');

ALTER TABLE Orders ADD PRIMARY KEY (Order_id);
ALTER TABLE Orders ALTER COLUMN Order_id SET DEFAULT nextval('SQ_OrderID');


CREATE TABLE Final_Orders AS
SELECT Menu.Item_id, Menu.Item_name, Menu.Item_price, Menu.Item_category,
       Orders.Order_id, Orders.Order_quantity, Orders.Order_date, Orders.Order_Total, Administrator.Admin_name
FROM Menu
INNER JOIN Orders ON Menu.Item_id = Orders.Item_id
LEFT JOIN Administrator ON Orders.Admin_id = Administrator.Admin_id;


SELECT * FROM Menu;
SELECT * FROM Administrator;
SELECT * FROM Orders;
DROP TABLE Menu_Orders;

