--SQL1
SELECT * FROM customers WHERE age > 30;

--SQL2
SELECT COUNT(*) FROM claims;

--SQL3
SELECT 
    c.first_name, 
    c.last_name, 
    p.policy_number, 
    p.annual_premium
FROM customers c
JOIN policies p ON c.customer_id = p.customer_id;

