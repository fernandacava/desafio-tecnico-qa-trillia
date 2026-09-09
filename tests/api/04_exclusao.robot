*** Settings ***
Documentation    Exclusão de usuário. O GET posterior é o que prova que a entidade saiu da base.
Resource         ../../resources/api/usuarios.resource

Suite Setup      Iniciar sessao da API
Suite Teardown   Encerrar sessao da API

*** Test Cases ***
API-010 Excluir usuario existente e comprovar que deixou de existir
    [Documentation]    DELETE 200 + GET 400 Usuário não encontrado.
    [Tags]    api    exclusao    positivo
    ${payload}=    Montar usuario comum
    ${cadastro}=    Cadastrar usuario    ${payload}    201
    ${id}=    Set Variable    ${cadastro.json()}[_id]
    ${delete}=    Excluir usuario    ${id}    200
    Registrar evidencia da resposta    API-010 DELETE    ${delete}
    Contrato de mensagem    ${delete}    ${MSG_EXCLUIDO_OK}
    ${consulta}=    Consultar usuario por id    ${id}    400
    Registrar evidencia da resposta    API-010 GET apos DELETE    ${consulta}
    Contrato de mensagem    ${consulta}    ${MSG_USUARIO_NAO_ENCONTRADO}

API-010B Excluir ID inexistente
    [Documentation]    Swagger descreve 200 com "Nenhum registro excluído" quando não há registro.
    [Tags]    api    exclusao    negativo
    ${resposta}=    Excluir usuario    idInexistente123    200
    Registrar evidencia da resposta    API-010B DELETE inexistente    ${resposta}
    Contrato de mensagem    ${resposta}    ${MSG_NENHUM_EXCLUIDO}
