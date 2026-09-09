*** Settings ***
Documentation    Consulta de usuários — lista, ID existente, ID inexistente e contrato.
Resource         ../../resources/api/usuarios.resource

Suite Setup      Iniciar sessao da API
Suite Teardown   Encerrar sessao da API

*** Test Cases ***
API-006 Consultar usuarios
    [Documentation]    Lista deve trazer quantidade coerente com o array e Content-Type JSON.
    [Tags]    api    consulta    positivo    contrato
    ${resposta}=    Consultar usuarios
    Status Should Be    200    ${resposta}
    Registrar evidencia da resposta    API-006 GET /usuarios    ${resposta}
    Contrato de lista de usuarios    ${resposta}
    IF    ${resposta.json()}[quantidade] > 0
        ${primeiro}=    Get From List    ${resposta.json()}[usuarios]    0
        Contrato de usuario    ${primeiro}
    END

API-007 Consultar usuario criado anteriormente
    [Documentation]    GET por ID do usuário que eu mesma cadastrei nesta execução.
    [Tags]    api    consulta    positivo
    ${payload}=    Montar usuario comum
    ${cadastro}=    Cadastrar usuario    ${payload}    201
    ${id}=    Set Variable    ${cadastro.json()}[_id]
    ${consulta}=    Consultar usuario por id    ${id}    200
    Registrar evidencia da resposta    API-007 GET por ID    ${consulta}
    Contrato de usuario    ${consulta.json()}
    Should Be Equal    ${consulta.json()}[_id]    ${id}
    Should Be Equal    ${consulta.json()}[email]    ${payload}[email]
    Excluir usuario    ${id}

API-008 Consultar ID inexistente
    [Documentation]    Swagger: 400 + message Usuário não encontrado.
    [Tags]    api    consulta    negativo
    ${resposta}=    Consultar usuario por id    idInexistente123    400
    Registrar evidencia da resposta    API-008 GET inexistente    ${resposta}
    Contrato de mensagem    ${resposta}    ${MSG_USUARIO_NAO_ENCONTRADO}
