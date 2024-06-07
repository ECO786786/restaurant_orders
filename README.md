# Introduction

📊 Restaurant Order Analysis.

This analysis aims to uncover patterns in customer behaviour through examining order data.

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

| item_name     | category | number_purchases |
| ------------- | -------- | ---------------- |
| Chicken Tacos | Mexican  | 123              |

_Table of least ordered items_

| item_name  | category | number_purchases |
| ---------- | -------- | ---------------- |
| Hamburgers | American | 622              |

_Table of most ordered items_

The following analysis presents the least and most ordered items by category,identified using a SQL query that joins the order_details and menu_items tables, groups the results by item name and category, and orders them by the number of purchases in descending order and asending order with a limit of one.

The most ordered item falls under the American category, suggesting that American cuisine is particularly popular among the restaurant's customers. This might be influenced by the local demographic's taste preferences or the restaurant's reputation for its American dishes.

On the other hand, the least ordered item, Chicken Tacos, is from the Mexican category. This could imply a lesser interest in Mexican cuisine among the patrons or potential issues with the specific item (e.g., taste, price, or presentation).

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

| order_id | total_spend |
| -------- | ----------- |
| 440      | 192.15      |
| 2075     | 191.05      |
| 1957     | 190.10      |
| 330      | 189.70      |
| 2675     | 185.10      |

_Table of top 5 highest spending orders_

The following analysis presents orders generated the most revenue, an SQL query was executed to aggregate the total spending per order. The query grouped the data by order ID and summed the prices of items in each order, ordering the results by the total spend in descending order. From the results, we find that orders 440, 2075, 1957, 330, and 2675 are the highest paying orders.

These top 5 orders represent the highest revenue generating transactions for the restaurant. Each order has a total spend close to $190 or more, indicating that they likely involved large parties or customers purchasing multiple high priced items.

### 3. View the details of the highest spend order. Which specific items were purchased?

```sql
SELECT category, COUNT(item_id) AS num_items
FROM restaurant_db.order_details
INNER JOIN restaurant_db.menu_items
ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
WHERE order_id = 440
GROUP BY category;
```

| category | num_items |
| -------- | --------- |
| American | 2         |
| Asian    | 2         |
| Italian  | 8         |
| Mexican  | 2         |

_Table of specific items were purchased_

To gain a deeper understanding of the highest spending order, identified previously as order 440 with a total spend of $192.15, an SQL query was performed to categorise the items purchased within this order. The results provide a breakdown of the specific items ordered by their category.

# Dominance of Italian Cuisine:

The order included a significant number of Italian items (8), indicating a strong preference for Italian cuisine in this particular high value order. This could suggest that the Italian menu items are either well loved by customers or are perceived as special items worth purchasing in bulk.

# Diverse Cuisine Preferences:

Besides Italian, the order also included items from American, Asian, and Mexican categories (2 items each). This indicates a preference for a diverse culinary experience, perhaps catering to a group with varied tastes.
Menu Insights:

The high quantity of Italian items ordered can provide insight into popular dishes within this category. It could be beneficial to identify which specific Italian dishes were ordered and promote them as part of special offers or highlight them on the menu.

# Customer Behavior:

The diversity in the order suggests that customers appreciate variety. Offering combo deals that include items from multiple categories or themed multi-cuisine dining experiences could appeal to similar high-spending customers.

### 4. How do sales vary by month?

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

To analyse how sales vary by month, an SQL query was executed to extract the month from the order dates and calculate the total sales for each month. The data is grouped by month and ordered by total sales in descending order.

# Highest Sales in March:

March recorded the highest sales with a total of $54,610.60. This could be attributed to various factors such as seasonal promotions, special events, or holidays that typically occur in March, which drive higher customer traffic and spending.

# Strong Start in January:

January also showed strong sales with a total of $53,816.95. The beginning of the year might see increased dining out as people celebrate the New Year or take advantage of post-holiday promotions.
Steady Sales in February:

February's sales were slightly lower at $50,790.35 but still substantial. Valentine's Day and other winter events might contribute to the steady performance in this month. To enhance sales in February, focus on events such as Valentine's Day. Special menus, couple discounts, or romantic dining experiences could attract more customers.

### 5. What times of day have the highest sales?

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

To understand the times of day with the highest sales, an SQL query was executed to group the total sales by order time. The data was sorted in descending order to identify the top 10 times with the highest sales.

