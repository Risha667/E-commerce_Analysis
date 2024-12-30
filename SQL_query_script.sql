SELECT name FROM sqlite_master WHERE type='table';

-- This query calculates total monthly revenue from the Orders and OrderPayments tables.
SELECT 
    strftime('%Y-%m', o.order_purchase_timestamp) AS month,
    SUM(op.payment_value) AS total_revenue
FROM orders o
JOIN order_payments op ON o.order_id = op.order_id
GROUP BY month
ORDER BY month;


-- This query identifies the top 5 customers by total spending.
SELECT 
    c.customer_id,
    SUM(op.payment_value) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_payments op ON o.order_id = op.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- This query calculates total revenue by product category.
SELECT 
    pct.product_category_name AS category,
    SUM(oi.price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN product_category_name_translation pct ON p.product_category_name = pct.product_category_name
GROUP BY category
ORDER BY total_revenue DESC;

-- This query calculates the average delivery delay in days.
SELECT 
    AVG(JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_estimated_delivery_date)) AS avg_delivery_delay
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;


-- This query calculates the average order value across all orders.
SELECT 
    AVG(op.payment_value) AS average_order_value
FROM order_payments op;

-- This query identifies the top 5 sellers by the number of products sold.
SELECT 
    seller_id,
    COUNT(order_id) AS total_orders
FROM order_items oi
GROUP BY seller_id
ORDER BY total_orders DESC
LIMIT 5;

-- This query counts the number of customers in each state.
SELECT 
    customer_state,
    COUNT(customer_id) AS total_customers
FROM Customers
GROUP BY customer_state
ORDER BY total_customers DESC;

-- This query calculates return rates for each product.
SELECT 
    product_id,
    SUM(CASE WHEN o.order_status = 'returned' THEN 1 ELSE 0 END) AS total_returns,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(CASE WHEN o.order_status = 'returned' THEN 1 ELSE 0 END) * 100.0 / COUNT(o.order_id), 2) AS return_rate
FROM Orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY product_id
ORDER BY return_rate DESC
LIMIT 5;

-- This query calculates the average review score for each product.
SELECT 
    oi.product_id,
    AVG(orv.review_score) AS avg_review_score
FROM order_items oi
JOIN order_reviews orv ON oi.order_id = orv.order_id
GROUP BY oi.product_id
ORDER BY avg_review_score DESC
LIMIT 5;

-- This query calculates the number of orders and total revenue by payment method.
SELECT 
    payment_type,
    COUNT(order_id) AS total_orders,
    SUM(payment_value) AS total_revenue
FROM order_payments op
GROUP BY payment_type
ORDER BY total_revenue DESC;


-- This query calculates the average number of orders per customer.
SELECT 
    c.customer_id,
    COUNT(o.order_id) AS total_orders,
    ROUND(COUNT(o.order_id) / CAST((JULIANDAY('now') - JULIANDAY(MIN(o.order_purchase_timestamp))) AS FLOAT), 2) AS avg_orders_per_day
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY avg_orders_per_day DESC
LIMIT 10;




