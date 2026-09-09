*** Settings ***
Documentation    Navegação no W3Schools. Priorizo o caminho de menu pedido no enunciado.
Resource         ../common.resource

*** Keywords ***
Dado que acesso o W3Schools
    New Page    ${URL_W3SCHOOLS}    wait_until=domcontentloaded
    Wait For Elements State    css=a.ga-nav >> text=HOW TO    visible
    Capturar Evidencia    01-home-w3schools

E navego pelo menu How To
    [Documentation]    O menu verde superior expõe o atalho HOW TO para a área de snippets.
    Click    css=a.ga-nav >> text=HOW TO
    Wait For Elements State    css=#leftmenuinnerinner    visible
    ${url}=    Get Url
    Should Contain    ${url}    /howto/
    Capturar Evidencia    02-howto-index

E acesso More e seleciono Modal Boxes
    [Documentation]    Modal Boxes fica na seção More do menu lateral, não no topo da lista.
    Scroll To Element    css=#leftmenuinnerinner h2 >> text=More
    Click    css=#leftmenuinnerinner a >> text=Modal Boxes
    Wait For Elements State    css=button.ws-btn >> text=Open Modal    visible
    ${url}=    Get Url
    Should Contain    ${url}    howto_css_modals
    Capturar Evidencia    03-pagina-modal

Dado que estou no primeiro exemplo Filter List
    [Documentation]    O primeiro exemplo já está visível na própria página do tutorial.
    New Page    ${URL_FILTRO}    wait_until=domcontentloaded
    Wait For Elements State    id=myInput    visible
    Wait For Elements State    id=myUL    visible
    Capturar Evidencia    01-filter-list

Dado que acesso o tutorial HTML Forms
    New Page    ${URL_FORMS}    wait_until=domcontentloaded
    Wait For Elements State    css=a[href="tryit.asp?filename=tryhtml_form_submit"] >> nth=0    visible
    Capturar Evidencia    01-html-forms
