-- Consulta 2
-- Objetivo: calcular a quantidade total de ingredientes cadastrada
-- na despensa de cada usuario.

SELECT
    u.nome AS usuario,
    i.nome AS ingrediente,
    SUM(d.quantidade) AS quantidade_total
FROM USUARIO AS u
INNER JOIN DESPENSA_USUARIO AS d
    ON d.id_usuario = u.id_usuario
INNER JOIN INGREDIENTE AS i
    ON i.id_ingrediente = d.id_ingrediente
GROUP BY u.id_usuario, u.nome, i.id_ingrediente, i.nome
ORDER BY usuario ASC, ingrediente ASC;