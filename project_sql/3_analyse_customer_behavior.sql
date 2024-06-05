/*
Looking at the orders table, we see that each item ordered by a customer is recorded by each row. The customer is identified by order_id, along with a timestamp and date for each order. 
*/

/*
Question one: 
Combine the menu_items and order_details tables into a single table
*/
SELECT *
FROM restaurant_db.order_details
LEFT JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id;

/*
To combine the order_details table with the menu_items table, we should use a LEFT JOIN instead of an INNER JOIN. This ensures that all records from the order_details table are included, even if there are no matching records in the menu_items table.

A LEFT JOIN retrieves all records from the left table (in this case, order_details) and the matched records from the right table (menu_items). If there is no match, NULL values are returned for columns from the right table.

Use Case for LEFT JOIN
Use a LEFT JOIN when you want to get all records from the left table, regardless of whether there is a matching record in the right table. This is useful when you need a complete set of records from one table, along with any matching records from the second table.

Summary
INNER JOIN: Use when you need only the records with matches in both tables.
LEFT JOIN: Use when you need all records from the left table and the matched records from the right table, including rows from the left table with no match in the right table.
*/

/*
Question two: 
What were the least and most ordered items? 
What categories were they in?
*/
SELECT item_name, category, COUNT(order_details_id) AS number_purchases
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY item_name, category
ORDER BY number_purchases ASC
LIMIT 1;

SELECT item_name, category, COUNT(order_details_id) AS number_purchases
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY item_name, category
ORDER BY number_purchases DESC
LIMIT 1;

/*
To identify the least and most ordered items, we use the GROUP BY statement on item_name and category, and count the frequency of each order using the count function on order_details_id.

From the results, we see that Chicken Tacos (Mexican category) is the least ordered item with 123 orders in the past three months. Conversely, Hamburgers (American category) are the most ordered item with 622 orders.   
*/

/*
Question three: 
What were the top 5 orders that spent the most money?
*/
SELECT order_id, SUM(price) AS total_spend
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY order_id
ORDER BY sum(price) DESC
LIMIT 5;

/*
To identify the top 5 highest spending orders, we use the GROUP BY statement on order_id and apply the SUM function on the price to calculate the total amount spent for each order.

From the results, we find that orders 440, 2075, 1957, 330, and 2675 are the highest paying orders.
*/

/*
Question four: 
View the details of the highest spend order. Which specific items were purchased?
*/
SELECT category, COUNT(item_id) AS num_items
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
WHERE order_id = 440
GROUP BY category;

/*
From the previous analysis, we identified the top 5 highest spending orders, with order 440 at the top. To examine the details of order 440, we use it as a filter. We then apply the GROUP BY statement on order_id and use the COUNT function on item_id to determine the specific items purchased.

The results show that order 440 included 8 Italian items, and 2 items each from the American, Asian, and Mexican categories.  
*/

/*
Question 5:
View the details of the top 5 highest spend orders
*/
SELECT order_id,category, COUNT(item_id) AS num_items
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
WHERE order_id IN (440,2075,1957,330,2675)
GROUP BY order_id,category;

/*
From the previous analysis, we identified the top 5 highest spending orders: 440, 2075, 1957, 330, and 2675. This query provides detailed information on their spending.
*/

SELECT EXTRACT(MONTH FROM order_date) AS month, SUM(price) AS total_sales
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY month
ORDER BY total_sales DESC;

SELECT order_time, SUM(price) AS total_sales
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY order_time
ORDER BY total_sales DESC
LIMIT 10;
