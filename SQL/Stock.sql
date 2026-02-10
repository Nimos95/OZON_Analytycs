SELECT 
  category,
  SUM(stock) as total_stock
FROM products
GROUP BY category
ORDER BY total_stock DESC;