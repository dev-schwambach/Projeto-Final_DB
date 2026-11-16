-- Consulta 9
-- Objetivo: calcular, para cada receita ativa, quantos ingredientes
-- exigidos o usuario 1 possui na despensa e o percentual disponivel.
-- O percentual considera a presenca do ingrediente,
-- nao a suficiencia da quantidade.

WITH ingredientes_por_receita AS (
    SELECT
        ir.id_receita,
        COUNT(*) AS total_ingredientes
    FROM INGREDIENTE_RECEITA AS ir
    GROUP BY ir.id_receita
),
ingredientes_disponiveis AS (
    SELECT
        ir.id_receita,
        COUNT(d.id_ingrediente) AS total_disponiveis
    FROM INGREDIENTE_RECEITA AS ir
    LEFT JOIN DESPENSA_USUARIO AS d
        ON d.id_ingrediente = ir.id_ingrediente
       AND d.id_usuario = 1
       AND d.quantidade > 0
    GROUP BY ir.id_receita
)
SELECT
    r.nome AS receita,
    ipr.total_ingredientes,
    COALESCE(idp.total_disponiveis, 0) AS ingredientes_disponiveis,
    ROUND(
        100.0 * COALESCE(idp.total_disponiveis, 0) /
        NULLIF(ipr.total_ingredientes, 0),
        2
    ) AS percentual_disponivel
FROM RECEITA AS r
INNER JOIN ingredientes_por_receita AS ipr
    ON ipr.id_receita = r.id_receita
LEFT JOIN ingredientes_disponiveis AS idp
    ON idp.id_receita = r.id_receita
WHERE r.status = 'Ativa'
ORDER BY percentual_disponivel DESC, r.nome ASC;