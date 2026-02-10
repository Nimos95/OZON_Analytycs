SELECT 
  p.product_name,
  SUM(s.quantity) as total_sold,
  SUM(s.price * s.quantity) as total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE s.status = 'Доставлен'
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 5;