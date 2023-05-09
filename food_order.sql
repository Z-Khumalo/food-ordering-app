 --DROP DATABASE IF EXISTS FOOD_ORDERING_DB


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
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (6,'Chicken Noodles','10.00','Noodles');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (7,'Rumali Chicken Shawarma','70.00','Chicken meat');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (8,'Butter Chicken','40.00','Chicken meat');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (9,'Classic Paneer Pizza','200.00','Pizzas');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (10,'Smoky BBQ Pizza','200.00','Pizzas');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (11,'Coffee','20.00','Hot beverages');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (12,'Espresso','30.00','Hot beverages');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (13,'Tea','15.00','Hot beverages');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (14,'Chocolate Milkshake','15.00','Milkshakes');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (15,'Strawberry Milkshake','17.00','Milkshakes');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (16,'Blueberry Milkshake','17.00','Milkshakes');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (17,'Salted Caramel and Chocolate Chip Milkshake','29.00','Milkshakes');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (18,'Chai Tea Latte Milkshake','27.00','Milkshakes');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (19,'Oreo Milkshake.','30.00','Milkshakes');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (20,'Peppermint Bark Milkshake','23.00','Milkshakes');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (21,'Chocolate Peanut Butter Banana Shake.','26.00','Milkshakes');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (23,'Chicken breast','100.00','Chicken_meat');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (24,'Chicken drumsticks','90.00','Chicken_meat');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (25,'Pork Steak','120.00','Pork_meat');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (26,'Pork Ribs','150.00','Pork_meat');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (27,'Pork Tenderloin','190.00','Pork_meat');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (28,'Pork Shoulder','250.00','Pork_meat');
--INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
--VALUES (28,'Pork Shoulder','250.00','Pork_meat');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (29,'Fish and chips','110.00','Meals');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (30,'chicken and chips','130.00','Meals');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (31,'Pap and chicken','45.00','Meals');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (32,'Pap and Beef','50.00','Meals');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (33,'Pap and cow heels','60.00','Meals');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (34,'Pap and mogodu','65.00','Meals');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (35,'Chips and Ribs','115.00','Meals');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (36,'Rice and chicken','55.00','Meals');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (37,'Rice and beef','40.00','Meals');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (38,'Rice and fried chicken','65.00','Meals');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (39,'Caribbean cow heel soup','10.00','Soup');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (40,'Spiced carrot & lentil soup','15.00','Soup');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (41,'Pumpkin soup ','14.00','Soup');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (42,'Jewish chicken soup ','17.00','Soup');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (43,'Miso & butternut soup','16.00','Soup');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (44,'Creamy cauliflower soup','18.00','Soup');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (45,'Mushroom soup','19.00','Soup');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (46,'sprite','19.00','Drinks');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (47,'Fanta Orange','19.00','Drinks');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (48,'Fanta grape','19.00','Drinks');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (49,'Juice','19.00','Drinks');
INSERT INTO Menu (Item_id ,Item_name,Item_price,Item_category)
VALUES (50,'Water','10.00','Drinks');






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
--SELECT * from Administrator;