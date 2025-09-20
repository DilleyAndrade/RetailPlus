# 📊 Data Pipeline - Projeto de ETL e Modelagem

Este projeto implementa um pipeline de dados simples para simular o processo de **Extração, Transformação e Carga (ETL)**, seguido de **modelagem relacional e dimensional**. Ele utiliza arquivos CSV como fonte de dados, scripts Python para carregamento e SQL para preparação e análise dos dados.

---

## 🗂 Estrutura do Projeto

```
.
├── data/                # Dados brutos utilizados como fonte
│   ├── customers.csv
│   ├── orders.csv
│   └── products.csv
│
├── diagrams/            # Espaço reservado para diagramas do modelo de dados (opcional)
│
├── scripts/
│   └── load_data.py     # Script para carregar os arquivos CSV no banco de dados
│
├── sql/
│   ├── create_tables.sql    # Criação das tabelas no banco
│   ├── clean_data.sql       # Limpeza e padronização dos dados carregados
│   ├── build_fact_dim.sql   # Criação de tabelas fato e dimensão para análise
│   └── queries.sql          # Consultas analíticas e de validação
│
└── README.md
```

---

## ⚙️ Fluxo de Execução

1. **Crie as tabelas no banco de dados**
   - Execute o script SQL `create_tables.sql` para criar a estrutura do banco.
   - Arquivo: `sql/create_tables.sql`

2. **Carregar os Dados**
   - Execute o script Python que lê os arquivos `.csv` da pasta `data/` e insere os dados em tabelas temporárias no banco.
   - Arquivo: `scripts/load_data.py`

3. **Criar Tabelas**
   - Executar o SQL que cria a estrutura inicial do banco relacional.
   - Arquivo: `sql/create_tables.sql`

4. **Limpar os Dados**
   - Aplicar transformações para corrigir inconsistências e padronizar valores.
   - Arquivo: `sql/clean_data.sql`

5. **Construir Modelo Dimensional**
   - Criar tabelas fato e dimensões a partir dos dados limpos para análises futuras.
   - Arquivo: `sql/build_fact_dim.sql`

6. **Executar Consultas**
   - Validar o modelo e gerar insights por meio de consultas SQL.
   - Arquivo: `sql/queries.sql`

---

## 📦 Pré-requisitos

- Python 3.x
- Biblioteca `pandas` (para manipulação dos CSVs)
- Banco de dados PostgreSQL
- Cliente SQL ou IDE (DBeaver, VSCode com extensão SQL, etc.)

---

## 🚀 Como Executar

1. Clone este repositório:
   ```bash
   git clone <url-do-repositorio>
   cd <nome-da-pasta>
   ```

2. Instale as dependências do Python:
   ```bash
   pip install pandas sqlalchemy
   ```

3. Execute o carregamento dos dados:
   ```bash
   python scripts/load_data.py
   ```

4. Rode os scripts SQL na ordem:
   - `create_tables.sql`
   - `clean_data.sql`
   - `build_fact_dim.sql`
   - `queries.sql`

---

## 📌 Observações

- Os arquivos CSV simulam entidades de um cenário de vendas: **clientes, pedidos e produtos**.
- A pasta `diagrams/` pode ser usada para armazenar diagramas ER e de modelo dimensional criados durante o projeto.
- Este projeto serve como base para estudos de engenharia de dados e modelagem de banco de dados.

