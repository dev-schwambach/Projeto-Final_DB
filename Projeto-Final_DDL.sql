PRAGMA foreign_keys = ON;

-- Criando tabela de Unidade de Medida

CREATE TABLE IF NOT EXISTS UNIDADE_MEDIDA (
    id_unidade INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL UNIQUE,
    sigla TEXT NOT NULL UNIQUE,
    tipo TEXT NOT NULL
        CHECK (tipo IN ('Massa', 'Volume', 'Contagem'))
);

--Criando tabela Usuario

CREATE TABLE IF NOT EXISTS USUARIO (
    id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    senha_hash TEXT NOT NULL,
    data_cadastro TEXT NOT NULL DEFAULT (date('now'))
);

-- Criando tabela dos Plano

CREATE TABLE IF NOT EXISTS PLANO_ASSINATURA (
    id_plano INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL UNIQUE,
    descricao TEXT,
    preco REAL NOT NULL CHECK (preco >= 0),
    duracao_dias INTEGER NOT NULL CHECK (duracao_dias > 0)
);

--Criando tabela de Assinatura

CREATE TABLE IF NOT EXISTS ASSINATURA (
    id_assinatura INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER NOT NULL,
    id_plano INTEGER NOT NULL,
    data_inicio TEXT NOT NULL,
    data_fim TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'Free-trial'
        CHECK (status IN ('Free-trial', 'Ativa', 'Bloqueado', 'Inativo')),
    data_cancelamento TEXT,

    FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario)
        ON DELETE RESTRICT,

    FOREIGN KEY (id_plano)
        REFERENCES PLANO_ASSINATURA(id_plano)
        ON DELETE RESTRICT,

    CHECK (data_fim >= data_inicio)
);

--Criando tabela de Fatura de Pagamento

CREATE TABLE IF NOT EXISTS FATURA_PAGAMENTO (
    id_fatura INTEGER PRIMARY KEY AUTOINCREMENT,
    id_assinatura INTEGER NOT NULL UNIQUE,
    valor REAL NOT NULL CHECK (valor >= 0),
    data_emissao TEXT NOT NULL DEFAULT (date('now')),
    data_vencimento TEXT,
    data_pagamento TEXT,
    status TEXT NOT NULL DEFAULT 'Pendente'
        CHECK (status IN ('Pendente', 'Pago', 'Recusado', 'Cancelado')),

    FOREIGN KEY (id_assinatura)
        REFERENCES ASSINATURA(id_assinatura)
        ON DELETE RESTRICT
);

--Criando tabela Ingrediente

CREATE TABLE IF NOT EXISTS INGREDIENTE (
    id_ingrediente INTEGER PRIMARY KEY AUTOINCREMENT,
    id_unidade INTEGER NOT NULL,
    nome TEXT NOT NULL UNIQUE,
    descricao TEXT,

    FOREIGN KEY (id_unidade)
        REFERENCES UNIDADE_MEDIDA(id_unidade)
        ON DELETE RESTRICT
);

--Criando tabela da despesa do usuário

CREATE TABLE IF NOT EXISTS DESPENSA_USUARIO (
    id_usuario INTEGER NOT NULL,
    id_ingrediente INTEGER NOT NULL,
    quantidade REAL NOT NULL DEFAULT 0
        CHECK (quantidade >= 0),

    PRIMARY KEY (id_usuario, id_ingrediente),

    FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE,

    FOREIGN KEY (id_ingrediente)
        REFERENCES INGREDIENTE(id_ingrediente)
        ON DELETE RESTRICT
);

--Criando tabela de alergia do usuário

CREATE TABLE IF NOT EXISTS ALERGIA_USUARIO (
    id_usuario INTEGER NOT NULL,
    id_ingrediente INTEGER NOT NULL,

    PRIMARY KEY (id_usuario, id_ingrediente),

    FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE,

    FOREIGN KEY (id_ingrediente)
        REFERENCES INGREDIENTE(id_ingrediente)
        ON DELETE RESTRICT
);

--Criando tabela de receita

CREATE TABLE IF NOT EXISTS RECEITA (
    id_receita INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    descricao TEXT,
    tempo_preparo INTEGER NOT NULL CHECK (tempo_preparo > 0),
    dificuldade TEXT NOT NULL
        CHECK (dificuldade IN ('Facil', 'Media', 'Dificil')),
    rendimento_porcoes INTEGER NOT NULL
        CHECK (rendimento_porcoes > 0),
    status TEXT NOT NULL DEFAULT 'Rascunho'
        CHECK (status IN ('Rascunho', 'Ativa', 'Inativa'))
);

--Criando tabela de Ingrediente da Receita

CREATE TABLE IF NOT EXISTS INGREDIENTE_RECEITA (
    id_receita INTEGER NOT NULL,
    id_ingrediente INTEGER NOT NULL,
    quantidade REAL NOT NULL CHECK (quantidade > 0),

    PRIMARY KEY (id_receita, id_ingrediente),

    FOREIGN KEY (id_receita)
        REFERENCES RECEITA(id_receita)
        ON DELETE CASCADE,

    FOREIGN KEY (id_ingrediente)
        REFERENCES INGREDIENTE(id_ingrediente)
        ON DELETE RESTRICT
);

--Criando tabela de passos do preparo

CREATE TABLE IF NOT EXISTS PASSO_PREPARO (
    id_passo INTEGER PRIMARY KEY AUTOINCREMENT,
    id_receita INTEGER NOT NULL,
    numero_passo INTEGER NOT NULL CHECK (numero_passo > 0),
    descricao TEXT NOT NULL,

    UNIQUE (id_receita, numero_passo),

    FOREIGN KEY (id_receita)
        REFERENCES RECEITA(id_receita)
        ON DELETE CASCADE
);


--Criando tabela Categoria Receita

CREATE TABLE IF NOT EXISTS CATEGORIA_RECEITA (
    id_categoria INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL UNIQUE,
    descricao TEXT
);

--Criando tabela Receita Csteoria

CREATE TABLE IF NOT EXISTS RECEITA_CATEGORIA (
    id_receita INTEGER NOT NULL,
    id_categoria INTEGER NOT NULL,

    PRIMARY KEY (id_receita, id_categoria),

    FOREIGN KEY (id_receita)
        REFERENCES RECEITA(id_receita)
        ON DELETE CASCADE,

    FOREIGN KEY (id_categoria)
        REFERENCES CATEGORIA_RECEITA(id_categoria)
        ON DELETE CASCADE
);

--Criando tabela de avaliação da Receita

CREATE TABLE IF NOT EXISTS AVALIACAO_RECEITA (
    id_usuario INTEGER NOT NULL,
    id_receita INTEGER NOT NULL,
    nota INTEGER NOT NULL CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT,
    data_avaliacao TEXT NOT NULL DEFAULT (date('now')),

    PRIMARY KEY (id_usuario, id_receita),

    FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE,

    FOREIGN KEY (id_receita)
        REFERENCES RECEITA(id_receita)
        ON DELETE CASCADE
);


--Criando tabela de Rceita Pronta

CREATE TABLE IF NOT EXISTS RECEITA_PREPARADA (
    id_preparo INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER NOT NULL,
    id_receita INTEGER NOT NULL,
    quantidade_porcoes INTEGER NOT NULL
        CHECK (quantidade_porcoes > 0),
    data_preparo TEXT NOT NULL DEFAULT (date('now')),

    FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario)
        ON DELETE RESTRICT,

    FOREIGN KEY (id_receita)
        REFERENCES RECEITA(id_receita)
        ON DELETE RESTRICT
);