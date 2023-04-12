# frozen_string_literal: true

require 'rspec/expectations'

class LoginPage

    include RSpec::Matchers

    def initialize
        get_screen_mappings 'login', 'core'
    end

    def informar_usuario(texto)
        escrever_texto @mappings['input_usuario'], (texto)
    end

    def informar_senha(texto)
        escrever_texto @mappings['input_senha'], (texto) 
    end

    def clicar_botao_logar
        hide_keyboard
        clicar @mappings['btn_logar']
    end


end