# Peak Lunch Hours:

The highest sales are observed around lunchtime, specifically between 11:49 AM and 2:50 PM. This period shows significant sales activity, indicating that lunch is a crucial time for the restaurant's revenue.
The top time slot, 13:13:33 (1:13 PM), generated the highest sales of $229.05.
Consistent Midday Performance:

Several other time slots around midday, such as 12:07:16 (12:07 PM), 12:24:36 (12:24 PM), and 12:16:34 (12:16 PM), also feature prominently. This suggests a consistent pattern of high sales during the lunch rush.
Afternoon Sales:

Times just after the peak lunch hours, such as 1:58 PM and 2:00 PM, also show high sales, indicating that the restaurant continues to perform well into the early afternoon.

## Strategic Recommendations:

# Lunch Promotions:

Given the high sales during lunchtime, introducing special lunch menus, discounts, or combo deals could further boost sales during these peak hours.

Promoting these offers through social media, email marketing, and in store signage can attract more customers during the lunch period.

# Optimising Staffing:

Ensuring adequate staffing levels during peak lunch hours can help manage the increased customer traffic efficiently. Providing excellent service during these times can enhance the dining experience and encourage repeat visits.

# Lunch time Marketing:

Targeting marketing efforts around the midday hours can be highly effective. Utilising online platforms to advertise lunchtime specials or partnering with nearby offices for corporate lunch deals can drive more business.

### 6. What is the average value of an order over a specific month?

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

To analyse the average value of orders over different months, an SQL query was executed to extract the month from order dates and calculate the average order price, rounded to two decimal places. The results provide a clear view of the average order values for January, February, and March.

# Consistency in Average Order Value:

The average order value across January, February, and March is remarkably consistent, with values hovering around $13. This indicates stable customer spending behavior during these months.

# Slight Increase in February:

February has the highest average order value at $13.19, slightly higher than March ($13.18) and January ($13.11). The minor increase in February could be influenced by specific events or promotions, such as Valentine's Day, which might encourage customers to spend a little more per order.

# Steady Performance in Early Months:

The slight variations in average order value suggest that the restaurant maintains a steady performance in the early months of the year. This stability is crucial for financial forecasting and planning.

### 7. How often do customers place orders in a month?

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

To analyze how often customers place orders each month, an SQL query was executed to count the number of orders per month by extracting the month from the order date and grouping the data accordingly. The results highlight the frequency of orders placed in January, February, and March.

# High Order Frequency in March:

March recorded the highest number of orders with 4,142. This peak in orders could be influenced by seasonal factors, promotions, or specific events that drive more customers to the restaurant.

# Steady Demand in January:

January saw a slightly lower number of orders at 4,104, indicating a strong start to the year. This could be due to New Year celebrations or post-holiday dining out.

# Lower, Yet Significant, Orders in February:

February had the lowest order count among the three months with 3,851 orders. Despite being the shortest month, the order volume remains substantial, reflecting a consistent customer base.

### 8. What are the top 10 best-selling menu items?

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

## American Cuisine Dominates:

The top-selling item is the Hamburger, with 622 purchases.
American cuisine has four items in the top 10: Hamburger, Cheeseburger, French Fries, and Mac & Cheese.
The combined purchases for American items total 2,239, indicating strong customer preference for American dishes.

## Asian Cuisine Popularity:

Edamame and Korean Beef Bowl are the second and third best-selling items, with 620 and 588 purchases, respectively.
Tofu Pad Thai also makes the list, bringing the total purchases for Asian cuisine items to 1,770.
This highlights a significant interest in Asian cuisine among customers.

Overall, the data shows a strong preference for American and Asian cuisines among customers, with Mexican and Italian dishes also being popular choices. The variety in the top-selling items suggests a broad appeal across different types of cuisine.

### 9. What was the most popular item of each month?

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

## Findings:

January:
Edamame Dominance: Edamame was the most popular item with 235 purchases. This indicates a strong preference for this Asian Appetiser among customers at the start of the year.

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

The analysis highlights hamburgers as the top-selling item and Chicken Tacos as the least ordered. High spending orders feature a diverse range of cuisines. March sees peak sales, particularly at lunchtime. Average order value remains consistent. Insights inform menu adjustments and promotional strategies for improved sales and customer satisfaction.
