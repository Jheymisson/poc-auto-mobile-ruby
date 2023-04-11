# frozen_string_literal: true

require 'rspec/expectations'

class HomeAppPage

    include RSpec::Matchers

    def initialize
        get_screen_mappings 'homeApp', 'core'
    end

    def validarNomeUsuario(nome)
        puts "Nome recebido: #{nome}"
        elemento = @mappings['nomeUsuario']
        texto_elemento = validarTexto(elemento).text
        expect(texto_elemento).to include(nome)
    end
      

end