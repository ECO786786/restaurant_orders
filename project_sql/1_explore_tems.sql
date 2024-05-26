/*
Question one: 
View the menu_items table and write a query to find the number of items on the menu
*/

SELECT * 
FROM restaurant_db.menu_items;

SELECT COUNT(*) 
FROM restaurant_db.menu_items;

/*
We find the number of items by counting the number of items. We can achieve this by using the count function  whihc returns the number of rows that matches a specified criterion which is the *. Star reprents all the rows in the table. From the resulst we find that there are 32 items on the menu.  
*/

/*
Question two: 
What are the least and most expensive items on the menu?
*/

SELECT MIN(price) AS least_expensive_item, MAX(price) AS most_expensive_item
FROM menu_items;

-- Question three 
-- How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
SELECT COUNT(*) AS italian_dishes, MIN(price) AS least_expensive_item, MAX(price) AS most_expensive_item 
FROM menu_items
WHERE category = 'Italian';

-- Question four 
-- How many dishes are in each category? What is the average dish price within each category?
SELECT category, count(category) as number_of_dishes, round(avg(price),2) as avg_price
FROM menu_items
group by category;

