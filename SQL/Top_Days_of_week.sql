SELECT 
    CASE EXTRACT(DOW FROM sale_date)
        WHEN 0 THEN 'Воскресенье'
        WHEN 1 THEN 'Понедельник'
        WHEN 2 THEN 'Вторник'
        WHEN 3 THEN 'Среда'
        WHEN 4 THEN 'Четверг'
        WHEN 5 THEN 'Пятница'
        WHEN 6 THEN 'Суббота'
    END as "День недели",
    COUNT(*) as "Количество заказов",
    SUM(price * quantity) as "Выручка, руб",
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 1) as "Доля заказов, %"
FROM sales
WHERE status = 'Доставлен'
GROUP BY EXTRACT(DOW FROM sale_date), "День недели"
ORDER BY "Количество заказов" DESC;