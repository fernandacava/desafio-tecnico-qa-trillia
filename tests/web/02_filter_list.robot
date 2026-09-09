*** Settings ***
Documentation    WEB-002 | Filtro de nomes do primeiro exemplo Filter List.
Resource         ../../resources/web/navegacao.resource
Resource         ../../resources/web/filtro.resource

Suite Setup      Abrir Navegador
Suite Teardown   Fechar Navegador

*** Test Cases ***
WEB-002A Pesquisar um nome existente
    [Documentation]    Confere conteúdo visível, não apenas quantidade de itens.
    [Tags]    web    filtro    positivo
    Dado que estou no primeiro exemplo Filter List
    Quando pesquiso por um nome existente
    Entao a lista deve exibir o nome pesquisado
    E nao deve apresentar opcoes incompativeis com o filtro

WEB-002B Pesquisar um nome inexistente
    [Documentation]    Nome fora da lista não deve deixar resultados correspondentes visíveis.
    [Tags]    web    filtro    negativo
    Dado que estou no primeiro exemplo Filter List
    Quando pesquiso por um nome que nao pertence a lista
    Entao nenhum nome da lista deve permanecer visivel como resultado

WEB-002C Validar nomes disponiveis na lista
    [Documentation]    Adele, Billy e Cindy foram escolhidos porque existem na lista real do tutorial.
    [Tags]    web    filtro    positivo
    Dado que estou no primeiro exemplo Filter List
    Entao os tres nomes escolhidos para o teste devem estar disponiveis
