-- Remover apenas as vírgulas (milhar) e o símbolo de %
UPDATE public.amazon_reviews 
SET 
    actual_price = REPLACE(actual_price, ',', ''),
    discounted_price = REPLACE(discounted_price, ',', ''),
    discount_percentage = REPLACE(discount_percentage, '%', ''),
    rating_count = REPLACE(rating_count, ',', '');

-- Converter as colunas para os tipos numéricos finais
ALTER TABLE amazon_reviews 
    ALTER COLUMN actual_price TYPE NUMERIC USING actual_price::NUMERIC,
    ALTER COLUMN discounted_price TYPE NUMERIC USING discounted_price::NUMERIC,
    ALTER COLUMN discount_percentage TYPE NUMERIC USING (discount_percentage::NUMERIC / 100),
    ALTER COLUMN rating_count TYPE INTEGER USING rating_count::INTEGER;