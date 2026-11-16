-- Consulta 3
-- Objetivo: mostrar a nota media das receitas avaliadas
-- e selecionar aquelas cuja media seja igual ou superior a 4.

SELECT
    r.nome AS receita,
    AVG(a.nota) AS media_avaliacao,
    COUNT(a.id_usuario) AS total_avaliacoes
FROM RECEITA AS r
INNER JOIN AVALIACAO_RECEITA AS a
    ON a.id_receita = r.id_receita
GROUP BY r.id_receita, r.nome
HAVING AVG(a.nota) >= 4
ORDER BY media_avaliacao DESC;