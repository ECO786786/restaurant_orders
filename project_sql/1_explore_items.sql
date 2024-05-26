/*
Question one: 
View the menu_items table and write a query to find the number of items on the menu
*/

SELECT * 
FROM restaurant_db.menu_items;

SELECT COUNT(*) 
FROM restaurant_db.menu_items;

/*
To determine the number of items, we use the count function. This function returns the number of rows that match a specified criterion, which in this case is represented by the asterisk (*), meaning all rows in the table. From the results, we find that there are 32 items on the menu.
*/

/*
Question two: 
What are the least and most expensive items on the menu?
*/

SELECT MIN(price) AS least_expensive_item, MAX(price) AS most_expensive_item
FROM restaurant_db.menu_items;

/*
We find the least expensive item using the min function and the most expensive item using the max function. The results show that the cheapest item is $5, while the most expensive item is $19.95.
*/

/* 
Question three: 
How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
*/

SELECT COUNT(*) AS italian_dishes, MIN(price) AS least_expensive_item, MAX(price) AS most_expensive_item 
FROM restaurant_db.menu_items
WHERE category = 'Italian';

/* 
To find the number of Italian dishes, as well as the cheapest and most expensive Italian items, we use the count, min, and max functions with a where clause to filter the results to Italian dishes.

One important discovery is that you can use multiple aggregate functions without needing a GROUP BY clause.
*/

/*
Question four: 
How many dishes are in each category? What is the average dish price within each category?
*/

SELECT category, count(category) as number_of_dishes, round(avg(price),2) as avg_price
FROM restaurant_db.menu_items
GROUP BY category;

/*
To categorise the number of dishes and their average price, we need to use a GROUP BY clause for the category. We can then use the count and average functions to obtain the results. Additionally, we should use the round function to round the average price to two decimal places.
*/

