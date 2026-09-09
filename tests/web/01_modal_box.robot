*** Settings ***
Documentation    WEB-001 | Abrir e fechar a primeira modal do tutorial How To.
Resource         ../../resources/web/navegacao.resource
Resource         ../../resources/web/modal.resource

Suite Setup      Abrir Navegador
Suite Teardown   Fechar Navegador

*** Test Cases ***
WEB-001 Abrir e fechar a primeira modal do tutorial
    [Documentation]    Valida navegação How To > More > Modal Boxes e a mudança real de estado da modal.
    [Tags]    web    modal    positivo
    Dado que acesso o W3Schools
    E navego pelo menu How To
    E acesso More e seleciono Modal Boxes
    Quando aciono o botao da primeira modal
    Entao a modal deve ser exibida
    Quando fecho a modal
    Entao a modal nao deve mais estar visivel
