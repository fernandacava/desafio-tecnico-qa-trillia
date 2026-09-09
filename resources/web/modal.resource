*** Settings ***
Documentation    Primeira modal ao vivo do tutorial How To > Modal Boxes.
...              Conferência feita na página: o botão abre #id01 (W3.CSS), não #myModal.
...              #myModal existe apenas no editor Try it Yourself do exemplo clássico.
Resource         ../common.resource

*** Keywords ***
Quando aciono o botao da primeira modal
    Wait For Elements State    id=id01    attached
    ${display_antes}=    Get Style    id=id01    display
    Should Be Equal    ${display_antes}    none
    Scroll To Element    css=button.ws-btn >> text=Open Modal
    Click    css=button.ws-btn >> text=Open Modal

Entao a modal deve ser exibida
    Wait For Elements State    id=id01    visible
    ${display}=    Get Style    id=id01    display
    Should Be Equal    ${display}    block
    Get Text    id=id01    contains    Modal Header
    Capturar Evidencia    04-modal-aberta

Quando fecho a modal
    Click    css=#id01 .w3-display-topright

Entao a modal nao deve mais estar visivel
    Wait For Elements State    id=id01    hidden
    ${display}=    Get Style    id=id01    display
    Should Be Equal    ${display}    none
    Capturar Evidencia    05-modal-fechada
