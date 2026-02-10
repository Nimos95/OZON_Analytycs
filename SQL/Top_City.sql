SELECT 
  city,
  SUM(price * quantity) as revenue,
  COUNT(*) as orders_count
FROM sales
WHERE status = 'Доставлен'
GROUP BY city
ORDER BY revenue DESC
LIMIT 10;