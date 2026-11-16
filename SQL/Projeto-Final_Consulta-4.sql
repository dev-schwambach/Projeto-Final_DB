-- Consulta 4
-- Objetivo: apresentar o menor e o maior tempo de preparo
-- entre as receitas ativas.

SELECT
    MIN(tempo_preparo) AS menor_tempo_minutos,
    MAX(tempo_preparo) AS maior_tempo_minutos
FROM RECEITA
WHERE status = 'Ativa';