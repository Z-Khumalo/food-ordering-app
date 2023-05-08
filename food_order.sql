-- DROP DATABASE IF EXISTS FOOD_ORDERING_DB


--CREATE DATABASE FOOD_ORDERING_DB;



--DROP TABLE IF EXISTS Menu;
--DROP TABLE IF EXISTS Administrator;
--DROP TABLE IF EXISTS Orders;


--CREATE TABLE Menu
--(Item_id  INT PRIMARY KEY, 
--Item_name VARCHAR(50) NOT NULL,
--Item_price Decimal(10,2) NOT NULL,
--Item_category VARCHAR(50) NOT NULL
--);

--CREATE TABLE Administrator 
--(Admin_id serial NOT NULL PRIMARY KEY , 
--Admin_user_name VARCHAR(50) NOT NULL,
--Admin_password VARCHAR(50) NOT NULL,
--UNIQUE(Admin_user_name)
--);

--CREATE TABLE Orders
--(Order_id INT PRIMARY KEY, 
--Order_quantity VARCHAR(50) NOT NULL,
--Order_date VARCHAR(50) NOT NULL,
--Order_total VARCHAR(50) NOT NULL,
--Item_id INT NOT NULL,
--Admin_id INT  NOT NULL,
--CONSTRAINT Item_id FOREIGN KEY(Item_id) REFERENCES Menu(Item_id),
--CONSTRAINT Admin_id FOREIGN KEY (Admin_id) REFERENCES Administrator (Admin_id)
--);
--DROP TABLE Menu;
--DROP TABLE Administrator;
--DROP TABLE Orders;

--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (1,'Twist','50.00','Burgers');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (2,'chicken_legs','20.00','Chicken_meat');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (3,'editerranean Pizza','200.00','Pizzas');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (4,'McChicken Burger','50.00','Burgers');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (5,'Coke','15.00','Drinks');

--INSERT INTO Administrator(Admin_id ,Admin_user_name ,Admin_password)
--VALUES (1029,'Sibongile','12345');
--INSERT INTO Administrator(Admin_id ,Admin_user_name ,Admin_password)
--VALUES (1051,'Malebo','678910');
--INSERT INTO Administrator(Admin_id ,Admin_user_name ,Admin_password)
--VALUES (1031,'Zandile','246810');
--INSERT INTO Administrator(Admin_id ,Admin_user_name ,Admin_password)
--VALUES (1041,'Zweli','12346');
--INSERT INTO Administrator(Admin_id ,Admin_user_name ,Admin_password)
--VALUES (1022,'Ntsako','12348');

SELECT * from Menu;
SELECT * from Administrator;