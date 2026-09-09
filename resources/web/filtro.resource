*** Settings ***
Documentation    Filtro de nomes do primeiro exemplo da página Filter/Search List.
...              Não valido só quantidade: valido o texto visível para o usuário.
Library          Collections
Library          String
Resource         ../common.resource

*** Keywords ***
Quando pesquiso por um nome existente
    [Documentation]    O tutorial filtra no onkeyup. Fill Text não dispara essa tecla; por isso eu digito.
    Click    id=myInput
    Clear Text    id=myInput
    Type Text    id=myInput    ${NOME_EXISTENTE}    delay=50ms
    Sleep    400ms

Entao a lista deve exibir o nome pesquisado
    ${visiveis}=    _Nomes visiveis na lista
    Should Contain    ${visiveis}    ${NOME_EXISTENTE}
    Capturar Evidencia    02-filtro-existente

E nao deve apresentar opcoes incompativeis com o filtro
    ${visiveis}=    _Nomes visiveis na lista
    ${filtro}=    Convert To Upper Case    ${NOME_EXISTENTE}
    FOR    ${nome}    IN    @{visiveis}
        ${nome_up}=    Convert To Upper Case    ${nome}
        Should Contain    ${nome_up}    ${filtro}
    END

Quando pesquiso por um nome que nao pertence a lista
    Click    id=myInput
    Clear Text    id=myInput
    Type Text    id=myInput    ${NOME_INEXISTENTE}    delay=50ms
    Sleep    400ms

Entao nenhum nome da lista deve permanecer visivel como resultado
    ${visiveis}=    _Nomes visiveis na lista
    Should Be Empty    ${visiveis}
    Capturar Evidencia    03-filtro-inexistente

Entao os tres nomes escolhidos para o teste devem estar disponiveis
    ${texto}=    Get Text    id=myUL
    FOR    ${nome}    IN    @{NOMES_ESPERADOS}
        Should Contain    ${texto}    ${nome}
    END
    Capturar Evidencia    04-nomes-disponiveis

_Nomes visiveis na lista
    ${itens}=    Get Elements    id=myUL >> css=li
    ${visiveis}=    Create List
    FOR    ${item}    IN    @{itens}
        ${display}=    Get Style    ${item}    display
        IF    '${display}' != 'none'
            ${texto}=    Get Text    ${item}
            ${texto}=    Strip String    ${texto}
            Append To List    ${visiveis}    ${texto}
        END
    END
    RETURN    ${visiveis}
