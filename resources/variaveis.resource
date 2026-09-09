*** Settings ***
Documentation    Dados de ambiente e massa de teste.
...              Valores de Web foram conferidos nas páginas reais do W3Schools.
...              Contrato de API foi conferido no Swagger e, quando o Swagger era
...              incompleto, no comportamento observado da ServeRest.

*** Variables ***
${HEADLESS}                         True
${URL_W3SCHOOLS}                    https://www.w3schools.com/
${URL_HOWTO}                        https://www.w3schools.com/howto/default.asp
${URL_MODAL}                        https://www.w3schools.com/howto/howto_css_modals.asp
${URL_FILTRO}                       https://www.w3schools.com/howto/howto_js_filter_lists.asp
${URL_FORMS}                        https://www.w3schools.com/html/html_forms.asp
${API_BASE}                         https://serverest.dev
${TIMEOUT}                          40s

${NOME_EXISTENTE}                   Adele
${NOME_INEXISTENTE}                 FernandaQA
@{NOMES_ESPERADOS}                  Adele    Billy    Cindy

${FORM_NOME}                        Fernanda
${FORM_SOBRENOME}                   Rodrigues

${MSG_CADASTRO_OK}                  Cadastro realizado com sucesso
${MSG_EMAIL_DUPLICADO}              Este email já está sendo usado
${MSG_USUARIO_NAO_ENCONTRADO}       Usuário não encontrado
${MSG_ALTERADO_OK}                  Registro alterado com sucesso
${MSG_EXCLUIDO_OK}                  Registro excluído com sucesso
${MSG_NENHUM_EXCLUIDO}              Nenhum registro excluído
