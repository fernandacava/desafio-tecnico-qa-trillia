*** Settings ***
Documentation    Cadastro de usuários — positivos, negativos e contrato observado.
Resource         ../../resources/api/usuarios.resource

Suite Setup      Iniciar sessao da API
Suite Teardown   Encerrar sessao da API

*** Test Cases ***
API-001 Cadastrar usuario valido
    [Documentation]    Status, mensagem, ID e persistência via GET.
    [Tags]    api    cadastro    positivo
    ${payload}=    Montar usuario comum
    ${resposta}=    Cadastrar usuario    ${payload}    201
    Registrar evidencia da resposta    API-001 POST    ${resposta}
    Contrato de cadastro com sucesso    ${resposta}
    ${id}=    Set Variable    ${resposta.json()}[_id]
    ${consulta}=    Consultar usuario por id    ${id}    200
    Registrar evidencia da resposta    API-001 GET    ${consulta}
    Contrato de usuario    ${consulta.json()}
    Should Be Equal    ${consulta.json()}[email]    ${payload}[email]
    Should Be Equal    ${consulta.json()}[nome]    ${payload}[nome]
    Excluir usuario    ${id}

API-002 Cadastrar administrador
    [Documentation]    O perfil administrativo precisa persistir como string "true".
    [Tags]    api    cadastro    positivo    admin
    ${payload}=    Montar usuario administrador
    ${resposta}=    Cadastrar usuario    ${payload}    201
    Registrar evidencia da resposta    API-002 POST    ${resposta}
    Contrato de cadastro com sucesso    ${resposta}
    ${id}=    Set Variable    ${resposta.json()}[_id]
    ${consulta}=    Consultar usuario por id    ${id}    200
    Should Be Equal    ${consulta.json()}[administrador]    true
    Excluir usuario    ${id}

API-003 Cadastrar usuario comum
    [Documentation]    Usuário não administrador persiste administrador="false".
    [Tags]    api    cadastro    positivo
    ${payload}=    Montar usuario comum
    ${resposta}=    Cadastrar usuario    ${payload}    201
    ${id}=    Set Variable    ${resposta.json()}[_id]
    ${consulta}=    Consultar usuario por id    ${id}    200
    Should Be Equal    ${consulta.json()}[administrador]    false
    Excluir usuario    ${id}

API-004 Tentar cadastrar email duplicado
    [Documentation]    Mensagem documentada no Swagger: Este email já está sendo usado.
    [Tags]    api    cadastro    negativo
    ${payload}=    Montar usuario comum
    ${primeira}=    Cadastrar usuario    ${payload}    201
    ${id}=    Set Variable    ${primeira.json()}[_id]
    ${duplicada}=    Cadastrar usuario    ${payload}    400
    Registrar evidencia da resposta    API-004 POST duplicado    ${duplicada}
    Contrato de mensagem    ${duplicada}    ${MSG_EMAIL_DUPLICADO}
    Excluir usuario    ${id}

API-005 Enviar cadastro sem campos obrigatorios
    [Documentation]    Swagger não detalha o body de validação. Comportamento observado: HTTP 400 com um campo por obrigatoriedade.
    [Tags]    api    cadastro    negativo    observado
    ${vazio}=    Create Dictionary
    ${resposta}=    Cadastrar usuario    ${vazio}    400
    Registrar evidencia da resposta    API-005 payload vazio    ${resposta}
    Resposta deve ser JSON    ${resposta}
    Dictionary Should Contain Key    ${resposta.json()}    nome
    Dictionary Should Contain Key    ${resposta.json()}    email
    Dictionary Should Contain Key    ${resposta.json()}    password
    Dictionary Should Contain Key    ${resposta.json()}    administrador
    Should Contain    ${resposta.json()}[nome]    obrigatório
    Should Contain    ${resposta.json()}[email]    obrigatório

API-005B Cadastro sem o campo nome
    [Documentation]    Recorte do caso anterior: falta só um obrigatório. Observado na API, não no Swagger.
    [Tags]    api    cadastro    negativo    observado
    ${payload}=    Montar usuario comum
    Remove From Dictionary    ${payload}    nome
    ${resposta}=    Cadastrar usuario    ${payload}    400
    Registrar evidencia da resposta    API-005B sem nome    ${resposta}
    Dictionary Should Contain Key    ${resposta.json()}    nome
    Should Contain    ${resposta.json()}[nome]    obrigatório

API-005C Tipo incorreto no campo administrador
    [Documentation]    administrador é string "true"|"false" no Swagger. Boolean foi rejeitado na API observada.
    [Tags]    api    cadastro    negativo    observado
    ${payload}=    Montar usuario comum
    Set To Dictionary    ${payload}    administrador=${True}
    ${resposta}=    Cadastrar usuario    ${payload}    400
    Registrar evidencia da resposta    API-005C administrador boolean    ${resposta}
    Dictionary Should Contain Key    ${resposta.json()}    administrador
    Should Contain    ${resposta.json()}[administrador]    true
    Should Contain    ${resposta.json()}[administrador]    false
