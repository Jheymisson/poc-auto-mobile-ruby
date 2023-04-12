
@login
Feature: Login

    @loginSucesso
    Scenario: Login sucesso
        Given que acesso a tela inicial do APP
        When preencho '<usuario/email>' e '<senha>
        Then devo validar o botão de perfil na Home do App

