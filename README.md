# Pizzaria / Pedidos 2026 - MySQL / MariaDB SQL
Banco de dados com **pedidos** de uma pizzaria contendo MER DER conceitual, lógico e físico (MySQL / MariaDB SQL)

## Exemlos de scripts SQL
- [DDL](./ddl_dml.sql) (Data Definition Language - Linguagem de Definição de Dados): Cria, altera e exclui a estrutura dos objetos do banco (tabelas, [índices](./indices.sql), [visões](./views.sql)).
	- Comandos: CREATE, ALTER, DROP, TRUNCATE.
- [DML](./ddl_dml.sql) (Data Manipulation Language - Linguagem de Manipulação de Dados): Insere, atualiza e apaga os registros dentro das tabelas.
	- Comandos: INSERT, UPDATE, DELETE.
- [DQL](./queries.sql) (Data Query Language - Linguagem de Consulta de Dados): Busca e recupera informações armazenadas. (Nota: Alguns autores incluem o SELECT dentro da DML).
	- Comandos: SELECT.
- DCL (Data Control Language - Linguagem de Controle de Dados): Gerencia permissões, segurança e acesso dos usuários.
	- Comandos: GRANT, REVOKE.
- [TCL](./transactions.sql) (Transaction Control Language - Linguagem de Controle de Transação): Controla as alterações feitas pelos comandos DML, garantindo a integridade dos dados.
	- Comandos: COMMIT, ROLLBACK, SAVEPOINT.

## Exemplo de programação em banco de dados

|Estrutura|O que faz|Como é acionada|Retorno|
|-|-|-|-|
|[Function](./functions.sql) (Função)|Executa um cálculo ou rotina e devolve um resultado.|Chamada diretamente dentro de uma consulta (ex: no SELECT ou WHERE).|Obrigatório (retorna um valor único ou uma tabela).|
|[Stored Procedure](./procedures.sql) (Procedimento)|Executa uma sequência de comandos complexos e regras de negócio.|Chamada explicitamente por um comando (ex: EXEC ou CALL).|Opcional (pode não retornar nada, retornar um status ou vários conjuntos de dados).|
|[Trigger](./triggers.sql) (Gatilho)|Audita, valida ou automatiza ações em cascata nas tabelas.|Automática, disparada por eventos (INSERT, UPDATE ou DELETE).|

## MER (Modelo Entidade Relacionamento)
### DER Conceitual

```mermaid
flowchart LR

    %% Entidades e Atributos
    Cliente[Cliente]
    Cliente --- c1(( )) ~~~ t1[id]:::pk
    Cliente --- c2(( )) ~~~ t2[nome]
    Cliente --- c3(( )) ~~~ t3[cep]
    Cliente --- c4(( )) ~~~ t4[numero]
    Cliente --- c5(( )) ~~~ t5[complemento]
    Cliente --- c6(( )) ~~~ t6[referencia]

    Telefone[Telefone]
    Telefone --- c7(( )) ~~~ t7[id]:::pk
    Telefone --- c8(( )) ~~~ t8[cliente_id]
    Telefone --- c9(( )) ~~~ t9[tipo]
    Telefone --- c10(( )) ~~~ t10[numero]

    Pizza[Pizza]
    Pizza --- c11(( )) ~~~ t11[id]:::pk
    Pizza --- c12(( )) ~~~ t12[nome]
    Pizza --- c13(( )) ~~~ t13[descricao]
    Pizza --- c14(( )) ~~~ t14[preco]

    Pedido[Pedido]
    Pedido --- c15(( )) ~~~ t15[id]:::pk
    Pedido --- c16(( )) ~~~ t16[cliente_id]
    Pedido --- c17(( )) ~~~ t17[data]
    Pedido --- c18(( )) ~~~ t18[valor_total]

    Itens_pedido[Itens_pedido]
    Itens_pedido --- c19(( )) ~~~ t19[id]:::pk
    Itens_pedido --- c20(( )) ~~~ t20[pedido_id]
    Itens_pedido --- c21(( )) ~~~ t21[pizza_id]
    Itens_pedido --- c22(( )) ~~~ t22[quantidade]
    Itens_pedido --- c23(( )) ~~~ t23[valor_cobrado]
    
    %% Relacionamentos
    Cliente ---|1| Possui{Possui} ---|N| Telefone
    Cliente ---|1| Faz{Faz} ---|N| Pedido
    Pedido ---|1| Contem{Contem} ---|N| Itens_pedido
    Pizza ---|1| Esta{Esta} ---|N| Itens_pedido

    %% Estilização
    classDef pk font-weight:bold,text-decoration:underline;
    classDef pk_escuro fill:#666666;
    classDef fk font-style:italic,text-decoration:underline dotted;
    classDef entidades fill:#fff3e0,stroke:#ef6c00,stroke-width:2px;
    classDef derivados stroke-dasharray: 3 3;
    classDef relacionamentos fill:#fff3e0,stroke:#000000,stroke-width:1px;
    classDef atributos fill:none,stroke:none;
    class t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19,t20,t21,t22,t23 atributos;
    class t8,t16,t20,t21 fk;
    class c1,c7,c11,c15,c19 pk_escuro;
    class c23,c18 derivados;
    class Cliente,Telefone,Pizza,Pedido,Itens_pedido entidades
    class Possui,Faz,Contem,Esta relacionamentos
```