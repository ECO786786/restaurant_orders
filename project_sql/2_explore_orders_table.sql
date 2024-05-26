/*
Question one: 
View the order_details table. What is the date range of the table?
*/

SELECT *
FROM restaurant_db.order_details;

SELECT MIN(order_date) AS first_order, MAX(order_date) AS last_order
FROM restaurant_db.order_details;

/*
Question two:
How many orders were made within this date range? How many items were ordered within this date range?
*/

SELECT COUNT(*) AS how_many_orders
FROM restaurant_db.order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-03-31';

/*
Question three:
Which orders had the most number of items?
*/

SELECT order_id, COUNT(item_id) AS items 
FROM restaurant_db.order_details
GROUP BY order_id
ORDER BY order_id ASC;

/*
Question four:
How many orders had more than 12 items?
*/

SELECT order_id, COUNT(item_id) AS items 
FROM restaurant_db.order_details
GROUP BY order_id
HAVING COUNT(item_id) > 12
ORDER BY order_id ASC;



