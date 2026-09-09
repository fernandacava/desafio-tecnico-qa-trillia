# Teste técnico QA — Trillia

Projeto de Fernanda Rodrigues para o teste técnico de Analista de Qualidade.

Não tentei entregar a maior suíte possível. Tentei entregar uma suíte que eu consiga explicar: interpretação de requisito, risco, cenário, automação sustentável e análise de resultado.

## Sobre o projeto

Três frentes, na ordem em que eu trabalharia num time:

1. **Web** — W3Schools: Modal Box, Filter List e HTML Forms.
2. **API** — ServeRest, funcionalidade de usuários.
3. **Shift-Left** — especificação de enriquecimento de dados de livros, ainda sem implementação.

## Estratégia de qualidade

Detalhe em [docs/01-estrategia.md](docs/01-estrategia.md).

Resumo da minha regra: primeiro o comportamento, depois o Gherkin, depois a automação do que é principal. Onde o contrato não define o esperado, eu não invento. Registro dúvida ou marco o teste como observado.

## Cenários Web

Gherkin e decisões de seletor: [docs/02-web-cenarios.md](docs/02-web-cenarios.md).

| ID | O que valida | Por que automatizei |
| --- | --- | --- |
| WEB-001 | Abrir e fechar a primeira modal | O requisito é mudança de estado, não só clique |
| WEB-002A | Filtro com nome existente | Conteúdo visível, não quantidade |
| WEB-002B | Filtro com nome inexistente | Caminho negativo do mesmo componente |
| WEB-002C | Adele, Billy e Cindy na lista | Premissa da massa antes do filtro |
| WEB-003 | Form com Fernanda / Rodrigues | Nova página + iframe + valor realmente enviado |

## Cenários API

Mapa completo: [docs/03-api-cenarios.md](docs/03-api-cenarios.md).  
Contrato documentado x observado: [docs/05-contrato-observado.md](docs/05-contrato-observado.md).

Cobertura: cadastro, consulta, alteração, exclusão, admin, usuário comum, negativos, contrato, status HTTP, body e um fluxo E2E.

Toda criação usa e-mail único (`qa.trillia` + timestamp). Não dependo de usuário pré-cadastrado.

## Análise Shift-Left

[docs/04-shift-left-livros.md](docs/04-shift-left-livros.md).

Levei perguntas de arquivo, matching, livro não encontrado e contrato de saída. Propus critérios de aceite e marquei CA-004 e CA-005 como pendentes do PO. Não há automação desta frente de propósito.

## Tecnologias utilizadas

- Robot Framework 7
- Browser Library (Playwright) para Web
- RequestsLibrary para API
- Python 3.12

## Por que escolhi essas tecnologias

O enunciado prefere Robot Framework. Mantive o Robot.

Para Web, usei Browser Library em vez de SeleniumLibrary por três motivos que o próprio desafio pede:

1. HTML Forms abre outra página e o form vive em iframe. Playwright trata isso com menos instabilidade.
2. Screenshot e vídeo saem nativos da library.
3. Continua sendo Robot Framework. Não troquei a ferramenta pedida; escolhi a library mais adequada ao risco técnico.

Para API, RequestsLibrary é a escolha padrão no Robot e deixa request, status e body no log.

## Estrutura do projeto

```
desafio-tecnico-qa-trillia/
├── README.md
├── requirements.txt
├── executar.ps1
├── docs/                  estratégia, Gherkin, API, Shift-Left, contrato
├── resources/             keywords reutilizáveis
│   ├── web/
│   └── api/
├── tests/
│   ├── web/
│   └── api/
├── evidencias/            recortes extras, se necessário
└── results/               relatório, log, screenshots e vídeos da execução
```

A estrutura é propositalmente rasa. Com poucos cenários, uma árvore grande atrapalha manutenção e entrevista.

## Pré-requisitos

- Windows
- Python 3.12
- Node.js (a Browser Library usa Playwright)

## Instalação

```powershell
python -m pip install -r requirements.txt
rfbrowser init
```

Se `python` não estiver no PATH, use:

`C:\Users\<seu-usuario>\AppData\Local\Programs\Python\Python312\python.exe`

## Como executar

Na raiz do projeto:

```powershell
.\executar.ps1              # Web + API, headless
.\executar.ps1 -Suite api
.\executar.ps1 -Suite web
.\executar.ps1 -Headed      # abre o navegador
```

Equivalente:

```powershell
python -m robot --outputdir results tests
python -m robot --outputdir results tests/api
python -m robot --outputdir results tests/web
```

## Como visualizar os resultados

Depois da execução, abra:

- `results/report.html` — visão executiva
- `results/log.html` — passo a passo, inclusive body da API
- `results/browser/screenshot/` — prints Web de cada asserção
- `results/videos/` — gravação da sessão

Uma cópia dos prints da última execução local está em `evidencias/web/`.

### Última execução nesta máquina

- API: **14 testes, 14 passed**
- Web: **5 testes, 5 passed**

## Evidências

Web: screenshot em cada asserção relevante, vídeo do contexto, log e report.

API: cada keyword `Registrar evidencia da resposta` grava HTTP, Content-Type e body no `log.html`.

## Limitações

- W3Schools e ServeRest são ambientes públicos. Layout, ads ou limpeza de base podem afetar uma execução pontual.
- A primeira modal do tutorial atual é `#id01`, não `#myModal`. Documentei isso porque o DOM real importa mais do que o snippet clássico.
- A frente de livros não tem teste automatizado: o contrato ainda tem buracos.
- Não cobri carrinho + exclusão bloqueada. Sairia do recorte de usuários.

## Melhorias futuras

- CI com o mesmo `executar.ps1`.
- Schema JSON versionado quando o Swagger passar a documentar validação de campos.
- Automação de livros depois das respostas do PO.
- Tag `observado` revisada se o contrato oficial absorver esses erros.

## Como eu quero que este projeto seja avaliado

Consigo explicar cada cenário, cada seletor e cada asserção.  
A automação Web valida estado e conteúdo, não só clique.  
A API valida contrato e persistência, não só HTTP 201.  
As perguntas de livros mudam desenvolvimento; não são dúvida cosmética.  
Outra pessoa consegue clonar, instalar e executar.
