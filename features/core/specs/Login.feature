
@login
Feature: Login

    @loginSucesso
    Scenario: Login sucesso
        Given que acesso a tela inicial do APP
        When preencho '<informe usuário ou email>' e '<informe a senha>'
        Then devo validar o nome do usuário "<nome do usuário>" na Home do App

