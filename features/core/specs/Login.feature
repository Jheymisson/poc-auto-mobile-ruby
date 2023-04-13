
@login
Feature: Login

    @loginSucesso
    Scenario: Login sucesso
        Given que acesso a tela inicial do APP
        When preencho 'jheymis.albuquerque@hotmail.com' e 'Laranja2134@'
        Then é exibido o nome do usuário na Home do App
        

