PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

-- Inserindo Unidade de Medida

INSERT INTO UNIDADE_MEDIDA (id_unidade, nome, sigla, tipo) VALUES
(1, 'Grama', 'g', 'Massa'),
(2, 'Mililitro', 'ml', 'Volume'),
(3, 'Unidade', 'un', 'Contagem');

-- Inserindo Usuários

INSERT INTO USUARIO
    (id_usuario, nome, email, senha_hash, data_cadastro)
VALUES
(1, 'Ana Martins', 'ana@example.test', 'hash_demo_ana_001', '2026-10-01'),
(2, 'Bruno Costa', 'bruno@example.test', 'hash_demo_bruno_002', '2026-09-15'),
(3, 'Carla Souza', 'carla@example.test', 'hash_demo_carla_003', '2026-08-20'),
(4, 'Diego Lima', 'diego@example.test', 'hash_demo_diego_004', '2026-07-10'),
(5, 'Marina Alves', 'marina@example.test', 'hash_demo_marina_005', '2026-11-05');

-- Inserindo Planos de Assinatura

INSERT INTO PLANO_ASSINATURA
    (id_plano, nome, descricao, preco, duracao_dias)
VALUES
(1, 'Free-Trial', 'Acesso gratuito de avaliacao por sete dias.', 0.00, 7),
(2, 'Mensal', 'Acesso completo por um ciclo de trinta dias.', 19.90, 30),
(3, 'Anual', 'Acesso completo por um periodo de 365 dias.', 160.90, 365);

-- Inserindo Assinaturas

INSERT INTO ASSINATURA
    (id_assinatura, id_usuario, id_plano, data_inicio, data_fim,
     status, data_cancelamento)
VALUES
(1, 1, 1, '2026-11-10', '2026-11-17', 'Free-trial', NULL),
(2, 2, 2, '2026-11-01', '2026-12-01', 'Ativa', NULL),
(3, 3, 2, '2026-09-01', '2026-10-01', 'Bloqueado', NULL),
(4, 4, 2, '2026-10-01', '2026-10-31', 'Inativo', '2026-10-10'),
(5, 5, 3, '2026-11-05', '2027-11-05', 'Ativa', NULL);

-- Inserindo Fatura (somente uma por usuário)

INSERT INTO FATURA_PAGAMENTO
    (id_fatura, id_assinatura, valor, data_emissao,
     data_vencimento, data_pagamento, status)
VALUES
(1, 2, 19.90, '2026-11-01', '2026-11-01', '2026-11-01', 'Pago'),
(2, 3, 19.90, '2026-09-01', '2026-09-01', NULL, 'Recusado'),
(3, 4, 19.90, '2026-10-01', '2026-10-01', '2026-10-01', 'Pago'),
(4, 5, 160.90, '2026-11-05', '2026-11-05', '2026-11-05', 'Pago');

-- Inserindo Ingredientes

INSERT INTO INGREDIENTE
    (id_ingrediente, id_unidade, nome, descricao)
VALUES
(1, 1, 'Arroz', 'Arroz branco cru.'),
(2, 1, 'Feijao', 'Feijao carioca cru.'),
(3, 1, 'Tomate', 'Tomate fresco.'),
(4, 1, 'Cebola', 'Cebola.'),
(5, 1, 'Alho', 'Alho.'),
(6, 2, 'Leite', 'Leite integral.'),
(7, 1, 'Farinha de trigo', 'Farinha de trigo tradicional.'),
(8, 3, 'Ovo', 'Ovo de galinha.'),
(9, 1, 'Banana', 'Banana madura sem casca.'),
(10, 1, 'Peito de frango', 'Peito de frango sem osso.'),
(11, 1, 'Sal', 'Sal refinado.'),
(12, 2, 'Azeite', 'Azeite de oliva.');

-- Inserindo O que cada usuário tem em sua casa

INSERT INTO DESPENSA_USUARIO
    (id_usuario, id_ingrediente, quantidade)
VALUES
-- Despensa da Ana

(1, 1, 1000.0),
(1, 3, 300.0),
(1, 4, 150.0),
(1, 5, 30.0),
(1, 8, 6.0),
(1, 9, 500.0),
(1, 11, 100.0),
(1, 12, 100.0),

-- Despensa do Bruno

(2, 1, 1500.0),
(2, 2, 800.0),
(2, 3, 500.0),
(2, 4, 200.0),
(2, 5, 40.0),
(2, 10, 700.0),
(2, 11, 150.0),
(2, 12, 200.0),

-- Despensa da Carla (sem leite, pois ela possui alergia)

(3, 3, 250.0),
(3, 4, 100.0),
(3, 7, 1000.0),
(3, 8, 12.0),
(3, 9, 600.0),
(3, 11, 100.0),

-- Despensa do Diego

(4, 1, 500.0),
(4, 2, 500.0),
(4, 6, 1000.0),
(4, 7, 500.0),
(4, 8, 10.0),
(4, 10, 400.0),
(4, 11, 100.0),

-- Despensa da Marina

(5, 1, 800.0),
(5, 3, 400.0),
(5, 4, 100.0),
(5, 6, 500.0),
(5, 8, 8.0),
(5, 9, 300.0),
(5, 10, 500.0),
(5, 11, 100.0);

-- Inserindo Alergias dos Usuários

INSERT INTO ALERGIA_USUARIO (id_usuario, id_ingrediente) VALUES
(3, 6),  -- Carla possui alergia a leite.
(5, 2);  -- Marina possui alergia a feijao.

