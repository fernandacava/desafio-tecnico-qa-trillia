# Cenários API — usuários ServeRest

Fonte principal: [Swagger ServeRest](https://serverest.dev).

Quando o Swagger não descreve o body de erro, eu não inventei a mensagem. Executei a chamada, registrei o retorno e marquei o teste como **observado**.

## Massa de dados

E-mail no formato `qa.trillia.<timestamp>@teste.com`. A API pública é compartilhada e pode ser limpa; usuário fixo deixaria a suíte instável.

## Cadastro

| ID | Caso | Base |
| --- | --- | --- |
| API-001 | Usuário válido + GET de persistência | Swagger 201 |
| API-002 | Administrador (`administrador=true`) | Swagger + GET |
| API-003 | Usuário comum (`administrador=false`) | Swagger + GET |
| API-004 | E-mail duplicado | Swagger 400 `Este email já está sendo usado` |
| API-005 | Payload vazio | Observado: 400 com campos obrigatórios |
| API-005B | Sem `nome` | Observado: 400 `nome é obrigatório` |
| API-005C | `administrador` boolean | Observado: 400, deve ser `'true'` ou `'false'` |

## Consulta

| ID | Caso | Base |
| --- | --- | --- |
| API-006 | Lista + contrato (`quantidade` = tamanho do array) | Swagger 200 |
| API-007 | GET do ID criado nesta execução | Swagger 200 |
| API-008 | ID inexistente | Swagger 400 `Usuário não encontrado` |

## Alteração

| ID | Caso | Base |
| --- | --- | --- |
| API-009 | PUT + GET | Swagger 200 `Registro alterado com sucesso` |

Não considero suficiente o 200 do PUT. Quero o dado novo no GET.

## Exclusão

| ID | Caso | Base |
| --- | --- | --- |
| API-010 | DELETE + GET | Swagger 200 + 400 na consulta |
| API-010B | DELETE de ID inexistente | Swagger 200 `Nenhum registro excluído` |

## E2E

`API-E2E`: CREATE → GET → UPDATE → GET → DELETE → GET.

## Exemplos de requisições cURL

Os exemplos abaixo representam as principais operações exercitadas pela suíte. Na automação, os dados de cadastro são gerados dinamicamente para evitar colisões no ambiente público.

### Criar usuário

```bash
curl --request POST \
  --url https://serverest.dev/usuarios \
  --header 'Content-Type: application/json' \
  --data '{
    "nome": "Fernanda Rodrigues",
    "email": "qa.trillia.exemplo@teste.com",
    "password": "teste123",
    "administrador": "false"
  }'
```

### Consultar usuários

```bash
curl --request GET \
  --url https://serverest.dev/usuarios
```

### Consultar usuário por ID

```bash
curl --request GET \
  --url https://serverest.dev/usuarios/{_id}
```

### Alterar usuário

```bash
curl --request PUT \
  --url https://serverest.dev/usuarios/{_id} \
  --header 'Content-Type: application/json' \
  --data '{
    "nome": "Fernanda QA Atualizada",
    "email": "qa.trillia.atualizada@teste.com",
    "password": "teste123",
    "administrador": "false"
  }'
```

### Excluir usuário

```bash
curl --request DELETE \
  --url https://serverest.dev/usuarios/{_id}
```

### Exemplo negativo — payload vazio

```bash
curl --request POST \
  --url https://serverest.dev/usuarios \
  --header 'Content-Type: application/json' \
  --data '{}'
```

> Observação: `{_id}` representa o identificador retornado pela API após a criação do usuário. Os scripts Robot Framework utilizam IDs e e-mails gerados/obtidos durante a própria execução.

## O que eu não automatizei de propósito

- Excluir usuário com carrinho: exige montar produto, login admin e carrinho. Sai do recorte de usuários e inflaria a prova.
- Caracteres especiais no nome: `nome` é string no contrato; um caso com acento cabe como melhoria, não como regra inventada.
