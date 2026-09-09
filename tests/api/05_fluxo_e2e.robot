*** Settings ***
Documentation    Fluxo E2E da entidade usuário: criar, consultar, alterar, consultar, excluir, consultar.
Resource         ../../resources/api/usuarios.resource

Suite Setup      Iniciar sessao da API
Suite Teardown   Encerrar sessao da API

*** Test Cases ***
API-E2E Ciclo completo do usuario
    [Documentation]    Um único usuário atravessa o ciclo de vida. Falha em qualquer etapa quebra o fluxo.
    [Tags]    api    e2e
    ${payload}=    Montar usuario comum
    ${create}=    Cadastrar usuario    ${payload}    201
    Registrar evidencia da resposta    E2E CREATE    ${create}
    Contrato de cadastro com sucesso    ${create}
    ${id}=    Set Variable    ${create.json()}[_id]

    ${get1}=    Consultar usuario por id    ${id}    200
    Registrar evidencia da resposta    E2E GET apos CREATE    ${get1}
    Should Be Equal    ${get1.json()}[email]    ${payload}[email]

    ${novo}=    Create Dictionary
    ...    nome=Fernanda E2E Atualizada
    ...    email=${payload}[email]
    ...    password=${payload}[password]
    ...    administrador=true
    ${update}=    Alterar usuario    ${id}    ${novo}    200
    Registrar evidencia da resposta    E2E UPDATE    ${update}
    Contrato de mensagem    ${update}    ${MSG_ALTERADO_OK}

    ${get2}=    Consultar usuario por id    ${id}    200
    Registrar evidencia da resposta    E2E GET apos UPDATE    ${get2}
    Should Be Equal    ${get2.json()}[nome]    Fernanda E2E Atualizada
    Should Be Equal    ${get2.json()}[administrador]    true

    ${delete}=    Excluir usuario    ${id}    200
    Registrar evidencia da resposta    E2E DELETE    ${delete}
    Contrato de mensagem    ${delete}    ${MSG_EXCLUIDO_OK}

    ${get3}=    Consultar usuario por id    ${id}    400
    Registrar evidencia da resposta    E2E GET apos DELETE    ${get3}
    Contrato de mensagem    ${get3}    ${MSG_USUARIO_NAO_ENCONTRADO}
