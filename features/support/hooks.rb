# frozen_string_literal: true

require_relative '../../features/core/pages/home_page.rb'
require_relative '../../features/core/pages/home_app_page.rb'
require_relative '../../features/core/pages/login_page.rb'

Before do
    @home = HomePage.new
    @homeApp = HomeAppPage.new
    @login = LoginPage.new
    $driver.start_driver
end

After do
    $driver.driver_quit
    $logger.info('Teste finalizado')
end
  