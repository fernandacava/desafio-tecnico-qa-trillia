*** Settings ***
Documentation    Envio do primeiro Try it Yourself de HTML Forms.
...              O editor abre outra página; o formulário vive dentro de #iframeResult.
Resource         ../common.resource

*** Keywords ***
E acesso o primeiro exemplo atraves de Try it Yourself
    [Documentation]    O primeiro exemplo abre o editor em nova aba (target=_blank).
    Click    css=a[href="tryit.asp?filename=tryhtml_form_submit"] >> nth=0
    Switch Page    NEW
    Wait For Elements State    id=iframeResult    visible
    ${url}=    Get Url
    Should Contain    ${url}    tryit.asp
    Should Contain    ${url}    tryhtml_form_submit
    Capturar Evidencia    02-tryit-editor

Quando preencho o nome e o sobrenome
    Fill Text    id=iframeResult >>> id=fname    ${FORM_NOME}
    Fill Text    id=iframeResult >>> id=lname    ${FORM_SOBRENOME}
    Capturar Evidencia    03-formulario-preenchido

E submeto o formulario
    Click    id=iframeResult >>> css=input[type=submit]

Entao os dados enviados devem apresentar nome e sobrenome
    Wait For Elements State    id=iframeResult >>> text=${FORM_NOME}    visible
    ${conteudo}=    Get Text    id=iframeResult >>> body
    Should Contain    ${conteudo}    ${FORM_NOME}
    Should Contain    ${conteudo}    ${FORM_SOBRENOME}
    Capturar Evidencia    04-resultado-envio
