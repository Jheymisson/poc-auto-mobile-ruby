# frozen_string_literal: true

Given('que acesso a tela inicial do APP') do
    @home.clicarBotaoLogIn
end

When('preencho {string} e {string}') do |usuario, senha|
    @login.informarUsuario usuario
    @login.informarSenha senha
    @login.clicarBotaoLogar
end

Then('devo validar o nome do usuário {string} na Home do App') do |nomeUsuario|
    puts "Nome do usuário no arquivo de etapas: #{nomeUsuario}"
    @homeApp.validarNomeUsuario(nomeUsuario)
end
  
