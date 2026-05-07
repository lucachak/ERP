-- Enriquecimento do catálogo de serviços padrão
ALTER TABLE servicos_padrao
    ADD COLUMN IF NOT EXISTS valor_mao_de_obra    NUMERIC(38,2) DEFAULT 0 NOT NULL,
    ADD COLUMN IF NOT EXISTS valor_material        NUMERIC(38,2) DEFAULT 0 NOT NULL,
    ADD COLUMN IF NOT EXISTS tempo_estimado_min    INTEGER       DEFAULT 0 NOT NULL,
    ADD COLUMN IF NOT EXISTS observacoes           TEXT;

-- Migração de dados: se já havia valorPadrao, assume que era o total
-- valor_mao_de_obra fica como 0, valor_material fica com o valor antigo
UPDATE servicos_padrao
SET valor_material = valor_padrao
WHERE valor_padrao > 0
  AND valor_material = 0;
