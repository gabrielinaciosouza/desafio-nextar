# LOJA VIRTUAL

## Sobre o app

O app é uma representação de um cadastro de produtos.

## Casos de uso

Este são os principais casos de uso.

- [Caso de uso: Login](./requirements/use_cases/authentication.md)
- [Caso de uso: Salvar Usuário Authenticado](./requirements/use_cases/local_save_current_account.md)
- [Caso de uso: Carregar Usuário Authenticado](./requirements/use_cases/local_load_current_account.md)
- [Caso de uso: Carregar Produtos](./requirements/use_cases/local_load_products.md)
- [Caso de uso: Salvar Produto](./requirements/use_cases/local_save_product.md)
- [Caso de uso: Deletar Produto](./requirements/use_cases/local_delete_product.md)
- [Caso de uso: Carregar imagens](./requirements/use_cases/image_picker.md)

## Checklists

A implementação **pronta** deverá conter um ✅, caso contrário não haverá marcações.

- [Checklist: POST](./requirements/checklists/http/post.md)
- [Checklist: Página de login](./requirements/checklists/pages/login/login_page.md)
- [Checklist: Login Presenter](./requirements/checklists/pages/login/login_presenter.md)
- [Checklist: Página Splash](./requirements/checklists/pages/splash/splash_presenter.md)
- [Checklist: Splash Presenter](./requirements/checklists/pages/splash/splash_page.md)
- [Checklist: Página Home](./requirements/checklists/pages/home/home_presenter.md)
- [Checklist: Home Presenter](./requirements/checklists/pages/home/home_page.md)
- [Checklist: Página de Produtos](./requirements/checklists/pages/product/product_presenter.md)
- [Checklist: Delete Cache](./requirements/checklists/cache/delete_cache.md)
- [Checklist: Delete Secure Cache](./requirements/checklists/cache/delete_secure_cache.md)
- [Checklist: Fetch Cache](./requirements/checklists/cache/fetch_cache.md)
- [Checklist: Fetch Secure Cache](./requirements/checklists/cache/fetch_secure_cache.md)
- [Checklist: Save Cache](./requirements/checklists/cache/save_cache.md)
- [Checklist: Save Secure Cache](./requirements/checklists/cache/save_secure_cache.md)

## Especificações

Estas são as histórias, contém a visão de cliente para as páginas do app.

- [Visão de cliente: Login](./requirements/bdd_specs/login.md)
- [Visão de cliente: Home](./requirements/bdd_specs/home.md)
- [Visão de cliente: Produto](./requirements/bdd_specs/product.md)

## Versões e instruções

Para rodar o app, favor assegurar de:

- Estar com a versão 2.0.5 do Flutter
- Estar com a versão 2.12.2 do Dart SDK
- Em ambiente android, versão mínima do SDK deve ser maior que 18
- Habilitar o null-safaty
- Rodar o comando "flutter pub get" no terminal
- O app está pronto para rodar nas plataformas web, android e IOS
- Para testes de responsividade, rodar em ambiente web
- Para rodar os testes unitários, pode ser feito pela IDE ou pelo comando "flutter test"

## Observações pessoais

- Para o modo web, ainda não há uma estabilidade para carregar imagens, testei 3 plugins diferentes que ocorrem em erros diferentes. Foi o meu primeiro contato com o Flutter Web e particularmente, não o utilizaria agora para projetos em produção. Se eu fosse resolver este problema levaria muito tempo, portanto decidi deixar apenas como caso de estudo. Tive alguns problemas também com renderização de componentes e travamentos inesperados. Portanto, peço com gentileza que relevem o fato da função de carregar imagens não funcionar em ambiente web e considerem a arquitetura que foi feita para este caso de uso.

- Durante o desenvolvimento notei que não há plugins para salvamento seguro de cache para web. Não me empenhei em resolver este problema criptografando os dados pois acredito que não é esse o objetivo deste desafio. Portanto encontrei um solução bem legal, utilizando o design patterns do composite para fazer as chamadas entre o cache seguro e o cache, também poderia ter utilizado o strategy, mas acredito que o composite resolveu muito bem.

- Adicionei novas features ao escopo inicial, como por exemplo um esquema de logoff. Deixei pronto um padrão que eu gosto muito, o de "separação" de strings da UI e internacionalização, porém utilizei somente em poruguês. Da forma que está, é muito simples de traduzir o app para novas línguas, sendo necessário apenas implementar a classe "Translations" e adicionar uma forma de escolher a linguagem através da UI.

- Os testes em Dart e Flutter tem uma documentação muito simples. O conteúdo é díficil de achar, principalmente agora com o null-safety, porém apesar de ter dado muito trabalho, consegui superar e realizar testes importantes para o desafio.

- Utilizei o GIT FLOW para padrões de commits, porém com algumas adaptações.
