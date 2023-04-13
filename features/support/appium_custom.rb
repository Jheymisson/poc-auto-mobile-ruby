# frozen_string_literal: true

def clicar(el)
  esperar_elemento(el)
    case el['tipo_busca']
    when 'XPATH'
        $driver.find_element(:xpath, el['value']).click
    when 'ID'
        $driver.find_element(:id, el['value']).click
    when 'CLASS'
        $driver.find_element(:class, el['value']).click
    when 'TEXT'
        $driver.find_element(:xpath, "//*[contains(@text,'#{el['value']}')]").click
    end
    $logger.info('Clicou no botão ' + el['value'] + ' usando o tipo de busca' + el['tipo_busca'])
end

def escrever_texto(el, text)
    case el['tipo_busca']
    when 'XPATH'
      element = $driver.find_element(:xpath, el['value'])
    when 'ID'
      element = $driver.find_element(:id, el['value'])
    when 'CLASS'
      element = $driver.find_element(:class, el['value'])
    when 'TEXT'
        element = $driver.find_element(:xpath, "//*[contains(@text,'#{el['value']}')]")
    end
    element.clear
    element.send_keys text
    $logger.info("Preencheu o campo #{el} usando o tipo de busca #{el['tipo_busca']} com o valor #{text}")
end

def esperar_elemento(el)
  case el['tipo_busca']
  when 'XPATH'
    $wait.until {elemento_existente? el}
  when 'ID'
    $wait.until {elemento_existente? el}
  when 'CLASS'
    $wait.until {elemento_existente? el}
  when 'TEXT'
    $wait.until {elemento_existente? el}
  when 'ACCESSIBILITY'
    $wait.until { elemento_existente?(el) }
  end
  $logger.info("Aguardou a existência do elemento #{el['value']} usando o tipo de busca #{el['tipo_busca']}")
end


def elemento_existente?(el, variable = nil)
  begin
    value_with_variable = variable ? el['value'] % variable : el['value']
    case el['tipo_busca']
    when 'XPATH'
      $logger.info("Verificando se existe o elemento #{value_with_variable} usando o tipo de busca XPATH")
      el = $driver.find_elements(:xpath, value_with_variable)
    when 'ID'
      $logger.info("Verificando se existe o elemento #{value_with_variable} usando o tipo de busca ID")
      el = $driver.find_elements(:id, value_with_variable)
    when 'CLASS'
      $logger.info("Verificando se existe o elemento #{value_with_variable} usando o tipo de busca CLASS")
      el = $driver.find_elements(:class, value_with_variable)
    when 'TEXT'
      $logger.info("Verificando se existe o elemento #{value_with_variable} usando o tipo de busca TEXT")
      el = $driver.find_elements(:xpath, "//*[contains(@text,'#{value_with_variable}')]")
    when 'ACCESSIBILITY'
      $logger.info("Verificando se existe o elemento #{value_with_variable} usando o tipo de busca ACCESSIBILITY")
      el = $driver.find_elements(:accessibility_id, value_with_variable)
    else
      raise "Tipo de busca não suportado: #{el['tipo_busca']}"
    end
    return el.count > 0
  rescue Selenium::WebDriver::Error::NoSuchElementError
    return false
  end
end

def esconder_teclado
  if android?
    $driver.hide_keyboard
  elsif ios?
    $driver.hide_keyboard :pressKey
  end
  $logger.info('Fechou o teclado virtual')
end

def android?
  $platform == 'android'
end

def ios?
  $platform == 'ios'
end