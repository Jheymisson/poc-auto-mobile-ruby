
@login
Feature: Login

    @loginSucesso
    Scenario: Login sucesso
        Given que acesso a tela inicial do APP
        When preencho '<nome do usuario>' e 'senha do usuario'
        Then é exibido o nome do usuário na Home do App
        

