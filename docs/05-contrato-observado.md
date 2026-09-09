# Contrato ServeRest — documentado x observado

Consultei o Swagger em https://serverest.dev antes de escrever asserções.

## Documentado no Swagger

| Operação | HTTP | Corpo relevante |
| --- | --- | --- |
| POST `/usuarios` | 201 | `message`: Cadastro realizado com sucesso, `_id` |
| POST `/usuarios` e-mail repetido | 400 | `message`: Este email já está sendo usado |
| GET `/usuarios` | 200 | `quantidade`, `usuarios[]` |
| GET `/usuarios/{_id}` | 200 | `nome`, `email`, `password`, `administrador`, `_id` |
| GET `/usuarios/{_id}` | 400 | `message`: Usuário não encontrado |
| PUT `/usuarios/{_id}` | 200 | `message`: Registro alterado com sucesso |
| PUT ID inexistente | 201 | realiza cadastro |
| DELETE | 200 | `Registro excluído com sucesso` ou `Nenhum registro excluído` |
| `administrador` | — | string enum `true` / `false` |

## Observado na API, não detalhado no Swagger

Chamei a API em 02/09/2026. Não usei esses retornos como se fossem requisito escrito pelo PO; registrei como comportamento atual.

| Chamada | HTTP | Observação |
| --- | --- | --- |
| POST `{}` | 400 | `nome`, `email`, `password`, `administrador` com texto de obrigatoriedade |
| POST sem `nome` | 400 | `nome é obrigatório` |
| POST `administrador: true` (boolean) | 400 | `administrador deve ser 'true' ou 'false'` |
| Content-Type | — | `application/json; charset=utf-8` |

Os testes dessas linhas estão com a tag `observado`.
