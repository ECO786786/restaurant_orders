ALTER TABLE restaurant_db.order_details
ADD FOREIGN KEY (item_id) REFERENCES restaurant_db.menu_items(menu_item_id);

--  How do sales vary by month?

SELECT EXTRACT(MONTH FROM order_date) AS month, SUM(price) AS total_sales
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY month
ORDER BY total_sales DESC;

-- What times of day have the highest sales?
SELECT order_time, SUM(price) AS total_sales
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY order_time
ORDER BY total_sales DESC;

-- What is the average value of an order over a specific period?

SELECT EXTRACT(MONTH FROM order_date) AS month, ROUND(AVG(price),2) AS average_order
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY month
ORDER BY average_order DESC;

-- How often do customers place orders in a month? 
SELECT EXTRACT(MONTH FROM order_date) AS month, COUNT(*) AS how_many_orders
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY month
ORDER BY how_many_orders DESC;

-- Which menu items generate the most revenue?
SELECT item_name, category, COUNT(order_details_id) AS number_purchases, price * COUNT(order_details_id) AS revenue 
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY item_name, category, price
ORDER BY number_purchases ASC;

-- What are the top 10 best-selling menu items?
SELECT item_name, category, COUNT(order_details_id) AS number_purchases
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY item_name, category
ORDER BY number_purchases DESC
LIMIT 10;
 
---- 
SELECT EXTRACT(MONTH FROM order_date) AS month, AVG(price) AS total_sales
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY month
ORDER BY total_sales DESC;

WITH MonthlyPurchases AS (
    SELECT 
        EXTRACT(MONTH FROM od.order_date) AS month,
        mi.item_name,
        COUNT(od.order_details_id) AS number_purchases,
        ROW_NUMBER() OVER (PARTITION BY EXTRACT(MONTH FROM od.order_date) ORDER BY COUNT(od.order_details_id) DESC) AS row_num
    FROM 
        restaurant_db.order_details od
    INNER JOIN 
        restaurant_db.menu_items mi
    ON 
        od.item_id = mi.menu_item_id
    GROUP BY 
        month, mi.item_name
)
SELECT 
    month,
    item_name,
    number_purchases
FROM 
    MonthlyPurchases
WHERE 
    row_num = 1
ORDER BY 
    month;