-- Inserindo as Receitas

INSERT INTO RECEITA
    (id_receita, nome, descricao, tempo_preparo,
     dificuldade, rendimento_porcoes, status)
VALUES
(1, 'Arroz temperado', 'Arroz simples com tomate e temperos.', 30, 'Facil', 4, 'Ativa'),
(2, 'Omelete de tomate', 'Omelete com tomate e cebola.', 15, 'Facil', 2, 'Ativa'),
(3, 'Bolo de banana', 'Bolo caseiro de banana.', 50, 'Media', 8, 'Ativa'),
(4, 'Frango com arroz', 'Frango acompanhado de arroz temperado.', 45, 'Media', 4, 'Ativa'),
(5, 'Sopa experimental', 'Receita ainda em desenvolvimento.', 25, 'Facil', 2, 'Rascunho');

-- Inserindo Ingredientes das Receitas

INSERT INTO INGREDIENTE_RECEITA
    (id_receita, id_ingrediente, quantidade)
VALUES
-- Receita 1: Arroz temperado

(1, 1, 300.0),
(1, 3, 100.0),
(1, 4, 50.0),
(1, 5, 10.0),
(1, 11, 5.0),
(1, 12, 15.0),

-- Receita 2: Omelete de tomate

(2, 3, 80.0),
(2, 4, 30.0),
(2, 8, 4.0),
(2, 11, 2.0),
(2, 12, 10.0),

-- Receita 3: Bolo de banana

(3, 6, 200.0),
(3, 7, 250.0),
(3, 8, 3.0),
(3, 9, 300.0),

-- Receita 4: Frango com arroz

(4, 1, 300.0),
(4, 4, 50.0),
(4, 5, 10.0),
(4, 10, 500.0),
(4, 11, 5.0),
(4, 12, 15.0);

-- Inserindo Passos de Preparo

INSERT INTO PASSO_PREPARO
    (id_passo, id_receita, numero_passo, descricao)
VALUES

-- Arroz temperado

(1, 1, 1, 'Lave o arroz e reserve.'),
(2, 1, 2, 'Pique o tomate, a cebola e o alho.'),
(3, 1, 3, 'Refogue os temperos no azeite.'),
(4, 1, 4, 'Acrescente o arroz, a agua e o sal; cozinhe ate ficar macio.'),

-- Omelete de tomate

(5, 2, 1, 'Bata os ovos em um recipiente.'),
(6, 2, 2, 'Pique o tomate e a cebola.'),
(7, 2, 3, 'Refogue os vegetais e acrescente os ovos batidos.'),
(8, 2, 4, 'Cozinhe dos dois lados e sirva.'),

-- Bolo de banana

(9, 3, 1, 'Amasse as bananas em uma tigela.'),
(10, 3, 2, 'Misture os ovos e o leite.'),
(11, 3, 3, 'Acrescente a farinha e misture ate ficar homogeneo.'),
(12, 3, 4, 'Asse em forno preaquecido ate dourar.'),

-- Frango com arroz

(13, 4, 1, 'Corte o frango em cubos e tempere com sal.'),
(14, 4, 2, 'Pique a cebola e o alho.'),
(15, 4, 3, 'Doure o frango com os temperos e o azeite.'),
(16, 4, 4, 'Prepare o arroz e sirva junto com o frango.');

-- A receita 5 permanece como rascunho, sem ingredientes e passos.

-- Inserindo Categorias das Receitas

INSERT INTO CATEGORIA_RECEITA
    (id_categoria, nome, descricao)
VALUES
(1, 'Almoco', 'Receitas para refeicoes principais.'),
(2, 'Rapida', 'Receitas com preparo rapido.'),
(3, 'Sobremesa', 'Receitas doces para sobremesa.'),
(4, 'Vegetariana', 'Receitas sem carne ou peixe.'),
(5, 'Acompanhamento', 'Receitas para acompanhar outros pratos.');

-- Inserindo Receita Categoria

INSERT INTO RECEITA_CATEGORIA (id_receita, id_categoria) VALUES
(1, 1),
(1, 4),
(1, 5),
(2, 2),
(2, 4),
(3, 3),
(4, 1),
(5, 2);

-- Inserindo avaliações das receitas

INSERT INTO AVALIACAO_RECEITA
    (id_usuario, id_receita, nota, comentario, data_avaliacao)
VALUES
(1, 1, 5, 'Simples e muito saborosa.', '2026-11-12'),
(1, 2, 4, 'Boa opcao para um jantar rapido.', '2026-11-13'),
(2, 1, 4, 'Ficou muito bom.', '2026-11-08'),
(2, 3, 5, 'Receita pratica e gostosa.', '2026-11-09'),
(5, 3, 5, 'A familia gostou bastante.', '2026-11-11'),
(5, 4, 4, NULL, '2026-11-12');

-- Inserindo Receita Preparada 

INSERT INTO RECEITA_PREPARADA
    (id_preparo, id_usuario, id_receita,
     quantidade_porcoes, data_preparo)
VALUES
(1, 1, 1, 2, '2026-11-12'),
(2, 1, 2, 2, '2026-11-13'),
(3, 2, 4, 4, '2026-11-08'),
(4, 2, 1, 4, '2026-11-10'),
(5, 5, 3, 8, '2026-11-11'),
(6, 4, 2, 2, '2026-10-20');

COMMIT;