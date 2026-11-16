-- Consulta 8
-- Objetivo: listar os ingredientes utilizados
-- em pelo menos uma receita ativa.

SELECT
    i.id_ingrediente,
    i.nome AS ingrediente
FROM INGREDIENTE AS i
WHERE i.id_ingrediente IN (
    SELECT ir.id_ingrediente
    FROM INGREDIENTE_RECEITA AS ir
    INNER JOIN RECEITA AS r
        ON r.id_receita = ir.id_receita
    WHERE r.status = 'Ativa'
)
ORDER BY i.nome ASC;