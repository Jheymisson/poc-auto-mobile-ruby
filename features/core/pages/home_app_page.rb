# frozen_string_literal: true

require 'rspec/expectations'

class HomeAppPage

    include RSpec::Matchers

    def initialize
        get_screen_mappings 'homeApp', 'core'
    end

    def validar_home
        nome = 'Jheymisson Albuquerque'
        elemento = @mappings['nome_perfil']
        texto_elemento = elemento_existente?(elemento, nome)
    end
      

end