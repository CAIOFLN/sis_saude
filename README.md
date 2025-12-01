#  Sistema de Saúde (Sis_Saúde)

Sistema de gerenciamento de turnos, pedidos de recursos e relatórios de casos para profissionais de saúde.

## 🚀 Instalação e Configuração

### 1. Configurar o Banco de Dados PostgreSQL

#### 1.1. Conectar ao PostgreSQL

```bash
psql -d postgres -U seu_usuario
```

#### 1.2. Criar o Banco de Dados

```sql
CREATE DATABASE sis_saude;
```

#### 1.3. Saia do psql

```sql
\q
```


### 2. Executar os Scripts SQL

#### 2.1. Criar o Esquema do Banco

```bash
psql -d sis_saude -U seu_usuario -f sql/schema.sql
```

#### 2.2. Inserir Dados Iniciais

```bash
psql -d sis_saude -U seu_usuario -f sql/inser_data/insere_tudo.sql
```

### 3. Configurar Variáveis de Ambiente

Crie um arquivo `.env` na raiz do diretório `app`:

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=sis_saude
DB_USER=seu_usuario
DB_PASSWORD=sua_senha
```

**⚠️ Importante:** Substitua `seu_usuario` e `sua_senha` pelos valores do seu PostgreSQL.

### 4. Instalar Dependências Python

```bash
pip install -r requirements.txt
```

## ▶️ Executando a Aplicação

No diretório `app`, execute:

```bash
cd app
python main.py
```

## 📁 Estrutura do Projeto

```
sis_saude/
├── app/
│   ├── .env                      # Configurações do banco (não versionar!)
│   ├── database.py               # Gerenciamento de conexão com o banco
│   ├── main.py                   # Arquivo principal da aplicação
│   ├── paciente_service.py       # Serviços relacionados a pacientes
│   ├── pedido_service.py         # Serviços relacionados a pedidos
│   └── trabalhador_service.py    # Serviços relacionados a trabalhadores
├── sql/
│   ├── schema.sql                # Esquema do banco de dados
│   ├── consultas.sql             # Consultas úteis
│   └── inser_data/
│       ├── insere_tudo.sql       # Script principal de inserção
│       ├── entidades_saude.sql   # Dados de entidades de saúde
│       ├── pessoas.sql           # Dados de pessoas
│       ├── recursos.sql          # Dados de recursos
│       ├── notificacoes.sql      # Dados de notificações
│       ├── turnos_escalas.sql    # Dados de turnos e escalas
│       ├── pedidos_requisicoes.sql # Dados de pedidos e requisições
│       ├── relatorios_casos.sql  # Dados de relatórios e casos
│       └── dados_teste_consultas.sql # Dados para teste de consultas
└── README.md                     # Este arquivo

```

## 🔧 Tecnologias Utilizadas

- **Python** - Linguagem de programação principal
- **PostgreSQL** - Sistema de gerenciamento de banco de dados
- **psycopg** - Adaptador PostgreSQL para Python

## 📝 Notas

- Certifique-se de que o PostgreSQL está rodando antes de executar a aplicação
- O arquivo `.env` não deve ser versionado no Git (adicione ao `.gitignore`)
- Para consultas SQL úteis, verifique o arquivo `sql/consultas.sql`
