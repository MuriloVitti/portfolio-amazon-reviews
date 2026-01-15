------------------------------------------------------------------------------------
-- PROJETO: Análise de Estratégia de Preços Amazon
-- OBJETIVO: Extrair insights sobre descontos, avaliações e impacto financeiro.
------------------------------------------------------------------------------------

-- PERGUNTA 1: Categorias mais agressivas em porcentagem de desconto.
-- Identifica onde a Amazon foca em volume e atração de tráfego.
SELECT 
    category, 
    ROUND(AVG(discount_percentage) * 100, 2) AS media_desconto
FROM amazon_reviews
GROUP BY category
ORDER BY media_desconto DESC
LIMIT 5;

-- PERGUNTA 2: Qualidade vs. Preço.
-- Compara a satisfação de produtos em promoção agressiva vs. média geral.
SELECT 
    'ALTO DESCONTO' AS grupo,
    ROUND(AVG(CAST(rating AS NUMERIC)), 2) AS nota_media
FROM public.amazon_reviews
WHERE discount_percentage > 0.5 AND rating <> '|'
UNION ALL
SELECT 
    'MÉDIA GERAL',
    ROUND(AVG(CAST(NULLIF(rating, '|') AS NUMERIC)), 2)
FROM public.amazon_reviews
WHERE rating <> '|';

-- PERGUNTA 3: Produtos Top Tier.
-- Produtos com mais de 10k avaliações e as melhores notas.
SELECT 
    SUBSTR(product_name, 1, 50) AS produto, 
    rating,
    rating_count
FROM amazon_reviews
WHERE rating_count > 10000 AND rating <> '|'
ORDER BY CAST(rating AS NUMERIC) DESC, rating_count DESC
LIMIT 10;

-- PERGUNTA 4: Impacto Financeiro Real (Economia em Dinheiro).
-- Categorias com maior benefício financeiro para o cliente.
SELECT 
    category,
    COUNT(*) AS total_produtos,
    ROUND(AVG(actual_price - discounted_price), 2) AS media_economia_valor
FROM public.amazon_reviews
GROUP BY category
HAVING COUNT(*) > 10
ORDER BY media_economia_valor DESC
LIMIT 5;

-- PERGUNTA 5: O Duelo dos Extremos (Iscas vs. Necessidades).
-- Detalhes sobre o maior e o menor desconto ativo.
(SELECT 
    'MAIOR DESCONTO' AS status,
    SUBSTR(product_name, 1, 60) AS produto, 
    ROUND(discount_percentage * 100, 2) AS desconto_pct,
    rating AS nota,
    rating_count AS total_reviews
FROM amazon_reviews
ORDER BY discount_percentage DESC
LIMIT 1)
UNION ALL
(SELECT 
    'MENOR DESCONTO' AS status,
    SUBSTR(product_name, 1, 60) AS produto, 
    ROUND(discount_percentage * 100, 2) AS desconto_pct,
    rating AS nota,
    rating_count AS total_reviews
FROM amazon_reviews
WHERE discount_percentage > 0
ORDER BY discount_percentage ASC
LIMIT 1);