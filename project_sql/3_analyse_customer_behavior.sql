/*
Question one: 
Combine the menu_items and order_details tables into a single table
*/

SELECT *
FROM restaurant_db.order_details
LEFT JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id;

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
Question three: 
What were the top 5 orders that spent the most money?
*/
SELECT item_name, category, price, COUNT(order_id) 
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY item_name, price, category
ORDER BY price DESC
LIMIT 5;

/*
Question four: 
View the details of the highest spend order. Which specific items were purchased?
*/



/*
Question 5:
View the details of the top 5 highest spend orders
*/
