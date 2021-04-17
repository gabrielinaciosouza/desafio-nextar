# DESAFIO NEXTAR

Um projeto em Flutter 2

## Sobre o app

O app é uma representação de um cadastro de produtos.

- [Aqui está as definições de entrega do desafio](https://github.com/nextar/desafio-nextar-mobile)

## Casos de uso

Conforme o desenvolvimento do app, serão criados os casos de uso referentes a implementação em curso.

- [Caso de uso: Login](./requirements/use_cases/authentication.md)
- [Caso de uso: Salvar Usuário Authenticado](./requirements/use_cases/local_save_current_account.md)
- [Caso de uso: Carregar Usuário Authenticado](./requirements/use_cases/local_load_current_account.md)
- [Caso de uso: Produtos](./requirements/use_cases/local_load_products.md)

## Checklists

A implementação **pronta** deverá conter um ✅, caso contrário não haverá marcações.
Conforme o desenvolvimento do app, serão criados os checklists referentes a implementação em curso.

- [Checklist: POST](./requirements/checklists/http/post.md)
- [Checklist: Página de login](./requirements/checklists/pages/login/login_page.md)
- [Checklist: Login Presenter](./requirements/checklists/pages/login/login_presenter.md)
- [Checklist: Página Splash](./requirements/checklists/pages/splash/splash_presenter.md)
- [Checklist: Splash Presenter](./requirements/checklists/pages/splash/splash_page.md)
- [Checklist: Página Home](./requirements/checklists/pages/home/home_presenter.md)
- [Checklist: Home Presenter](./requirements/checklists/pages/home/home_page.md)

## Especificações

Conforme o desenvolvimento do app, serão criados os especificações referentes a implementação em curso.

- [Visão de cliente: Login](./requirements/bdd_specs/login.md)
- [Visão de cliente: Login](./requirements/bdd_specs/home.md)

## Versões e instruções

Para rodar o app, favor assegurar de:

- Estar com a versão 2.0.4 do Flutter
- Estar com a versão 2.12.2 do Dart SDK
- Em ambiente android, versão mínima do SDK deve ser maior que 18
- Habilitar o null-safaty
- Rodar o comando "flutter pub get" no terminal
- O app está pronto para rodar nas plataformas web, android e IOS
- Para testes de responsividade, rodar em ambiente web
- Para rodar os testes unitários, pode ser feito pela IDE ou pelo comando "flutter test"
