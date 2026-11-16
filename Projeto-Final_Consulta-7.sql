-- Consulta 7
-- Objetivo: listar usuarios que possuem pelo menos um registro
-- de receita preparada.

SELECT
    u.id_usuario,
    u.nome,
    u.email
FROM USUARIO AS u
WHERE EXISTS (
    SELECT 1
    FROM RECEITA_PREPARADA AS rp
    WHERE rp.id_usuario = u.id_usuario
)
ORDER BY u.nome ASC;