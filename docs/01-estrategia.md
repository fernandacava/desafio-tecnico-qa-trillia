# Estratégia de qualidade

Escrevi esta prova para mostrar como eu penso qualidade, não para inflar quantidade de testes.

## Como dividi o trabalho

1. **Web UI** — conferir os três desafios no W3Schools, escrever Gherkin e só então automatizar o principal.
2. **API** — cobrir usuários da ServeRest com comportamento e contrato, não só verbos HTTP.
3. **Shift-Left** — ler a especificação de livros e expor lacunas antes de fingir que já existe implementação.

## O que eu recusei fazer

- Automatizar tudo que é clicável.
- Inventar resultado esperado quando o contrato não define o comportamento.
- Criar Page Object de três camadas para seis cenários Web.
- Depender de usuário fixo numa API pública e compartilhada.

## Como eu escolhi o que automatizar

Automatizei o fluxo que o enunciado pede e o que prova risco real:

- Web: mudança de estado da modal, conteúdo do filtro, dados efetivamente enviados no form.
- API: persistência depois de POST/PUT/DELETE, contrato, negativos documentados e observados.

Não automatizei volume, performance nem a especificação de livros: ainda faltam regras de produto.

## Positivo x negativo

| Tipo | O que eu valido |
| --- | --- |
| Positivo | Caminho feliz e persistência |
| Negativo | Dado inválido, ausência, duplicidade, ID inexistente |
| Observado | Comportamento real da API quando o Swagger não detalha o body |

## Shift-Left nesta prova

Na frente de livros eu não escrevi automação. Escrevi perguntas, riscos e critérios pendentes. Entregar script sem regra de negócio seria tesar uma interpretação minha, não o produto.
