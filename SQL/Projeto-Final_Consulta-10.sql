-- Consulta 10
-- Objetivo: demonstrar controle transacional com SAVEPOINT,
-- ROLLBACK e COMMIT.
-- As operacoes sao feitas em uma tabela temporaria,
-- sem alterar os dados permanentes do projeto.

CREATE TEMP TABLE IF NOT EXISTS teste_transacao (
    descricao TEXT NOT NULL
);

-- Primeira transacao
BEGIN TRANSACTION;

SAVEPOINT ponto_salvamento_1;

INSERT INTO teste_transacao (descricao)
VALUES ('Registro que sera desfeito na primeira transacao');

ROLLBACK TO SAVEPOINT ponto_salvamento_1;

RELEASE SAVEPOINT ponto_salvamento_1;

COMMIT;


-- Segunda transacao
BEGIN TRANSACTION;

SAVEPOINT ponto_salvamento_2;

INSERT INTO teste_transacao (descricao)
VALUES ('Registro que sera desfeito na segunda transacao');

ROLLBACK TO SAVEPOINT ponto_salvamento_2;

RELEASE SAVEPOINT ponto_salvamento_2;

COMMIT;


-- Resultado esperado: nenhuma linha inserida.
SELECT * FROM teste_transacao;