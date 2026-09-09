*** Settings ***
Documentation    Alteração de usuário. PUT sozinho não prova persistência; o GET depois prova.
Resource         ../../resources/api/usuarios.resource

Suite Setup      Iniciar sessao da API
Suite Teardown   Encerrar sessao da API

*** Test Cases ***
API-009 Alterar usuario existente e comprovar persistencia
    [Documentation]    Altera nome e perfil, depois consulta de novo o mesmo ID.
    [Tags]    api    alteracao    positivo
    ${original}=    Montar usuario comum
    ${cadastro}=    Cadastrar usuario    ${original}    201
    ${id}=    Set Variable    ${cadastro.json()}[_id]
    ${alterado}=    Create Dictionary
    ...    nome=Fernanda Rodrigues Alterada
    ...    email=${original}[email]
    ...    password=${original}[password]
    ...    administrador=true
    ${put}=    Alterar usuario    ${id}    ${alterado}    200
    Registrar evidencia da resposta    API-009 PUT    ${put}
    Contrato de mensagem    ${put}    ${MSG_ALTERADO_OK}
    ${consulta}=    Consultar usuario por id    ${id}    200
    Registrar evidencia da resposta    API-009 GET apos PUT    ${consulta}
    Should Be Equal    ${consulta.json()}[nome]    Fernanda Rodrigues Alterada
    Should Be Equal    ${consulta.json()}[administrador]    true
    Should Be Equal    ${consulta.json()}[email]    ${original}[email]
    Excluir usuario    ${id}
