# frozen_string_literal: true

require 'rspec/expectations'

class LoginPage

    include RSpec::Matchers

    def initialize
        get_screen_mappings 'login', 'core'
    end

    def informarUsuario(texto)
        escreverTexto @mappings['inputUsuario'], (texto)
    end

    def informarSenha(texto)
        escreverTexto @mappings['inputSenha'], (texto) 
    end

    def clicarBotaoLogar
        hide_keyboard
        clicar @mappings['btnLogar']
    end


end