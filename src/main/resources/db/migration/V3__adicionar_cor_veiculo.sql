-- Adiciona coluna de cor ao veículo
ALTER TABLE veiculos
    ADD COLUMN IF NOT EXISTS cor VARCHAR(255);
