# frozen_string_literal: true

Given('que acesso a tela inicial do APP') do
    @home.clicar_botao_login
end

When('preencho {string} e {string}') do |usuario, senha|
    @login.informar_usuario usuario
    @login.informar_senha senha
    @login.clicar_botao_logar
end

Then('é exibido o nome do usuário na Home do App') do 
    @homeApp.validar_home
end
  
