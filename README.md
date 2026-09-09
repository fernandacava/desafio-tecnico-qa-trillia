# Teste Técnico QA — Trillia

Projeto desenvolvido por **Fernanda Rodrigues** para o teste técnico de **Analista de Qualidade**.

A abordagem adotada prioriza a compreensão do comportamento esperado e dos riscos envolvidos antes da automação. A partir disso, os cenários são estruturados, documentados em Gherkin quando aplicável e automatizados de acordo com sua relevância e risco.

Quando o contrato não define claramente o resultado esperado, evito transformar suposições em regras de negócio. Nesses casos, registro a dúvida para alinhamento com o PO ou classifico o comportamento identificado durante a execução como **observado**, mantendo clara a distinção entre requisito documentado e comportamento atual do sistema.

## Sobre o projeto

O desafio foi dividido em três frentes:

1. **Web-UI** — W3Schools: Modal Box, Filter List e HTML Forms.
2. **API** — ServeRest, com foco na funcionalidade de usuários.
3. **Shift-Left** — análise da especificação de enriquecimento de dados de livros.

## Estratégia de Qualidade

Detalhes em [docs/01-estrategia.md](docs/01-estrategia.md).

A estratégia segue quatro etapas principais:

**Comportamento → Risco → Cenários → Automação**

Primeiro identifico o comportamento esperado e os riscos envolvidos. Em seguida, estruturo os cenários e critérios de validação. A automação é aplicada aos fluxos que oferecem maior valor para regressão, confiabilidade e repetibilidade.

Quando uma regra não está definida pelo contrato, a lacuna é documentada em vez de incorporada à automação como uma premissa.

## Cenários Web

Gherkin e decisões de seletores: [docs/02-web-cenarios.md](docs/02-web-cenarios.md).

| ID       | O que valida                        | Motivação                                                      |
| -------- | ----------------------------------- | -------------------------------------------------------------- |
| WEB-001  | Abrir e fechar a primeira modal     | Validar mudança de estado e visibilidade, não apenas o clique  |
| WEB-002A | Filtro com nome existente           | Validar o conteúdo efetivamente apresentado após a pesquisa    |
| WEB-002B | Filtro com nome inexistente         | Cobrir o caminho negativo do componente                        |
| WEB-002C | Adele, Billy e Cindy na lista       | Validar a massa existente antes da aplicação do filtro         |
| WEB-003  | Formulário com Fernanda / Rodrigues | Validar nova página, iframe e os valores efetivamente enviados |

## Cenários API

Mapa completo: [docs/03-api-cenarios.md](docs/03-api-cenarios.md).
Contrato documentado x comportamento observado: [docs/05-contrato-observado.md](docs/05-contrato-observado.md).

A cobertura contempla:

* cadastro;
* consulta;
* alteração;
* exclusão;
* administrador e usuário comum;
* cenários positivos e negativos;
* status HTTP;
* Content-Type;
* conteúdo das respostas;
* contrato;
* persistência dos dados;
* fluxo E2E.

Toda criação utiliza e-mail único no padrão `qa.trillia` + timestamp, reduzindo dependência de massa previamente cadastrada e conflitos no ambiente público.

O fluxo E2E cobre:

`CREATE → GET → UPDATE → GET → DELETE → GET`

## Análise Shift-Left

Detalhes em [docs/04-shift-left-livros.md](docs/04-shift-left-livros.md).

A especificação de enriquecimento de dados de livros foi analisada antes de qualquer proposta de automação.

Foram levantadas questões relacionadas a:

* formato e contrato do arquivo de entrada;
* campos obrigatórios;
* matching dos livros;
* livros não encontrados;
* duplicidades;
* contrato do arquivo de saída;
* erros parciais e totais;
* volume de processamento.

Também foram propostos critérios de aceite e cenários iniciais.

Os critérios **CA-004** e **CA-005** permanecem pendentes de definição do PO, pois automatizá-los sem uma regra definida significaria transformar uma suposição em comportamento esperado.

## Tecnologias utilizadas

* **Robot Framework 7**
* **Browser Library (Playwright)** para Web
* **RequestsLibrary** para API
* **Python 3.12**

## Decisões Tecnológicas

O enunciado indica preferência pelo Robot Framework, por isso a ferramenta foi mantida como base da solução.

### Web

Para os testes Web utilizei **Browser Library**, baseada em Playwright, em vez de SeleniumLibrary.

A decisão considera principalmente:

1. O cenário HTML Forms abre outra página e trabalha com conteúdo dentro de iframe.
2. Playwright oferece bom suporte para gerenciamento de páginas, contextos e frames.
3. Screenshots e vídeos podem ser utilizados como evidências da execução.
4. A solução continua utilizando Robot Framework, preservando a tecnologia indicada no desafio.

