SELECT 
  sale_date,  -- берем дату
  SUM(price * quantity) as revenue  -- считаем выручку
FROM sales
WHERE status = 'Доставлен'  -- только доставленные заказы
  AND sale_date >= CURRENT_DATE - INTERVAL '30 days'  -- за 30 дней
GROUP BY sale_date  -- группируем по дате
ORDER BY sale_date  