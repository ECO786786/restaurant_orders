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
ORDER BY number_purchases ASC;

SELECT item_name, category, COUNT(order_details_id) AS number_purchases
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY item_name, category
ORDER BY number_purchases DESC;

/*
As each item ordered by a customer is recorded by each row, we need to group by item_name to count the freqency of each order by using the count function of the order_details_id.From this we are able to find the most and the least items on the list. From the     
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
Question 5:
View the details of the top 5 highest spend orders
*/
SELECT order_id,category, COUNT(item_id) AS num_items
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
WHERE order_id IN (440,2075,1957,330,2675)
GROUP BY order_id,category;
