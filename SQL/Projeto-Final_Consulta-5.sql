-- Consulta 5
-- Objetivo: listar todos os usuarios, inclusive aqueles sem avaliacoes,
-- mostrando a quantidade de avaliacoes.

SELECT
    u.id_usuario,
    u.nome,
    COALESCE(COUNT(a.id_receita), 0) AS quantidade_avaliacoes
FROM USUARIO AS u
LEFT JOIN AVALIACAO_RECEITA AS a
    ON a.id_usuario = u.id_usuario
GROUP BY u.id_usuario, u.nome
ORDER BY quantidade_avaliacoes DESC, u.nome ASC;