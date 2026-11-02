-- SCRIPT DE CRIAÇÃO DO BANCO DE DADOS RELACIONAL (SQLite)
-- Projeto: Diagnóstico de E-commerce & Storytelling de Dados

-- 1. Limpeza preventiva (Na ordem correta: das dependentes para as principais)
DROP TABLE IF EXISTS "ITENS VENDA";
DROP TABLE IF EXISTS "VENDAS";
DROP TABLE IF EXISTS "PRODUTOS";
DROP TABLE IF EXISTS "CLIENTES";
DROP TABLE IF EXISTS "VENDEDORES";

-- 2. TABELA DIMENSÃO: CLIENTES
CREATE TABLE "CLIENTES" (
	"id_cliente"	INTEGER,
	"nome_cliente"	TEXT NOT NULL,
	"email"	        TEXT,
	"cidade"	    TEXT,
	"estado"	    TEXT,
	"data_cadastro"	DATE,
	PRIMARY KEY("id_cliente" AUTOINCREMENT)
);

-- 3. TABELA DIMENSÃO: PRODUTOS 
CREATE TABLE "PRODUTOS" (
	"id_produto"	INTEGER,
	"nome_produto"	TEXT NOT NULL,
	"categoria"	    TEXT,
	"preço_unitário" REAL NOT NULL,
	"custo_unitário" REAL NOT NULL,
	PRIMARY KEY("id_produto" AUTOINCREMENT)
);

-- 4. TABELA DIMENSÃO: VENDEDORES
CREATE TABLE "VENDEDORES" (
	"id_vendedor"	INTEGER,
	"nome_vendedor"	TEXT NOT NULL,
	"equipe "	TEXT,
	"comissão"	REAL,
	PRIMARY KEY("id_vendedor" AUTOINCREMENT)
);

-- 5. TABELA FATO: VENDAS 
CREATE TABLE "VENDAS" (
	"id_venda"	    INTEGER,
	"data_venda"	DATETIME NOT NULL,
	"id_cliente"	INTEGER,
	"canal_venda"	TEXT,
	"status"	    TEXT,
	"id_vendedor"	INTEGER,
	PRIMARY KEY("id_venda" AUTOINCREMENT),
	FOREIGN KEY("id_cliente") REFERENCES "CLIENTES"("id_cliente"),
	FOREIGN KEY("id_vendedor") REFERENCES "VENDEDORES"("id_vendedor")
);

-- 6. TABELA FATO / DETALHE: ITENS VENDA
CREATE TABLE "ITENS VENDA" (
	"id_item"	    INTEGER,
	"id_venda"	    INTEGER NOT NULL,
	"id_produto"	INTEGER NOT NULL,
	"quantidade"	INTEGER NOT NULL,
	"preço_cobrado"	REAL NOT NULL,
	"desconto"	    REAL,
	PRIMARY KEY("id_item" AUTOINCREMENT),
	FOREIGN KEY("id_produto") REFERENCES "PRODUTOS"("id_produto"),
	FOREIGN KEY("id_venda") REFERENCES "VENDAS"("id_venda")
);

-- 7. Índices para otimização de consultas analíticas
CREATE INDEX IF NOT EXISTS idx_vendas_canal ON "VENDAS"("canal_venda");
CREATE INDEX IF NOT EXISTS idx_vendas_status ON "VENDAS"("status");
