-- Consulta 1
-- Objetivo: listar as categorias e a quantidade de receitas associadas.

SELECT
    c.id_categoria,
    c.nome AS categoria,
    COUNT(rc.id_receita) AS quantidade_receitas
FROM CATEGORIA_RECEITA AS c
INNER JOIN RECEITA_CATEGORIA AS rc
    ON rc.id_categoria = c.id_categoria
INNER JOIN RECEITA AS r
    ON r.id_receita = rc.id_receita
WHERE r.status = 'Ativa'
GROUP BY c.id_categoria, c.nome
HAVING COUNT(rc.id_receita) >= 1
ORDER BY quantidade_receitas DESC, categoria ASC;