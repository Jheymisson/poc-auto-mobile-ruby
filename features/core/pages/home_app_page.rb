# frozen_string_literal: true

require 'rspec/expectations'

class HomeAppPage

    include RSpec::Matchers

    def initialize
        get_screen_mappings 'homeApp', 'core'
    end

    def validar_botao
        elemento = @mappings['botao_perfil']
        texto_elemento = button_exists?(elemento)
    end
      

end