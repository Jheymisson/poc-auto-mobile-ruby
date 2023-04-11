# frozen_string_literal: true

require 'rspec/expectations'

class HomePage

    include RSpec::Matchers

    def initialize
        get_screen_mappings 'home', 'core'
    end

    # def notificacao
        
    # end

    def clicarBotaoLogIn
        clicar @mappings['btnLogIn']
    end

    # def clicarBotaoRegister
    #     click @mappings['btnRegister']
    # end


end