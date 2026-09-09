# Shift-Left — Enriquecimento de Dados de Livros

Li a especificação como QA de refinamento, não como alguém que já vai automatizar.

O objetivo do produto está claro: receber um arquivo de livros e devolver os mesmos registros enriquecidos. O contrato funcional não está.

## Perguntas para o PO

### Arquivo de entrada

- Qual formato é aceito: CSV, XLSX, JSON?
- Qual encoding?
- Existe tamanho máximo do arquivo?
- Existe quantidade máxima de registros?
- Quais colunas são obrigatórias?

### Identificação do livro

- Título + edição identificam o livro de forma única?
- ISBN não deveria entrar na identificação?
- Como tratar títulos iguais com edições diferentes ou iguais?
- A busca diferencia maiúsculas, acentos e espaços?

### Livro não encontrado

Esse é o maior buraco da especificação.

Se o livro não existir na base:

- a linha é mantida?
- a linha é removida?
- a linha é marcada como "não encontrado"?
- o processamento inteiro falha?

Sem essa decisão, desenvolvimento e teste vão assumir regras diferentes.

### Dados enriquecidos

O texto cita autor, editora, data de publicação, sinopse e "outras informações".

"Outras informações" não é contrato. Precisamos da lista fechada de campos de saída, tipos e obrigatoriedade.

### Arquivo final

- Formato, nome, encoding e ordem das colunas.
- Os dados originais são preservados?
- Existe coluna de status do enriquecimento?

## Risco que eu levaria ao refinamento

A especificação atual não é suficiente para começar o desenvolvimento sem esclarecimentos.

Lacunas principais:

- formato de entrada e de saída
- obrigatoriedade dos campos
- regra de matching
- livro não encontrado
- duplicidade
- erros parciais x totais
- volume
- contrato dos dados enriquecidos

Minha atuação aqui é travar interpretações paralelas antes do código.

## Critérios de aceite propostos

### CA-001 — Arquivo válido

Dado um arquivo no formato definido pelo produto  
E contendo os campos obrigatórios  
Quando o processamento for executado  
Então o sistema deverá processar os registros válidos  
E gerar o arquivo de saída conforme o contrato definido.

### CA-002 — Livro encontrado

Dado um registro correspondente a um livro existente  
Quando ocorrer o enriquecimento  
Então os campos adicionais definidos pelo produto deverão ser incluídos no resultado.

### CA-003 — Preservação

Dado um registro válido recebido do cliente  
Quando ocorrer o enriquecimento  
Então os dados originais não deverão ser alterados indevidamente.

### CA-004 — Livro inexistente

Pendente de definição do PO.

### CA-005 — Arquivo inválido

Pendente de definição do PO: tipos rejeitados, mensagem, processamento parcial ou total.

## Cenários iniciais

| ID | Caso | Resultado esperado |
| --- | --- | --- |
| BOOK-001 | Happy path com livro existente | Definido após contrato de saída |
| BOOK-002 | Vários registros válidos | Idem |
| BOOK-003 | Livro inexistente | Pendente PO |
| BOOK-004 | Título ausente | Pendente PO |
| BOOK-005 | Edição ausente | Pendente PO |
| BOOK-006 | Duplicidade | Pendente PO |
| BOOK-007 | Arquivo vazio | Pendente PO |
| BOOK-008 | Acentuação e caracteres especiais | Pendente regra de matching |
| BOOK-009 | Volume elevado | Pendente limite |

Não criei automação desta frente. Automatizar agora seria testar uma regra que eu mesma inventei.
