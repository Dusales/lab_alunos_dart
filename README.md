# 📌 Changelog - Lab Alunos Dart

Este arquivo documenta as mudanças significativas realizadas no projeto `lab_alunos_dart`, que inclui uma aplicação CLI e uma API local para gerenciamento de alunos em laboratório.

---

## 📦 [v2.0.0] - 2025-05-22
### Alterações principais:
- 🔁 **Migração do package `http` para `dio`** no projeto CLI (`adf_cli`)
  - Substituição de todas as chamadas HTTP para uso do package `dio`
  - Preparação para tratamento de erros mais detalhado no futuro


### Dependências:
```yaml
dependencies:
  dio: ^5.4.0
  args: ^2.7.0