### API

Para API utilizei **RequestsLibrary**, mantendo as chamadas HTTP integradas ao Robot Framework.

As validações não se limitam ao status HTTP. Quando aplicável, também são verificados:

* conteúdo da resposta;
* Content-Type;
* mensagens retornadas;
* persistência após criação e alteração;
* inexistência do recurso após exclusão.

## Estrutura do projeto

```text
desafio-tecnico-qa-trillia/
├── README.md
├── requirements.txt
├── executar.ps1
├── docs/                  estratégia, Gherkin, API, Shift-Left e contrato
├── resources/             keywords reutilizáveis
│   ├── web/
│   └── api/
├── tests/
│   ├── web/
│   └── api/
├── evidencias/            evidências complementares
└── results/               relatório, log, screenshots e vídeos
```

A estrutura foi mantida propositalmente simples, separando responsabilidades sem criar níveis desnecessários para o tamanho atual da suíte.

## Pré-requisitos

* Windows
* Python 3.12
* Node.js

A Browser Library utiliza Playwright e necessita do Node.js para sua inicialização.

## Instalação

Na raiz do projeto:

```powershell
python -m pip install -r requirements.txt
rfbrowser init
```

Caso `python` não esteja disponível no PATH:

```text
C:\Users\<seu-usuario>\AppData\Local\Programs\Python\Python312\python.exe
```

## Como executar

### Execução completa

```powershell
.\executar.ps1
```

### Somente API

```powershell
.\executar.ps1 -Suite api
```

### Somente Web

```powershell
.\executar.ps1 -Suite web
```

### Web com navegador visível

```powershell
.\executar.ps1 -Headed
```

Também é possível executar diretamente pelo Robot Framework:

```powershell
python -m robot --outputdir results tests
python -m robot --outputdir results tests/api
python -m robot --outputdir results tests/web
```

## Como visualizar os resultados

Após a execução:

* `results/report.html` — visão geral dos resultados;
* `results/log.html` — detalhamento da execução e respostas da API;
* `results/browser/screenshot/` — screenshots dos testes Web;
* `results/videos/` — gravações das execuções Web.

Uma cópia dos screenshots da última execução local também está disponível em:

```text
evidencias/web/
```

## Resultado da última execução

| Camada    | Testes | Passed | Failed |
| --------- | -----: | -----: | -----: |
| API       |     14 |     14 |      0 |
| Web       |      5 |      5 |      0 |
| **Total** | **19** | **19** |  **0** |

**Resultado:** 100% dos testes automatizados executados com sucesso na última execução registrada.

## Evidências

### Web

São utilizadas evidências de:

* screenshots em validações relevantes;
* vídeo da execução;
* `log.html`;
* `report.html`.

### API

A keyword `Registrar evidencia da resposta` registra no `log.html`:

* status HTTP;
* Content-Type;
* body da resposta.

## Limitações conhecidas

* W3Schools e ServeRest são ambientes públicos e podem sofrer alterações independentes deste projeto.
* Layout, anúncios ou mudanças no DOM do W3Schools podem impactar testes Web.
* A limpeza periódica da base ServeRest pode alterar dados existentes.
* A primeira modal do tutorial atualmente utiliza `#id01`, e não `#myModal`. A automação considera o DOM observado durante a implementação.
* A funcionalidade de enriquecimento de livros ainda possui lacunas de contrato e, por isso, não foi automatizada.
* O cenário de exclusão de usuário associado a carrinho não foi incluído no escopo automatizado, pois exigiria ampliar o fluxo para produtos, autenticação e carrinho.

## Melhorias futuras

Como evolução da solução:

* execução automatizada em CI/CD;
* Quality Gate para impedir merge em caso de regressão;
* publicação dos relatórios como artefatos do pipeline;
* schema JSON versionado para validações de contrato;
* ampliação dos cenários negativos da API;
* execução cross-browser dos testes Web;
* automação dos cenários de enriquecimento de livros após definição do contrato pelo PO.

## Decisões de Qualidade e Critérios da Solução

A solução foi construída priorizando **clareza, rastreabilidade, risco e manutenibilidade**.

Os testes Web validam comportamento, estado e conteúdo, não apenas ações de clique.

Os testes de API verificam não somente status HTTP, mas também contrato, conteúdo e persistência dos dados quando aplicável.

Na análise Shift-Left, requisitos ambíguos foram tratados como pontos de refinamento em vez de serem transformados em regras assumidas pela automação.

Por fim, a estrutura e a documentação foram organizadas para que outra pessoa consiga clonar o projeto, instalar as dependências, executar os testes e compreender os resultados.
