# Cenários Web

Antes de automatizar, abri as páginas reais e conferi o que o usuário vê.

## WEB-001 — Modal Box

**Caminho:** W3Schools → menu HOW TO → seção More → Modal Boxes.

**Comportamento pedido:** abrir → visível → fechar → não visível.

**O que eu conferi na página**

A primeira modal ao vivo não usa `#myModal`. O botão `Open Modal` chama `#id01` (modal W3.CSS). `#myModal` aparece no editor *Try it Yourself* do exemplo clássico.

Se eu tivesse copiado um seletor de tutorial antigo, o teste passaria a clicar em nada e geraria falso negativo. Por isso validei o DOM antes de escrever o script.

**Gherkin**

```gherkin
Funcionalidade: Modal Box

Cenário: Abrir e fechar a primeira modal do tutorial
  Dado que acesso o W3Schools
  E navego pelo menu "How To"
  E acesso "More"
  E seleciono "Modal Boxes"
  Quando aciono o botão para abrir a primeira modal
  Então a modal deve ser exibida
  Quando fecho a modal
  Então a modal não deve mais estar visível
```

**O que a automação realmente valida**

- URL contém `howto_css_modals`.
- `#id01` começa com `display: none`.
- Depois do clique, `display: block` e o texto `Modal Header` aparece.
- Depois do X, o elemento fica oculto.

## WEB-002 — Filter/Search List

O primeiro exemplo já está na página: `#myInput` e `#myUL`.

Nomes reais da lista: Adele, Agnes, Billy, Bob, Calvin, Christina, Cindy.

Escolhi **Adele** como nome existente porque o filtro é substring; um termo curto demais (por exemplo "A") deixaria Agnes visível e enfraqueceria o teste.

Escolhi **FernandaQA** como inexistente para não colidir com nenhum nome da lista.

O tutorial aplica o filtro no evento `onkeyup`. Por isso a automação **digita** no campo em vez de colar o valor. Um `Fill Text` deixaria a lista intacta e geraria falso positivo no cenário C e falso negativo em A e B.

```gherkin
Funcionalidade: Filtro de nomes

Cenário: Pesquisar um nome existente
  Dado que estou no primeiro exemplo "Filter List"
  Quando pesquiso por um nome existente
  Então a lista deve exibir o nome pesquisado
  E não deve apresentar opções incompatíveis com o filtro

Cenário: Pesquisar um nome inexistente
  Dado que estou no primeiro exemplo "Filter List"
  Quando pesquiso por um nome que não pertence à lista
  Então nenhum nome da lista deve permanecer visível como resultado correspondente

Cenário: Validar nomes disponíveis na lista
  Dado que estou no primeiro exemplo "Filter List"
  Então os três nomes escolhidos para o teste devem estar disponíveis na lista
```

## WEB-003 — HTML Forms

O primeiro *Try it Yourself* da página é `tryhtml_form_submit`. Ele tem nome, sobrenome e Submit. Isso atende o enunciado sem eu precisar “pular” para outro exemplo.

O editor abre outra página. O formulário vive no iframe `#iframeResult`. A submissão vai para `/action_page.php` e o resultado precisa conter `Fernanda` e `Rodrigues`.

```gherkin
Funcionalidade: Envio de formulário HTML

Cenário: Enviar nome e sobrenome pelo formulário
  Dado que acesso o tutorial "HTML Forms"
  E acesso o primeiro exemplo através de "Try it Yourself"
  Quando preencho o nome "Fernanda"
  E preencho o sobrenome "Rodrigues"
  E submeto o formulário
  Então os dados enviados devem apresentar o nome "Fernanda"
  E devem apresentar o sobrenome "Rodrigues"
```
