E-commerce Sales Analysis
Table of Contents
Overview
Goals
Technologies Used
Datasets and Schema
Key Analyses and Insights
Installation and Usage
Results and Recommendations

--------------------------------------------------------------------------------
1. Overview
This project aims to analyze sales, customer behavior, and operational 
performance for an e-commerce platform using SQL. The analysis identifies 
key trends, customer insights, and product performance to help optimize 
marketing strategies, improve customer satisfaction, and streamline operations.

The dataset used is the Olist E-commerce Dataset in SQLite format, 
comprising tables such as Orders, OrderItems, Products, and Customers.

--------------------------------------------------------------------------------
2. Goals
-Identify monthly revenue trends and seasonal patterns.
-Highlight the most loyal customers by spending.
-Determine top-performing product categories.
-Analyze delivery performance and identify bottlenecks.
-Understand customer and regional activity.
-Evaluate product return rates and customer satisfaction scores.
-Understand payment method preferences.

--------------------------------------------------------------------------------
3. Technologies Used
SQLite: Database for storing and querying data.
SQL: Language for data extraction, transformation, and analysis.

--------------------------------------------------------------------------------
4. Datasets and Schema

The dataset includes:
Orders: Order details, timestamps, and statuses.
OrderItems: Line-item details for each order.
Products: Product specifications and categories.
Customers: Customer demographics and locations.
OrderPayments: Payment types and amounts.

Schema Overview:
The database schema (see image above) outlines the relationships between tables 
like Orders, Products, Customers, and Sellers.

--------------------------------------------------------------------------------
5. Key Analyses and Insights

## 1. Monthly Revenue Trends
Query:
SELECT 
    strftime('%Y-%m', order_purchase_timestamp) AS month,
    SUM(payment_value) AS total_revenue
FROM Orders o
JOIN OrderPayments op ON o.order_id = op.order_id
GROUP BY month
ORDER BY month;

Result: Seasonal peaks observed during Q4 due to holiday shopping.
Recommendation: Increase inventory and marketing efforts during Q4.


## 2. Top 5 Loyal Customers
Query:
SELECT 
    c.customer_id,
    SUM(op.payment_value) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderPayments op ON o.order_id = op.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;

Result: Top customers accounted for a significant portion of sales.
Recommendation: Offer loyalty programs and exclusive perks to these customers.

## 3. Top-Performing Product Categories
Query:
SELECT 
    pct.product_category_name_english AS category,
    SUM(oi.price) AS total_revenue
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.product_id
JOIN ProductCategoryTranslation pct 
ON p.product_category_name = pct.product_category_name
GROUP BY category
ORDER BY total_revenue DESC;

Result: Electronics and Home Goods emerged as top categories.
Recommendation: Allocate more resources to these categories for targeted 
promotions.

----------------------------------------------------------------------------------
6. Installation and Usage

Pre-requisites:
-Install DBeaver (a database management tool) on your system.
-Download and configure the SQLite driver in DBeaver for querying SQLite databases.

Steps to Run the Project:
##Open DBeaver and connect to the SQLite database:
-Create a new SQLite connection in DBeaver.
-Browse and select the provided database file (olist.sqlite).
##Once the connection is established:
-Load and execute the SQL queries from the provided script (SQL_query_script.sql) to generate insights.
-Review the query results in DBeaver’s result grid for further analysis.

---------------------------------------------------------------------------------
7. Results and Recommendations
Key Results:

-Revenue Trends:
Seasonal Q4 peaks suggest a holiday shopping boom.

-Loyal Customers:
High-spending customers contribute significantly to revenue.

-Delivery Delays:
Average delay of 3.5 days indicates the need for logistics optimization.

-Regional Activity:
São Paulo accounts for the majority of customers, highlighting a key regional market.


Recommendations:
-Boost Marketing During Q4:
Capitalize on holiday shopping trends with targeted promotions.

-Focus on High-Performing Categories:
Promote Electronics and Home Goods with tailored campaigns.

-Improve Logistics:
Collaborate with delivery partners to reduce delays.

-Enhance Customer Loyalty:
Offer personalized perks to high-spending customers.
