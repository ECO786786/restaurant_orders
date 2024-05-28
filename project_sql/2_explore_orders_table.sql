/*
Question one: 
View the order_details table. What is the date range of the table?
*/

SELECT *
FROM restaurant_db.order_details;

SELECT MIN(order_date) AS first_order, MAX(order_date) AS last_order
FROM restaurant_db.order_details;

/*
To determine the date range of the orders, we find the minimum and maximum order dates. The earliest order date is January 1, 2023, and the latest order date is March 31, 2023.
*/

/*
Question two:
How many orders were made within this date range? How many items were ordered within this date range?
*/

-- How many orders were made within this date range?

SELECT COUNT(*) AS how_many_orders
FROM restaurant_db.order_details;

/*
To determine the number of orders made within this date range, we count all transactions represented by the rows in the dataset. This total comes to 12,234 orders. 
*/

-- How many items were ordered within this date range?
SELECT COUNT(DISTINCT order_id) 
FROM restaurant_db.order_details;

/*
To find out how many items were ordered within this date range, we use a similar analysis to the previous one. However, instead of counting all rows, we count the distinct order IDs to get the number of individual items, which totals 5,370.
*/


/*
Question three:
Which orders had the most number of items?
*/

SELECT order_id, COUNT(item_id) AS num_items 
FROM restaurant_db.order_details
GROUP BY order_id
ORDER BY num_items DESC;

/*
To determine which orders contained the most items, we use the GROUP BY statement on order_id and the COUNT function on item_id to count the number of items per order. Sorting the results in descending order, we find that seven orders each had 14 items. The order IDs for these are 4305, 1957, 3473, 2675, 440, 330, and 443.   
*/

/*
Question four:
How many orders had more than 12 items?
*/

SELECT order_id, COUNT(item_id) AS num_items 
FROM restaurant_db.order_details
GROUP BY order_id
HAVING COUNT(item_id) > 12
ORDER BY num_items DESC;

/*
To find out how many orders had more than 12 items, we build on the previous analysis by adding a HAVING clause to filter the count of item_id to be greater than 12.
*/


