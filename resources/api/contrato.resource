*** Settings ***
Documentation    Validações de contrato da ServeRest.
...              Campos e mensagens documentados no Swagger entram como asserção rígida.
...              Comportamento só observado na API é nomeado como tal nos testes.
Library          Collections

*** Keywords ***
Resposta deve ser JSON
    [Arguments]    ${resposta}
    ${content_type}=    Get From Dictionary    ${resposta.headers}    Content-Type
    Should Contain    ${content_type}    application/json

Contrato de cadastro com sucesso
    [Arguments]    ${resposta}
    Resposta deve ser JSON    ${resposta}
    Dictionary Should Contain Key    ${resposta.json()}    message
    Dictionary Should Contain Key    ${resposta.json()}    _id
    Should Be Equal    ${resposta.json()}[message]    Cadastro realizado com sucesso
    Should Not Be Empty    ${resposta.json()}[_id]

Contrato de usuario
    [Arguments]    ${corpo}
    Dictionary Should Contain Key    ${corpo}    nome
    Dictionary Should Contain Key    ${corpo}    email
    Dictionary Should Contain Key    ${corpo}    password
    Dictionary Should Contain Key    ${corpo}    administrador
    Dictionary Should Contain Key    ${corpo}    _id
    ${tipo_nome}=    Evaluate    type($corpo["nome"]).__name__
    ${tipo_email}=    Evaluate    type($corpo["email"]).__name__
    ${tipo_password}=    Evaluate    type($corpo["password"]).__name__
    ${tipo_id}=    Evaluate    type($corpo["_id"]).__name__
    Should Be Equal    ${tipo_nome}    str
    Should Be Equal    ${tipo_email}    str
    Should Be Equal    ${tipo_password}    str
    Should Be Equal    ${tipo_id}    str
    Should Contain    ${{['true', 'false']}}    ${corpo}[administrador]

Contrato de lista de usuarios
    [Arguments]    ${resposta}
    Resposta deve ser JSON    ${resposta}
    Dictionary Should Contain Key    ${resposta.json()}    quantidade
    Dictionary Should Contain Key    ${resposta.json()}    usuarios
    ${quantidade}=    Get From Dictionary    ${resposta.json()}    quantidade
    ${usuarios}=    Get From Dictionary    ${resposta.json()}    usuarios
    Should Be True    isinstance($quantidade, int)
    Should Be True    isinstance($usuarios, list)
    Length Should Be    ${usuarios}    ${quantidade}

Contrato de mensagem
    [Arguments]    ${resposta}    ${mensagem}
    Resposta deve ser JSON    ${resposta}
    Dictionary Should Contain Key    ${resposta.json()}    message
    Should Be Equal    ${resposta.json()}[message]    ${mensagem}
