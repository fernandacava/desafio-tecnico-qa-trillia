*** Settings ***
Documentation    Palavras-chave da funcionalidade de usuários da ServeRest.
Library          RequestsLibrary
Library          Collections
Library          String
Library          ${CURDIR}${/}dados.py
Resource         ../variaveis.resource
Resource         contrato.resource

*** Keywords ***
Iniciar sessao da API
    ${headers}=    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    serverest    ${API_BASE}    headers=${headers}    disable_warnings=1

Encerrar sessao da API
    Delete All Sessions

Cadastrar usuario
    [Arguments]    ${payload}    ${expected_status}=201
    ${resposta}=    POST On Session    serverest    /usuarios    json=${payload}    expected_status=any
    Status Should Be    ${expected_status}    ${resposta}
    RETURN    ${resposta}

Consultar usuarios
    ${resposta}=    GET On Session    serverest    /usuarios    expected_status=any
    RETURN    ${resposta}

Consultar usuario por id
    [Arguments]    ${id}    ${expected_status}=200
    ${resposta}=    GET On Session    serverest    /usuarios/${id}    expected_status=any
    Status Should Be    ${expected_status}    ${resposta}
    RETURN    ${resposta}

Alterar usuario
    [Arguments]    ${id}    ${payload}    ${expected_status}=200
    ${resposta}=    PUT On Session    serverest    /usuarios/${id}    json=${payload}    expected_status=any
    Status Should Be    ${expected_status}    ${resposta}
    RETURN    ${resposta}

Excluir usuario
    [Arguments]    ${id}    ${expected_status}=200
    ${resposta}=    DELETE On Session    serverest    /usuarios/${id}    expected_status=any
    Status Should Be    ${expected_status}    ${resposta}
    RETURN    ${resposta}

Registrar evidencia da resposta
    [Arguments]    ${titulo}    ${resposta}
    Log    ${titulo} | HTTP ${resposta.status_code} | ${resposta.headers.get('Content-Type')} | ${resposta.text}

Montar usuario administrador
    ${payload}=    Gerar Usuario    true
    RETURN    ${payload}

Montar usuario comum
    ${payload}=    Gerar Usuario    false
    RETURN    ${payload}
