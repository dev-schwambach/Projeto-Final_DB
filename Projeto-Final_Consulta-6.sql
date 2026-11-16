-- Consulta 6
-- Objetivo: encontrar receitas ativas cujo tempo de preparo
-- seja maior que a media de tempo de preparo de todas as receitas ativas.

SELECT
    nome,
    tempo_preparo
FROM RECEITA
WHERE status = 'Ativa'
  AND tempo_preparo > (
      SELECT AVG(tempo_preparo)
      FROM RECEITA
      WHERE status = 'Ativa'
  )
ORDER BY tempo_preparo DESC;