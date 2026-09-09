*** Settings ***
Documentation    WEB-003 | Envio de nome e sobrenome pelo primeiro Try it Yourself de HTML Forms.
Resource         ../../resources/web/navegacao.resource
Resource         ../../resources/web/formulario.resource

Suite Setup      Abrir Navegador
Suite Teardown   Fechar Navegador

*** Test Cases ***
WEB-003 Enviar nome e sobrenome pelo formulario
    [Documentation]    Valida nova página do editor, campos, submissão e valores efetivamente enviados.
    [Tags]    web    forms    positivo
    Dado que acesso o tutorial HTML Forms
    E acesso o primeiro exemplo atraves de Try it Yourself
    Quando preencho o nome e o sobrenome
    E submeto o formulario
    Entao os dados enviados devem apresentar nome e sobrenome
