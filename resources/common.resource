*** Settings ***
Documentation    Palavras-chave comuns da suíte Web.
Resource         variaveis.resource
Library          Browser    timeout=${TIMEOUT}    enable_presenter_mode=False

*** Keywords ***
Abrir Navegador
    [Documentation]    Sobe Chromium com evidência de vídeo na pasta de resultados.
    ${headless}=    Evaluate    str('${HEADLESS}').lower() in ['true', '1', 'yes']
    New Browser    chromium    headless=${headless}
    ${video}=    Create Dictionary    dir=${OUTPUT DIR}${/}videos
    ${viewport}=    Create Dictionary    width=${1440}    height=${900}
    New Context    viewport=${viewport}    recordVideo=${video}
    Set Browser Timeout    ${TIMEOUT}

Fechar Navegador
    Close Browser    ALL

Capturar Evidencia
    [Arguments]    ${nome}
    Take Screenshot    ${nome}    fullPage=True
