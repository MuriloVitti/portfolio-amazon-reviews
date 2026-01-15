-- Pergunta 1: Quais são as categorias com o maior desconto médio?
SELECT 
    category, 
    ROUND(AVG(discount_percentage), 2) AS media_desconto
FROM amazon_reviews
GROUP BY category
ORDER BY media_desconto DESC
LIMIT 5;