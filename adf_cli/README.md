# ADF CLI - Gerenciador de Laboratório de Alunos

Este é um projeto em Dart que implementa uma ferramenta de linha de comando (CLI) para gerenciar cadastros de alunos em um laboratório. Com ele, é possível realizar operações CRUD (Create, Read, Update, Delete) utilizando comandos simples no terminal.

## 📦 Tecnologias Usadas

- Dart
- dart_console (CLI)
- Leitura de arquivos CSV
- Comunicação com API local (via HTTP)
- Suporte futuro a `dio`

## ⚙️ Funcionalidades

- `GET` lista de alunos
- `POST` para cadastrar alunos
- `PUT` para atualizar dados de alunos
- `DELETE` para excluir aluno por ID

## 📁 Estrutura

```
lib/
└── src/
    └── commands/
        └── students/
            ├── students_command.dart
            └── subcommands/
                ├── delete_by_id.dart
                ├── find_all_command.dart
                ├── save_command.dart
                └── update_command.dart
```

## ▶️ Como Executar

1. Certifique-se de ter o Dart SDK instalado.
2. No terminal, navegue até a pasta do projeto.
3. Execute:

```bash
dart run bin/adf_cli.dart students [comando]
```

### Exemplos:

```bash
# comando help
dart adf_cli.dart students -h     

# Listar todos os alunos
dart run bin/adf_cli.dart students findAll

# Cadastrar alunos a partir do CSV
dart run bin/adf_cli.dart students insert

# Atualizar alunos a partir do CSV
dart run bin/adf_cli.dart students update

# Deletar aluno por ID
dart run bin/adf_cli.dart students delete
```

## 🗂 Arquivos CSV

- `alunos.csv`: dados para cadastro
- `aluno_update.csv`: dados para atualização

## 🚧 Em Desenvolvimento

- Migração de repositórios HTTP para `dio`
- Validações mais robustas

## Esse Projeto foi feito para fins de Aprendizado através do curso Academia do Flutter(ADF)
##

### ▶️ Explicando package JRS utilizado.

# ADF CLI API - Backend Simples em Dart

Este é um pequeno servidor local feito com Dart, utilizando o pacote [`jrs`](https://pub.dev/packages/jrs), que fornece uma API REST para o gerenciamento de alunos e produtos.

## 📦 Tecnologias Usadas

- Dart
- Package `jrs` (micro framework HTTP)
- JSON como banco de dados local

## ▶️ Como Executar

1. Certifique-se de ter o Dart SDK instalado.
2. No terminal, navegue até a pasta da API.
3. Execute:

```bash
jrs run
```

O servidor será iniciado conforme as configurações do `config.yaml`.

## 📁 Estrutura

- `database.json`: base de dados local
- `config.yaml`: configurações de porta e rotas

## 🔄 Endpoints Disponíveis

### Alunos
- `GET /students`
- `POST /students`
- `PUT /students/{id}`
- `DELETE /students/{id}`

### Produtos
- `GET /products`
- `POST /products`
- `PUT /products/{id}`
- `DELETE /products/{id}`

