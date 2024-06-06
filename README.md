# Introduction

📊 Restaurant Order Analysis.

This analysis aims to uncover patterns in customer behavior through examining order data.

🔍 For access to SQL queries, kindly refer to the following location: [project_sql folder](/project_sql/)

# Background

This data comes from [Maven Analytics](https://app.mavenanalytics.io/guided-projects/d7167b45-6317-49c9-b2bb-42e2a9e9c0bc).

![ER Diagram](assets/restaurant_project.png)
_ER Diagram_

### The questions I wanted to answer through my SQL queries were:

1. What were the least and most ordered items? What categories were they in?
2. What were the top 5 orders that spent the most money?
3. View the details of the highest spend order. Which specific items were purchased?
4. How do sales vary by month?
5. What times of day have the highest sales?
6. What is the average value of an order over a specific month?
7. How often do customers place orders in a month?
8. What are the top 10 best-selling menu items?
9. What was the most popular item of each month?

# Tools I Used

- **SQL:** The foundation of my analysis, empowering me to query the database and uncover invaluable insights.
- **PostgreSQL:** The chosen database management system.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis

### 1. What were the least and most ordered items? What categories were they in?

```sql
SELECT item_name, category, COUNT(order_details_id) AS number_purchases
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY item_name, category
ORDER BY number_purchases ASC
LIMIT 1;
```

```sql
SELECT item_name, category, COUNT(order_details_id) AS number_purchases
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY item_name, category
ORDER BY number_purchases DESC
LIMIT 1;
```

To identify the least and most ordered items, we use the GROUP BY statement on item_name and category, and count the frequency of each order using the count function on order_details_id.

From the results, we see that Chicken Tacos (Mexican category) is the least ordered item with 123 orders in the past three months. Conversely, Hamburgers (American category) are the most ordered item with 622 orders.

| item_name     | category | number_purchases |
| ------------- | -------- | ---------------- |
| Chicken Tacos | Mexican  | 123              |

_Table of least ordered items_

| item_name  | category | number_purchases |
| ---------- | -------- | ---------------- |
| Hamburgers | American | 622              |

_Table of most ordered items_

### 2. What were the top 5 orders that spent the most money?

```sql
SELECT order_id, SUM(price) AS total_spend
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY order_id
ORDER BY sum(price) DESC
LIMIT 5;
```

To identify the top 5 highest spending orders, we use the GROUP BY statement on order_id and apply the SUM function on the price to calculate the total amount spent for each order.

From the results, we find that orders 440, 2075, 1957, 330, and 2675 are the highest paying orders.

| order_id | total_spend |
| -------- | ----------- |
| 440      | 192.15      |
| 2075     | 191.05      |
| 1957     | 190.10      |
| 330      | 189.70      |
| 2675     | 185.10      |

_Table of top 5 highest spending orders_

### 3. View the details of the highest spend order. Which specific items were purchased?

```sql
SELECT category, COUNT(item_id) AS num_items
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
WHERE order_id = 440
GROUP BY category;
```

From the previous analysis, we identified the top 5 highest spending orders, with order 440 at the top. To examine the details of order 440, we use it as a filter. We then apply the GROUP BY statement on order_id and use the COUNT function on item_id to determine the specific items purchased.

The results show that order 440 included 8 Italian items, and 2 items each from the American, Asian, and Mexican categories.

| category | num_items |
| -------- | --------- |
| American | 2         |
| Asian    | 2         |
| Italian  | 8         |
| Mexican  | 2         |

_Table of specific items were purchased_

### How do sales vary by month?

```sql
SELECT EXTRACT(MONTH FROM order_date) AS month, SUM(price) AS total_sales
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY month
ORDER BY total_sales DESC;
```

| month | total_sales |
| ----- | ----------- |
| 3     | 54610.60    |
| 1     | 53816.95    |
| 2     | 50790.35    |

_Table of total sales per month_

To determine the total sales for each month, we first extract the month from the order date and update the column accordingly. We then use the sum function on the price column to calculate the total sales, grouping the data by month. Finally, we order the table by total sales.

In the results, the months are represented numerically: 1 for January, 2 for February, and 3 for March. The highest sales were recorded in March, totaling $54,610.60, followed by January with $53,816.95, and February with $50,790.35.

### What times of day have the highest sales?

```sql
SELECT order_time, SUM(price) AS total_sales
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY order_time
ORDER BY total_sales DESC
LIMIT 10;
```

| order_time | total_sales |
| ---------- | ----------- |
| 13:13:33   | 229.05      |
| 12:07:16   | 224.50      |
| 11:49:01   | 208.60      |
| 12:24:36   | 203.05      |
| 13:58:44   | 198.70      |
| 14:00:05   | 193.00      |
| 12:16:34   | 192.15      |
| 14:03:04   | 191.05      |
| 14:50:01   | 190.10      |
| 13:27:11   | 189.70      |

_Table of order times and their sales_

To determine the times of day with the highest sales, we first need to select the order time and use the sum function to aggregate the total sales, grouping by order time and ordering the results in descending order of total sales. From the results, we can see that 13:13 is the time with the highest sales, which usually falls within the lunch period.

### What is the average value of an order over a specific month?

```sql
SELECT EXTRACT(MONTH FROM order_date) AS month, ROUND(AVG(price),2) AS average_order
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY month
ORDER BY average_order DESC;
```

| month | average_order |
| ----- | ------------- |
| 2     | 13.19         |
| 3     | 13.18         |
| 1     | 13.11         |

_Table of the average value of an order for each month_

To determine the average value of an order over the months, we need to extract the month from the order date and rename the column as "month." Then, we use the average function on the price, rounding it to two decimal places to obtain the average order price. We group the data by month and order it by the average order price. From the results, we can see that the average order price per month is relatively consistent, hovering around the $13 mark with only a few cents difference between them.

### How often do customers place orders in a month?

```sql
SELECT EXTRACT(MONTH FROM order_date) AS month, COUNT(*) AS how_many_orders
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY month
ORDER BY how_many_orders DESC;
```

| month | number_of_orders |
| ----- | ---------------- |
| 3     | 4142             |
| 1     | 4104             |
| 2     | 3851             |

_Table of how often customers place orders each month_

To determine how often customers place orders, we need to extract the month from the order date and rename the column as "month." Then, we count all rows in the table, representing all orders, and group the data by month, ordering it by the number of orders in descending order. From the results, we see that March had the most orders with 4,142, followed by January with 4,104, and February with 3,851.

### What are the top 10 best-selling menu items?

```sql
SELECT item_name, category, COUNT(order_details_id) AS number_purchases
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
GROUP BY item_name, category
ORDER BY number_purchases DESC
LIMIT 10;
```

| item_name             | category | number_of_purchases |
| --------------------- | -------- | ------------------- |
| Hamburger             | American | 622                 |
| Edamame               | Asian    | 620                 |
| Korean Beef Bowl      | Asian    | 588                 |
| Cheeseburger          | American | 583                 |
| French Fries          | American | 571                 |
| Tofu Pad Thai         | Asian    | 562                 |
| Steak Torta           | Mexican  | 489                 |
| Spaghetti & Meatballs | Italian  | 470                 |
| Mac & Cheese          | American | 463                 |
| Chips & Salsa         | Mexican  | 461                 |

_Table of top 10 best-selling menu items_

The following analysis presents the top 10 best-selling menu items at the restaurant, categorised by their respective cuisine type. The data was obtained using a SQL query that joins the order_details and menu_items tables, groups the results by item name and category, and orders them by the number of purchases in descending order.

American Cuisine Dominates:

The top-selling item is the Hamburger, with 622 purchases.
American cuisine has four items in the top 10: Hamburger, Cheeseburger, French Fries, and Mac & Cheese.
The combined purchases for American items total 2,239, indicating strong customer preference for American dishes.

Asian Cuisine Popularity:

Edamame and Korean Beef Bowl are the second and third best-selling items, with 620 and 588 purchases, respectively.
Tofu Pad Thai also makes the list, bringing the total purchases for Asian cuisine items to 1,770.
This highlights a significant interest in Asian cuisine among customers.

Overall, the data shows a strong preference for American and Asian cuisines among customers, with Mexican and Italian dishes also being popular choices. The variety in the top-selling items suggests a broad appeal across different types of cuisine.

### What was the most popular item of each month?

```sql
WITH monthly_purchases AS (
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
    monthly_purchases
WHERE
    row_num = 1
ORDER BY
    month;
```

| month | item_name | number_purchases |
| ----- | --------- | ---------------- |
| 1     | Edamame   | 235              |
| 2     | Edamame   | 201              |
| 3     | Hamburger | 229              |

_Table of the most popular item of each month_

The following analysis presents the most popular menu items for the first three months at the restaurant, identified using a SQL query that calculates monthly purchases and ranks the items by the number of purchases in descending order.

Findings:

January:
Edamame Dominance: Edamame was the most popular item with 235 purchases. This indicates a strong preference for this Asian appetizer among customers at the start of the year.

February:
Continued Popularity of Edamame: Edamame remained the top choice with 201 purchases, though slightly fewer than in January. This consistency suggests sustained customer interest in this item.

March:
Shift to Hamburger: In March, Hamburger became the most popular item with 229 purchases, marking a significant shift from the previous months. This could indicate a change in customer preferences, possibly influenced by seasonal factors or targeted promotions.

Overall, the analysis reveals a strong initial preference for Edamame, which dominated sales in the first two months. However, in March, there was a notable shift towards the Hamburger, reflecting a change in customer preferences or successful promotional efforts by the restaurant. This trend could also indicate that at the beginning of the year, people may participate in New Year goals, such as eating healthier. Edamame is high in vitamin A and beneficial for inflammation because it contains choline, a nutrient related to B vitamins. This health benefit likely supports a healthy lifestyle and is reflected in the number of purchases. With this information, we can tailor the menu to include more healthy items to boost sales.

# What I Learned

Throughout this project, I have learned several important topics.

- **🧩 Applying Complex Queries:** Utilised Common Table Expressions (CTEs) with window functions and ranking.
- **📊 Modifying the Table Structure:** Initially, the tables were not connected. I altered the order_details table by adding a foreign key on the item_id. This enabled the creation of more complex queries, leading to more insightful results.

```sql
ALTER TABLE restaurant_db.order_details
ADD FOREIGN KEY (item_id) REFERENCES restaurant_db.menu_items(menu_item_id);
```

# Conclusions

### Insights

The analysis highlights hamburgers as the top-selling item and Chicken Tacos as the least ordered. High-spending orders feature a diverse range of cuisines. March sees peak sales, particularly at lunchtime. Average order value remains consistent. Insights inform menu adjustments and promotional strategies for improved sales and customer satisfaction.
