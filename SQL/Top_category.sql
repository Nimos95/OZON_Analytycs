SELECT 
  p.category,
  COUNT(DISTINCT s.sale_id) as orders_count,
  SUM(s.quantity) as items_sold,
  SUM(s.price * s.quantity) as total_revenue,
  ROUND(AVG(s.price * s.quantity), 2) as avg_order_value,
  ROUND(100.0 * SUM(s.price * s.quantity) / 
    (SELECT SUM(price * quantity) FROM sales WHERE status = 'Доставлен'), 1) as revenue_percentage
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE s.status = 'Доставлен'
GROUP BY p.category
ORDER BY total_revenue DESC;